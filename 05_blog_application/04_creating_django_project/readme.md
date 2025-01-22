# **Creating Your First Project** 🚀

Your first Django project will be a **blog application**, offering a comprehensive introduction to Django’s capabilities and functionalities. Blogging is an excellent starting point because it covers a wide range of features, including:
- Basic content management 🔄
- Commenting 💬
- Post sharing 🔗
- Search 🔍
- Post recommendations 🔎

The blog project will be developed across the first three chapters of this guide. 📖

## What You'll Build:
- A **list of blog posts** displaying titles, publishing dates, authors, excerpts, and links to the full posts. 🔄
- A **detail view** for each post showing the full content, including the title, publishing date, author, and body. 🖬

<div align="center">
  <img src="./images/posts.jpg" alt="posts" width="400px"/>
</div>

## Setting Up Your Django Project 🔧

To create the initial structure for your Django project, run the following command in your shell:
```bash
django-admin startproject mysite
```

This creates a Django project named `mysite` with the following structure:
```
mysite/
 manage.py
 mysite/
     __init__.py
     asgi.py
     settings.py
     urls.py
     wsgi.py
```

### Project Structure Overview:
- **Outer `mysite/` directory**: The project container. 🏢
- **`manage.py`**: A command-line utility for interacting with your project. (You typically don’t need to edit this file.) 🔀
- **Inner `mysite/` directory**: The Python package containing the following files:
  - **`__init__.py`**: Marks the directory as a Python module. 🌍
  - **`asgi.py`**: Configuration for running the project as an ASGI application with ASGI-compatible web servers. ASGI is the emerging Python standard for asynchronous web servers and applications. 🛠️
  - **`settings.py`**: Contains your project’s settings and default configurations. 🔨
  - **`urls.py`**: Defines URL patterns for your project, mapping each URL to a specific view. 🗺️
  - **`wsgi.py`**: Configuration for running the project as a WSGI application with WSGI-compatible web servers. 🚀

### Important Tips:
- Avoid naming your project after built-in Python or Django modules to prevent conflicts. 🛑

In this chapter, you will:
1. Create the Django project and application for the blog. 🔄
2. Define data models and synchronize them with the database. 📊
3. Set up the Django administration site for managing blog content. 🔧
4. Build views, templates, and URLs. 🔐

> New Section Starts here

# **Applying Initial Database Migrations** 📊

Django applications require a database to store data. The **`settings.py`** file contains the database configuration in the `DATABASES` setting. By default, Django uses an SQLite3 database:
- **SQLite** is bundled with Python 3 and ideal for development.
- For production, use databases like PostgreSQL, MySQL, or Oracle.

More details about database configuration can be found [here](https://docs.djangoproject.com/en/5.0/topics/install/#database-installation).

### Key Settings:
- **`INSTALLED_APPS`**: A list in `settings.py` containing default Django applications. This will be discussed further in the **Project Settings** section.
- **Models**: Data models in Django map to database tables. You’ll create custom models in the **Creating the Blog Data Models** section.

### Applying Initial Migrations:
To set up the default tables in the database:
1. Open your shell prompt and navigate to your project directory:
   ```bash
   cd mysite
   ```
2. Run the migration command:
   ```bash
   python manage.py migrate
   ```
3. You’ll see output like:
   ```
   Applying contenttypes.0001_initial... OK
   Applying auth.0001_initial... OK
   ...
   Applying sessions.0001_initial... OK
   ```
   These lines indicate that the default migrations for the applications listed in `INSTALLED_APPS` have been applied.


# Running the Development Server 🚀

Django includes a lightweight web server for development. This server:
- Automatically reloads upon detecting code changes.
- Logs HTTP requests and errors in the console.

### Starting the Server:
1. Run the following command:
   ```bash
   python manage.py runserver
   ```
   Example output:
   ```
   Watching for file changes with StatReloader
   Performing system checks...
   System check identified no issues (0 silenced).
   January 01, 2024 - 10:00:00
   Django version 5.0, using settings 'mysite.settings'
   Starting development server at http://127.0.0.1:8000/
   Quit the server with CONTROL-C.
   ```
<div align="center">
  <img src="./images/server.jpg" alt="running the server" width="400px"/>
</div>


2. Open **http://127.0.0.1:8000/** in your browser to view the default Django welcome page.

3. Each HTTP request will be logged in the console. For example:
   ```
   [01/Jan/2024 10:00:15] "GET / HTTP/1.1" 200 16351
   ```

### Customizing the Server:
You can specify a custom host, port, or settings file:
```bash
python manage.py runserver 127.0.0.1:8001 --settings=mysite.settings
```

### Important Notes:
- The development server is **not suitable for production use**.
- For production, deploy Django using:
  - **WSGI servers**: Apache, Gunicorn, or uWSGI.
  - **ASGI servers**: Daphne or Uvicorn.

Learn more about deploying Django in production [here](https://docs.djangoproject.com/en/5.0/howto/deployment/wsgi/).

With the development server running, you’re now ready to build and test your Django application! 🌐

> New Section Starts here

# **Project Settings** ⚙️

Let’s explore the **`settings.py`** file to understand the project configuration. This file includes numerous settings that control Django’s behavior. For a complete list of settings and their default values, visit [Django Settings Documentation](https://docs.djangoproject.com/en/5.0/ref/settings/).

### Key Settings Overview:

#### **`DEBUG`**
- **Type**: Boolean
- **Description**: Enables or disables debug mode.
  - **`True`**: Displays detailed error pages when uncaught exceptions occur.
  - **`False`**: Required in production to avoid exposing sensitive data.
- **Important**: Never deploy a site with **`DEBUG=True`** in production.

#### **`ALLOWED_HOSTS`**
- **Type**: List
- **Description**: Specifies the domains/hosts allowed to serve the Django site.
  - Ignored when **`DEBUG=True`** or during tests.
  - Must include your domain/host in production with **`DEBUG=False`**.

#### **`INSTALLED_APPS`**
- **Type**: List
- **Description**: Specifies the active applications for this site.
- **Default Apps**:
  - **`django.contrib.admin`**: Administration site.
  - **`django.contrib.auth`**: Authentication framework.
  - **`django.contrib.contenttypes`**: Content type handling.
  - **`django.contrib.sessions`**: Session management.
  - **`django.contrib.messages`**: Messaging framework.
  - **`django.contrib.staticfiles`**: Static file management (CSS, JavaScript, images).
- **Tip**: For multiple environments, create separate settings files for each configuration.

#### **`MIDDLEWARE`**
- **Type**: List
- **Description**: Specifies middleware to be executed during requests and responses.

#### **`ROOT_URLCONF`**
- **Type**: String
- **Description**: Indicates the Python module where the root URL patterns are defined.

#### **`DATABASES`**
- **Type**: Dictionary
- **Description**: Contains settings for all databases used in the project.
  - The default configuration uses **SQLite3**.

#### **`LANGUAGE_CODE`**
- **Type**: String
- **Description**: Defines the default language for the site.

#### **`USE_TZ`**
- **Type**: Boolean
- **Description**: Activates or deactivates timezone support.
  - Default is **`True`** for projects created with the **`startproject`** command.


If you don’t understand all these settings right now, don’t worry! You’ll learn more about each of them in the upcoming chapters. 😊

