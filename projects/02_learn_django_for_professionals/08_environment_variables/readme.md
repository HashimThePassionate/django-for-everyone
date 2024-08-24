# Environment Variables 🌍🔒

**Environment variables** are special variables that are set outside of your code and can be accessed by your application at runtime. They are critical for managing configuration and sensitive information in a secure and flexible way. By using environment variables, you can avoid hard-coding sensitive data like API keys, database credentials, or secret keys directly into your codebase, which is a key principle of the Twelve-Factor App methodology.

## Why Greater Security? 🔐

When you use environment variables, sensitive information like your `SECRET_KEY`, database credentials, or API keys is stored outside your codebase. This has several benefits:

1. **Protection from Exposure**: If you accidentally commit your code to a version control system like Git without using environment variables, your sensitive information could be exposed to anyone who has access to that repository. Even if you later remove the sensitive data, it's still part of the commit history and can be retrieved.

2. **Limiting Access**: By storing sensitive information as environment variables, you can restrict access to it. Only the individuals or systems that need to know this information to run the application will have access to it. This adds a layer of security.

3. **Ease of Change**: When it's time to change your credentials, you can do so without having to modify your codebase. This separation of configuration and code allows you to update sensitive information quickly and securely.

## Simplifying Configuration Management 🛠️

Environment variables also simplify the process of switching between different environments (e.g., development, staging, and production). For example, your application might need to connect to different databases or use different API keys depending on where it's running. By using environment variables, you can easily switch between these configurations without changing the code itself.

### Local vs. Production Environments

Django, for instance, uses different settings that are more lenient and helpful during local development. However, these settings must be tightened for production environments to ensure security and stability. Environment variables help manage these differences without requiring multiple settings files.

## Using Environs 🌱

To manage environment variables in Python, several libraries can be used. For this project, we'll use the `environs` package, which simplifies the process and integrates well with Django. The package allows you to easily define, validate, and access environment variables in your project.

### Installation 🚀

To start using `environs`, you'll need to install it along with some additional Django-specific tools. Update your `requirements.txt` file to include these dependencies:

```text
asgiref==3.8.1
crispy-bootstrap5==0.6
django-crispy-forms==1.14.0
Django==5.1
django-allauth==64.1.0
psycopg2-binary==2.9.9
sqlparse==0.5.1
tzdata==2024.1
requests==2.31.0
environs[django]==9.5.0
PyJWT==2.7.0
cryptography==41.0.3
```

### Rebuilding Your Docker Image

After updating the `requirements.txt` file, you need to stop the current Docker container, rebuild the Docker image to include the new package, and then start the container again. This ensures that the new dependencies are included in your environment.

```bash
docker-compose down -v
docker-compose up -d --build
docker-compose exec web  python manage.py migrate
```

This process is necessary because the Docker image, which acts like a snapshot of your environment, needs to be updated with the new packages.

### Configuring Django to Use Environs 📝

Now that you have `environs` installed, you need to configure your Django project to use it. Start by importing the necessary modules at the top of your `settings.py` file:

```python
# django_project/settings.py
from pathlib import Path
from environs import Env  # new

env = Env()  # new
env.read_env()  # new
```

Here’s what each line does:

- **`from environs import Env`**: Imports the `Env` class from the `environs` package, which provides methods for reading and validating environment variables.
- **`env = Env()`**: Creates an instance of the `Env` class.
- **`env.read_env()`**: Reads the environment variables from a `.env` file or from the environment itself.

## SECRET_KEY 🔑

The `SECRET_KEY` is one of the most critical settings in your Django project. It's used for cryptographic signing, and it should remain confidential. Django automatically generates this key when you create a new project, and it looks something like this:

```python
# django_project/settings.py
SECRET_KEY = "django-insecure-hv1(e0r@v4n4m6gqdz%dn(60o=dsy8&@0_lbs8p-v3u^bs4)xl"
```

### Switching to Environment Variables 🔄

Instead of hard-coding the `SECRET_KEY` in your `settings.py`, we'll move it to an environment variable. This requires two steps:

1. **Add the `SECRET_KEY` to the `.env` file**: This ensures that the key is passed to your application without being exposed in the repository.

2. **Update the `SECRET_KEY` in `settings.py` to use the environment variable**: This tells Django to retrieve the `SECRET_KEY` from the environment instead of the hard-coded value.

#### Example `.env` File:

```bash
# .env
DJANGO_SECRET_KEY=your-secret-key
DJANGO_DEBUG=True
GITHUB_CLIENT_ID=***********************
GITHUB_SECRET=************************
GOOGLE_CLIENT_ID=************************************
GOOGLE_SECRET=**************************************
```

#### Update `docker-compose.yml` to Use the `.env` File:

