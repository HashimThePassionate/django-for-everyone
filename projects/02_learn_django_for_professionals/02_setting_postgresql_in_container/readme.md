# PostgreSQL within Container

🎉 **Welcome to the PostgreSQL Section!** 🎉

One of the significant differences between working on a simple "toy app" in Django and a production-ready application is the choice of the database. While Django ships with SQLite as the default database for local development, which is small, fast, and file-based, it’s not a suitable choice for professional websites. Let's dive into why PostgreSQL is the preferred choice and how to set it up in a Django project.

## 🌍 **Why PostgreSQL?**

Django supports multiple databases, including PostgreSQL, MariaDB, MySQL, Oracle, and SQLite. However, PostgreSQL is the most popular choice among Django developers for production environments. The beauty of Django’s ORM (Object-Relational-Mapper) is that it abstracts away much of the database-specific SQL, allowing you to switch between different databases with minimal changes to your code.

### **Why Not SQLite for Production?**

SQLite is perfect for prototyping and small-scale projects because it requires no additional setup. However, it’s not ideal for production due to its limitations in handling multiple users, transactions, and scalability. For professional websites, a more robust database like PostgreSQL is recommended.

📌 [Django Supported Databases](https://docs.djangoproject.com/en/5.1/ref/databases/#databases)

📌 [PostgreSQL Official Website](https://www.postgresql.org/)

In this section, we'll start with a Django project using SQLite and then transition to using Docker and PostgreSQL to mimic a production environment.

## 🛠️ **Django Set Up**

First, ensure you're in the correct directory on your command line.

### **Navigate to Your Project Directory:**

1. **Windows:**

   ```shell
   cd onedrive\desktop
   mkdir setting_postgresql
   ```

2. **macOS:**

   ```shell
   cd ~/desktop/code
   mkdir setting_postgresql
   ```

### **Create a New Django Project:**

1. **Set Up a new Virtual Environment and activate (using pipenv):**

   ```shell
   pipenv install
   pipenv shell
   ```

   *Explanation:* This command installs a new virtual environment and then activates it.

2. **Install Django in the Virtual Environment:**

   ```shell
   pipenv install django==5.0.7
   ```

   *Explanation:* This command installs Django within the virtual environment using pipenv.

3. **Create the Django Project:**

   ```shell
   django-admin startproject django_project .
   ```

   *Explanation:* The `startproject` command creates a new Django project called `django_project`. The `.` at the end tells Django to create the project in the current directory instead of creating a new subdirectory.

4. **Apply Migrations and Start the Server:**

   ```shell
   python manage.py migrate
   python manage.py runserver
   ```

   *Explanation:* 
   - The `migrate` command applies database migrations to set up the initial database schema (like tables for users and sessions).
   - The `runserver` command starts the Django development server, which by default runs at `http://127.0.0.1:8000/`.

💡 **Tip:** Normally, it's better to configure a custom user model before running migrations. However, for demonstration purposes, we'll use the default User model in this section.

### **Confirm the Django Setup:**

Navigate to `http://127.0.0.1:8000/` in your browser to see the Django welcome page.

### **Create a `Pipfile` and `Pipfile.lock`:**

Generate the `Pipfile` and `Pipfile.lock` to keep track of dependencies:

```shell
pipenv lock
```

*Explanation:* This command creates a `Pipfile.lock` which is a snapshot of all installed dependencies with specific versions, ensuring that the same environment can be replicated.

### **Generate `requirements.txt` for Docker:**

While pipenv is great for local development, we often use `requirements.txt` in Docker to install dependencies directly with pip.

```shell
pip freeze > requirements.txt
```

*Explanation:* This command generates a `requirements.txt` file from the Pipfile.lock, listing all the dependencies so they can be installed using pip in Docker.

## 🐳 **Switching to Docker**

To switch over to Docker, we’ll create a Dockerfile and a `docker-compose.yml` file.

### **Deactivate the Virtual Environment:**

```shell
deactivate
```

*Explanation:* Deactivating the virtual environment ensures that the environment is no longer active, and you're back to your system's default Python environment.

### **Create a Dockerfile:**

The Dockerfile will define the environment for your Django project.

```Dockerfile
# Pull base image
FROM python:3.12-slim

# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK 1
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set work directory
WORKDIR /code

# Install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Copy project
COPY . .
```

**Explanation of the Dockerfile:**

1. **`FROM python:3.12-slim`**: This line specifies the base image to use, which is a slim version of Python 3.12. The `slim` variant is smaller and more efficient, reducing the overall image size.

2. **`ENV PIP_DISABLE_PIP_VERSION_CHECK 1`**: This environment variable disables pip's automatic version check, which can speed up the build process.

3. **`ENV PYTHONDONTWRITEBYTECODE 1`**: This prevents Python from writing `.pyc` files, which are unnecessary in a containerized environment.

4. **`ENV PYTHONUNBUFFERED 1`**: This ensures that Python's output is not buffered, which is useful for logging in real-time.

5. **`WORKDIR /code`**: This sets the working directory for subsequent instructions to `/code`. Any commands run after this will be executed in this directory.

6. **`COPY ./requirements.txt .`**: This copies the `requirements.txt` file from your local machine to the Docker image's working directory.

7. **`RUN pip install -r requirements.txt`**: This installs the dependencies listed in the `requirements.txt` file inside the Docker image.

8. **`COPY . .`**: This copies all the files from your local project directory to the Docker image's working directory.

### **Create a `.dockerignore` File:**

This file will exclude unnecessary files from being copied into the Docker image.

```plaintext
Pipfile
Pipfile.lock
.git
.gitignore
```

*Explanation:* By specifying these files in `.dockerignore`, they will not be included in the Docker image, reducing its size and preventing potential issues.

### **Build the Docker Image:**

Build the Docker image with a tag:

```shell
docker build -t my-django-app:1.0 .
```

*Explanation:* 
- `docker build -t my-django-app:1.0 .` builds the Docker image from the current directory (`.`) and tags it with the name `my-django-app` and the tag `1.0`. 
- The `-t` option is used to assign a name and tag to the image, making it easier to reference the image later, especially when deploying or running containers.

### **Create a `docker-compose.yml` File:**

The `docker-compose.yml` file defines how to run the Docker containers.

```yaml
version: "3.9"
services:
  web:
    build: .
    command: python /code/manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/code
    ports:
      - "8000:8000"
```

**Explanation of the `docker-compose.yml` File:**

1. **`version: "3.9"`**: This specifies the version of Docker Compose being used. Version 3.9 is one of the most recent versions.

2. **`services:`**: This section defines the different services that will run in your Docker containers. In this case, we only have one service called `web`.

3. **`build: .`**: This tells Docker Compose to build the image using the `Dockerfile` located in the current directory.

4. **`command: python /code/manage.py runserver 0.0.0.0:8000`**: This command runs the Django development server inside the Docker container, listening on all network interfaces (`0.0.0.0`) on port 8000.

5. **`volumes: - .:/code`**: This mounts the current directory on your local machine to the `/code` directory inside the Docker container, ensuring that any changes made locally are reflected inside the container.

6. **`ports: - "8000:8000"`**: This maps port 8000 on the Docker container to port 8000 on your local machine, allowing you to access the Django development server at `http://127.0.0.1:8000/`.

### **Run the Docker Container in Detached Mode:**

Detached mode allows you to run Docker in the background.

```shell
docker-compose up -d
```

*Explanation:* The `-d` or `--detach` flag runs the Docker containers in the background, allowing you to use the same terminal for other tasks. To

 check logs or debug any issues, you can use:

```shell
docker-compose logs
```

### **Access the Django Admin:**

You can still access the Django admin by creating a superuser:

```shell
docker-compose exec web python manage.py createsuperuser
```

*Explanation:* The `docker-compose exec` command allows you to run commands inside the running container. In this case, you're creating a superuser for the Django admin.

### **Handling Issues on M1 Macs:**

If you encounter issues on M1-based Macs, such as a `SCRAM authentication requires libpq version 10 or above` error, update your Dockerfile:

```Dockerfile
# Pull base image
FROM --platform=linux/amd64 python:3.12-slim
```

*Explanation:* This line specifies that Docker should emulate an AMD64 architecture, which is necessary for compatibility with certain software on M1 Macs.

## 🗄️ **Integrating PostgreSQL**

Now that Docker is running, let's integrate PostgreSQL into our project.

### **Install PostgreSQL Adapter (Psycopg2):**

Psycopg is the most popular PostgreSQL adapter for Python. To install it:

1. **Stop the Docker Container:**

   ```shell
   docker-compose down
   ```

   *Explanation:* This command stops the running Docker containers and removes them, freeing up system resources.

2. **Add Psycopg2 to `requirements.txt`:**

   Edit the `requirements.txt` file to include:

   ```plaintext
   psycopg2-binary==2.9.3
   ```

   *Explanation:* This ensures that the PostgreSQL adapter is installed when building the Docker image.

### **Update `docker-compose.yml` to Include PostgreSQL:**

Add a new `db` service in your `docker-compose.yml`:

```yaml
version: "3.9"
services:
  web:
    build: .
    command: python /code/manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/code
    ports:
      - "8000:8000"
    depends_on:
      - db

  db:
    image: postgres:13
    volumes:
      - postgres_data:/var/lib/postgresql/data/
    environment:
      - "POSTGRES_HOST_AUTH_METHOD=trust"

volumes:
  postgres_data:
```

**Explanation of the `docker-compose.yml` File:**

1. **`db:`**: This section defines the PostgreSQL database service.

2. **`image: postgres:13`**: This specifies the Docker image to use for the PostgreSQL service. We're using PostgreSQL version 13.

3. **`volumes: - postgres_data:/var/lib/postgresql/data/`**: This volume mounts the PostgreSQL data directory to ensure that data is persisted even if the container stops.

4. **`environment: - "POSTGRES_HOST_AUTH_METHOD=trust"`**: This environment variable configures PostgreSQL to use trust authentication, which simplifies the setup for local development.

5. **`depends_on:`**: This line in the `web` service specifies that the `db` service must be running before the `web` service starts.

### **Configure Django to Use PostgreSQL:**

Update the `DATABASES` configuration in `django_project/settings.py`:

```python
# django_project/settings.py
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "postgres",
        "USER": "postgres",
        "PASSWORD": "postgres",
        "HOST": "db",  # set in docker-compose.yml
        "PORT": 5432,  # default postgres port
    }
}
```

**Explanation of the `DATABASES` Configuration:**

1. **`ENGINE`:** This specifies the database backend to use. We're switching from SQLite (`django.db.backends.sqlite3`) to PostgreSQL (`django.db.backends.postgresql`).

2. **`NAME`, `USER`, `PASSWORD`:** These are the default PostgreSQL credentials we've set up in our Docker configuration.

3. **`HOST`:** The `HOST` is set to `db`, which corresponds to the name of the PostgreSQL service in our `docker-compose.yml`.

4. **`PORT`:** This is the default port for PostgreSQL, set to 5432.

### **Build and Run the Docker Containers:**

Rebuild the Docker image and run the containers:

```shell
docker-compose up -d --build
```

*Explanation:* The `--build` flag forces a rebuild of the Docker image, incorporating any changes, such as the addition of `psycopg2-binary` to `requirements.txt`.

### **Check the New Database:**

If you try to access the Django admin again, you’ll notice that the previous superuser no longer exists because we switched from SQLite to PostgreSQL.

1. **Migrate the Database:**

   ```shell
   docker-compose exec web python manage.py migrate
   ```

   *Explanation:* This command applies migrations to the PostgreSQL database, setting up the necessary tables and schema.

2. **Create a New Superuser:**

   ```shell
   docker-compose exec web python manage.py createsuperuser
   ```

   *Explanation:* This command creates a new superuser for the Django admin in the PostgreSQL database. Use `postgresqladmin`, `postgresqladmin@email.com`, and `testpass123` as credentials for testing.

### **Access the Updated Admin:**

Navigate to `http://127.0.0.1:8000/admin/` and log in with the new credentials.

## 📝 **Saving Your Work with Git**

### **Initialize a Git Repository:**

```shell
git init
```

*Explanation:* Initializes a new Git repository in your project directory, allowing you to track changes and manage versions of your code.

### **Create a `.gitignore` File:**

```plaintext
Pipfile
Pipfile.lock
__pycache__/
db.sqlite3
.DS_Store  # Mac only
```

*Explanation:* The `.gitignore` file specifies files and directories that Git should ignore. This is useful for excluding files that are not necessary to track, such as virtual environment files or local database files.

### **Commit Your Changes:**

```shell
git add .
git commit -m 'ch3'
```

*Explanation:* 
- `git add .` stages all changes for the commit.
- `git commit -m 'ch3'` commits the staged changes with a message describing the commit.

### **Official Source Code:**

You can compare your work with the official source code available on GitHub.

## 🎯 **Conclusion**

The goal of this section was to demonstrate how to integrate Docker and PostgreSQL into a Django project. Transitioning from SQLite to PostgreSQL is a crucial step in moving towards a production-ready environment. Remember, Docker now serves as our virtual environment and database, replacing the need for local configurations.

In the next section, we'll begin our online Bookstore project using the tools and concepts we've covered so far. Let’s dive in! 📚