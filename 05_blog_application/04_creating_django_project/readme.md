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

> New Section Starts here

# **Projects and Applications** 🗂️

In Django, the terms **project** and **application** are fundamental:
- A **project** refers to a Django installation with its settings.
- An **application** is a collection of models, views, templates, and URLs that provide specific functionalities. Applications are reusable across multiple projects.

Think of a project as your website, which may contain multiple applications like a blog, wiki, or forum.


## Django Project/Application Structure 🔨

Let’s visualize the structure of a Django project and its applications:

- **Project**: A container for settings and configurations.
- **Application**: Modular units providing functionalities, interacting with the framework.

<div align="center">
  <img src="./images/applications.jpg" alt="Project and Applications" width="400px"/>
</div>

## Creating an Application 🚀

Let’s create our first Django application for a blog. Run the following command from the project’s root directory:
```bash
python manage.py startapp blog
```

This creates the following structure:
```
blog/
├── __init__.py
├── admin.py
├── apps.py
├── migrations/
│   └── __init__.py
├── models.py
├── tests.py
└── views.py
```

### File Descriptions:
- **`__init__.py`**: Marks the directory as a Python module.
- **`admin.py`**: Used to register models for inclusion in the Django admin site (optional).
- **`apps.py`**: Contains the main configuration for the application.
- **`migrations/`**: Directory for database migrations, tracking changes to models and syncing with the database.
  - **`__init__.py`**: An empty file to treat the directory as a module.
- **`models.py`**: Defines the data models for the application. While all Django applications require this file, it can be left empty.
- **`tests.py`**: Contains tests for your application.
- **`views.py`**: Defines the application logic. Each view processes an HTTP request and returns a response.

> New Section Starts here

# **Creating the Blog Data Models** 📝

In Django, a **model** is a Python class that represents a database table. Models are the blueprint for your data and provide a practical API to interact with the database.

Each model:

- Subclasses `django.db.models.Model`.
- Maps to a single database table.
- Has attributes that represent database fields.

When you define a model, Django automatically creates database tables through migrations.


## Creating the Post Model 📂

Let’s define a `Post` model for storing blog posts. Add the following lines to the `models.py` file of the blog application:

```python
from django.db import models

class Post(models.Model):
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    body = models.TextField()

    def __str__(self):
        return self.title
```

### Field Descriptions:

- **`title`**: A `CharField` that translates to a `VARCHAR` column in the database, used for the post title.
- **`slug`**: A `SlugField` that translates to a `VARCHAR` column, containing short, URL-friendly labels (e.g., `django-reinhardt-legend-jazz`). This will be used to create SEO-friendly URLs.
- **`body`**: A `TextField` that translates to a `TEXT` column, used for the main content of the post.

### The `__str__` Method:

The `__str__` method returns a human-readable representation of the object. Django uses this method in places like the administration site to display object names.


## Database Table Correspondence 🔧

<div align="center">
  <img src="./images/tables.jpg" alt="Tables" width="400px"/>
</div>

### Primary Key:

By default, Django adds an **auto-incrementing primary key** field to each model. The default type is `BigAutoField`, a 64-bit integer.

- You can explicitly define a primary key by setting `primary_key=True` on a field.

> New Section Starts here

# **Adding DateTime Fields** ⏰

Let’s enhance the `Post` model by adding datetime fields. Each blog post will have:
- A publication date and time.
- The creation and last modification timestamps (to be added later).

### Updating the `Post` Model:
Edit the `models.py` file of the blog application to include the new `publish` field:

```python
from django.db import models
from django.utils import timezone

class Post(models.Model):
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    body = models.TextField()
    publish = models.DateTimeField(default=timezone.now)  # datetime field

    def __str__(self):
        return self.title
```

### New Field Details:
- **`publish`**:
  - **Type**: `DateTimeField`
  - **SQL Type**: `DATETIME`
  - **Purpose**: Stores the publication date and time of the post.
  - **Default Value**: Uses `timezone.now`, which provides the current datetime in a timezone-aware format.

### Why Use `timezone.now`?
- `timezone.now` is a timezone-aware alternative to the standard `datetime.now`.
- It ensures consistent datetime values across different time zones.


This addition enables you to manage publication dates for blog posts. In the next steps, we’ll add fields for creation and modification timestamps to further track post history! 🚀

> New Section Starts here

# **Another Method for Timezone Defaults** 🕐

Django 5 introduces a new way to define default values for model fields using **database-computed default values**. This allows you to utilize underlying database functions to generate default values.


## Using Database-Computed Default Values:

Here is an example of using the database server’s current date and time as the default for the `publish` field:

```python
from django.db import models
from django.db.models.functions import Now

class Post(models.Model):
    # ...
    publish = models.DateTimeField(db_default=Now())  # change
```

### Key Differences:
- **`db_default`**:
  - Utilizes the database’s native functions to generate default values.
  - In this case, `Now()` calls the database’s `NOW()` function for the current datetime.
- **Comparison to `default`**:
  - `default=timezone.now`: Uses Python’s `timezone.now` to generate the datetime.
  - `db_default=Now()`: Relies on the database’s `NOW()` function.

### Advantages of `db_default`:
- Offloads computation to the database server.
- Ensures consistent defaults across multiple application instances.

### Returning to Python Defaults:
Here’s the previous version of the field, which uses `default=timezone.now`:

```python
class Post(models.Model):
    # ...
    publish = models.DateTimeField(default=timezone.now)  # change
```

Both approaches are valid, and the choice depends on your specific project requirements! 🚀