```yaml
services:
  web:
    build: .
    command: python /code/manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/code
    ports:
      - 8000:8000
    depends_on:
      - db
    env_file:
      - .env
  db:
    image: postgres:13
    volumes:
      - postgres_data:/var/lib/postgresql/data/
    environment:
      - "POSTGRES_HOST_AUTH_METHOD=trust"
volumes:
  postgres_data:
```

### Important Considerations

- **Dollar Signs in Keys**: If your `SECRET_KEY` contains a dollar sign (`$`), you need to escape it by using two dollar signs (`$$`). This is due to how Docker Compose handles environment variable substitution.
  
Next, update the `SECRET_KEY` in `settings.py`:

```python
# django_project/settings.py
SECRET_KEY = env("DJANGO_SECRET_KEY")
```

This line tells Django to look for the `DJANGO_SECRET_KEY` environment variable and use it as the `SECRET_KEY`.

### Restarting the Docker Container 🔄

After making these changes, you need to restart the Docker container for the new environment variables to take effect:

```bash
docker-compose down
docker-compose up -d
```

This ensures that Django is now using the environment variable for the `SECRET_KEY`.

## DEBUG and ALLOWED_HOSTS 🔍🔒

Django’s `DEBUG` setting controls whether detailed error messages are shown when an error occurs. While it’s useful during development, it can expose sensitive information in a production environment.

### Configuring DEBUG and ALLOWED_HOSTS

Set `DEBUG` to `False` for production to hide detailed error messages. You also need to configure `ALLOWED_HOSTS`, which restricts the domains that can access your Django application.

Update your `settings.py` like this:

```python
# django_project/settings.py
DEBUG = False  # new
ALLOWED_HOSTS = [".herokuapp.com", "localhost", "127.0.0.1"]  # new
```

### Explanation

#### 1. `DEBUG` Setting 🔍

```python
# django_project/settings.py
DEBUG = False  # new
```

The `DEBUG` setting in Django is like a **switch** 🔄 that controls whether Django's **debug mode** is on or off. It's super important because it decides how Django will handle and display errors.

- **When `DEBUG = True`:** 
  - 🛠️ **Detailed Error Pages**: Django shows detailed error pages with all the technical info you need during development. This helps you fix issues faster.
  - 🎨 **Static Files Serving**: Django will handle static files like CSS, JS, and images directly. Perfect for quick front-end updates during development.
  - 🔄 **No Caching**: Changes are shown immediately, making development smooth and fast.

- **When `DEBUG = False`:**
  - 🔒 **Generic Error Pages**: Instead of detailed error info, users only see a simple error page, which keeps your app secure from prying eyes.
  - 🚫 **No Static File Serving**: In production, static files are served by a powerful web server like Nginx, not by Django itself.
  - ⚡ **Caching Enabled**: With caching on, your site runs faster and can handle more traffic!

#### Why Set `DEBUG = False` in Production? 🛡️

- **Security First**: When `DEBUG` is `True`, error pages can reveal sensitive info like environment variables or stack traces. Hackers can use this to find weaknesses. 😱
- **Boost Performance**: `DEBUG = False` allows Django to use optimizations that make your app faster

 and more scalable. ⚡
- **Professional Static File Handling**: In production, a dedicated web server takes care of static files, ensuring everything loads smoothly. 🚀

#### 2. `ALLOWED_HOSTS` Setting 🌐

```python
# django_project/settings.py
ALLOWED_HOSTS = [".herokuapp.com", "localhost", "127.0.0.1"]  # new
```

The `ALLOWED_HOSTS` setting is like a **VIP list** 📝 that tells Django which host/domain names are allowed to access your app.

- **🛡️ Preventing Host Header Attacks**: This setting is a security measure that protects your app from Host Header attacks, where attackers try to send requests with fake host headers.
- **🚧 Limiting Access**: Only requests from the hosts listed here will be allowed. If a request comes from an unknown host, Django blocks it with a "Bad Request (400)" response.

#### Why Configure `ALLOWED_HOSTS`? 🛠️

- **Keep Out Intruders**: By specifying which hosts are allowed, you make sure that only requests from trusted domains are accepted. 🔐
- **Prevent Security Breaches**: This setting helps protect your app from certain types of attacks that could expose sensitive data or allow unauthorized access. 🚫

#### Example Configuration:

- **`".herokuapp.com"`**: Allows any subdomain on Heroku, perfect for apps hosted there. 🌐
- **`"localhost"` and `"127.0.0.1"`**: Allows access from your local machine, great for testing and development. 💻

In production, it’s better to control the `DEBUG` setting with an environment variable:

```python
# django_project/settings.py
DEBUG = env.bool("DJANGO_DEBUG")  # new
```

Then, update your `docker-compose.yml` to include this variable:

```yaml
version: '3.9'
services:
  web:
    build: .
    command: python /code/manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/code
    ports:
      - 8000:8000
    depends_on:
      - db
    env_file:
      - .env  # Load environment variables from the .env file
  db:
    image: postgres:13
    volumes:
      - postgres_data:/var/lib/postgresql/data/
    environment:
      - "POSTGRES_HOST_AUTH_METHOD=trust"
volumes:
  postgres_data:
```

### Why This Matters

- **DEBUG Mode**: In production, you should always set `DEBUG` to `False` to prevent exposing sensitive information through error messages.
- **ALLOWED_HOSTS**: This setting helps prevent HTTP Host header attacks, which are a type of web security vulnerability.

## DATABASES Configuration 🗄️

To connect to your PostgreSQL database, you can set up the `DATABASES` configuration using `environs`. Here's how you can configure your database using either a database URL or manual environment variables:

### 1. Using a Database URL with `env.dj_db_url` 🌐

This method allows you to define your entire database connection string using a single environment variable, which is especially convenient for production environments.

```python
# django_project/settings.py

DATABASES = {
    "default": env.dj_db_url(
        "DATABASE_URL", 
        default="postgres://postgres:postgres@db:5432/postgres"
    )
}
```

#### Explanation:

- **`env.dj_db_url`**: This method parses the `DATABASE_URL` environment variable and converts it into a dictionary that Django can use to configure the database connection.
- **Default Value**: If the `DATABASE_URL` environment variable is not set, the default value `"postgres://postgres:postgres@db:5432/postgres"` is used, which defines the database connection details (engine, name, user, password, host, and port).

### 2. Manual Configuration Using Environment Variables 🛠️

Alternatively, if you prefer to manually configure each component of the database connection, you can do so like this:

```python
# django_project/settings.py

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",  # Database engine
        "NAME": env("DB_NAME", default="postgres"),  # Database name
        "USER": env("DB_USER", default="postgres"),  # Database user
        "PASSWORD": env("DB_PASSWORD", default="postgres"),  # Database password
        "HOST": env("DB_HOST", default="db"),  # Database host
        "PORT": env("DB_PORT", default="5432"),  # Database port
    }
}
```

#### Explanation:

- **`ENGINE`**: Specifies the backend to use. In this case, it's PostgreSQL.
- **`NAME`**: The name of your database. This can be set via an environment variable `DB_NAME`.
- **`USER`**: The username for accessing the database, which is set via the `DB_USER` environment variable.
- **`PASSWORD`**: The password for the database user, set via the `DB_PASSWORD` environment variable.
- **`HOST`**: The hostname of the database server. If you're using Docker, this is often set to `db` (the name of your database service in `docker-compose.yml`).
- **`PORT`**: The port on which the database server is listening, typically `5432` for PostgreSQL.

### Example `.env` File:

If you're using the manual configuration, you can set these environment variables in your `.env` file:

```bash
# .env
DATABASE_URL=postgres://postgres:postgres@db:5432/postgres
DB_NAME=postgres
DB_USER=postgres
DB_PASSWORD=postgres
DB_HOST=db
DB_PORT=5432
```

### Which One to Use?

- **Use `env.dj_db_url`** if you prefer a simpler, single environment variable approach.
- **Use Manual Configuration** if you need to customize or manage each part of the database configuration separately.

### Git Commit 💾

Once you’ve made all these changes, it’s important to commit your code to your version control system:

```bash
git status
git add .
git commit -m 'Environment Variables And Database Configuration'
```

This ensures that your changes are tracked and you can roll back if needed.

### Adding the `.env` File to `.gitignore` 🚫

Make sure your `.env` file is not tracked by Git by adding it to your `.gitignore` file:

```bash
# .gitignore
.env
```

This prevents the `.env` file from being committed to your repository, keeping your sensitive information secure.

### If You’ve Already Committed Sensitive Information 🛑

If you’ve already committed sensitive information to your repository, you should:

1. **Rotate the Keys**: Immediately change the exposed keys (e.g., regenerate API keys, change passwords).
2. **Remove the Sensitive Information**: Use Git tools to remove the sensitive information from the commit history. Tools like [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/) or Git’s filter-branch can help with this.
3. **Force Push**: After removing the sensitive information, force push the cleaned repository.

## Conclusion 🎉

In this section, we covered how to securely manage sensitive information and configuration using environment variables. This approach not only improves security but also makes it easier to switch between different environments, such as development and production. We also detailed how to set up your PostgreSQL database configuration using environment variables, providing you with the flexibility to choose between using a database URL or manually configuring each component. In the next section, we’ll move on to configuring email settings and adding password reset functionality.