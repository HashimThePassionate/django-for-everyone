# 📚 Bookstore Project

Welcome to the **Bookstore Project**! In this section, we'll embark on building an online bookstore. This project includes setting up a Django project, transitioning to Docker, implementing a custom user model, and writing initial tests.

---

## 🏗️ Project Setup

### 1. **Creating the Project Directory and Virtual Environment**

Start by creating a new directory for the project on your desktop, and then set up a new Python virtual environment using `pipenv`.

```bash
# Windows
cd onedrive\desktop
mkdir bookstore
cd bookstore
pipenv install
pipenv shell
pipenv install django==5.0.7
pipenv install psycopg2-binary==2.9.9
```

### 2. **Starting the Django Project**

Next, we create a new Django project called `django_project`. Make sure to include the period (`.`) at the end of the command to avoid creating unnecessary directories.

```bash
django-admin startproject django_project .
python manage.py runserver
```

In your web browser, navigate to `http://127.0.0.1:8000/`, where you should see the Django welcome page! 🎉

> **Note:** You may see a warning about "18 unapplied migration(s)" on the command line. It's safe to ignore this for now since we'll be switching over to Docker and PostgreSQL shortly.

### 3. **Creating the `requirements.txt` File**

Stop the local server using `Control+c` and create a `requirements.txt` file containing the current dependencies of your Python environment.

```bash
pip freeze > requirements.txt
```

Your `requirements.txt` file should include the following packages:

```plaintext
asgiref==3.8.1
Django==5.1
psycopg2-binary==2.9.9
sqlparse==0.5.1
tzdata==2024.1
```

---

## 🐳 Docker Setup

We'll now switch over to Docker for our project. Make sure Docker is installed and running on your desktop. You'll need to create a `Dockerfile` and a `docker-compose.yml` file in your project’s root directory, next to `manage.py`.

### 1. **Creating Docker Configuration Files**

Create the following files in your text editor:

#### **Dockerfile**

```dockerfile
# Pull base image
FROM python:3.12-slim-bullseye

# Set environment variables
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /code

# Install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Copy project
COPY . .
```

### 🐳 **Understanding the Dockerfile Step by Step**

#### 1. **Pulling the Base Image 📦**
```dockerfile
FROM python:3.12-slim-bullseye
```
- **FROM**: This line tells Docker to use a specific base image. Think of it as the starting point for your application.
- **python:3.10.4-slim-bullseye**: This is the base image that comes with Python 3.10.4 on a slimmed-down version of Debian Bullseye. It's lightweight, which means it has only what's necessary to run Python efficiently.

#### 2. **Setting Environment Variables 🌍**
```dockerfile
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
```
- **ENV**: This command sets environment variables, which are like settings for your Python environment.
  - **PIP_DISABLE_PIP_VERSION_CHECK=1**: Disables the version check when using pip, speeding up the installation process.
  - **PYTHONDONTWRITEBYTECODE=1**: Stops Python from writing `.pyc` files, which are compiled Python files. This keeps your environment clean.
  - **PYTHONUNBUFFERED=1**: Ensures that the output from Python is printed directly to the terminal, without being buffered. This makes it easier to see logs in real-time.

#### 3. **Setting the Work Directory 🛠️**
```dockerfile
WORKDIR /code
```
- **WORKDIR**: This sets the working directory inside the Docker container. 
- **/code**: It's like telling Docker, "Hey, this is where we're going to put our project files." All subsequent commands will be run in this directory.

#### 4. **Installing Dependencies 📜**
```dockerfile
COPY ./requirements.txt .
RUN pip install -r requirements.txt
```
- **COPY ./requirements.txt .**: This copies the `requirements.txt` file from your computer (or wherever you are building the Docker image) into the Docker container's working directory.
- **RUN pip install -r requirements.txt**: This command installs all the Python dependencies listed in the `requirements.txt` file. It’s like setting up all the tools your project needs to run.

#### 5. **Copying the Project Files 📁**
```dockerfile
COPY . .
```
- **COPY . .**: This command copies all the files from your current directory on your computer into the Docker container's `/code` directory. It's like moving all your project files into the container so that it can run your application.

#### **docker-compose.yml**

```yaml
version: "3.9"
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
  db:
    image: postgres:13
    volumes:
      - postgres_data:/var/lib/postgresql/data/
    environment:
      - "POSTGRES_HOST_AUTH_METHOD=trust"

volumes:
  postgres_data:
```

### 🐳 **Breaking Down the Docker Compose File Step by Step**

#### 1. **Setting the Version 📅**
```yaml
version: "3.9"
```
- **version:** This specifies the version of Docker Compose being used. Version 3.9 is a modern, stable version that supports a wide range of features.

#### 2. **Defining the Services 🛠️**
- **services:** This section is where you define the different parts (services) of your application. Each service runs in its own container.

##### **Service 1: `web` 🌐**

```yaml
web:
  build: .
  command: python /code/manage.py runserver 0.0.0.0:8000
  volumes:
    - .:/code
  ports:
    - 8000:8000
  depends_on:
    - db
```

- **web:** This is the name of the service. It's like a tag for this part of your application.
- **build: .**: Tells Docker to build the `web` service using the Dockerfile in the current directory (`.`). It’s like setting up the environment for this service.
- **command:** Specifies the command to run when the container starts. Here, it’s running the Django development server: `python /code/manage.py runserver 0.0.0.0:8000`.
- **volumes:** 
  - `- .:/code`: This mounts your current directory (`.`) on your host machine to the `/code` directory inside the container. This means any changes you make on your host will be reflected inside the container instantly.
- **ports:** 
  - `- 8000:8000`: This maps port `8000` on your host machine to port `8000` inside the container. It allows you to access the web service from your browser by going to `http://localhost:8000`.
- **depends_on:**
  - `- db`: Indicates that the `web` service depends on the `db` service. Docker Compose ensures the `db` service is started before the `web` service.

##### **Service 2: `db` 🗄️**

```yaml
db:
  image: postgres:13
  volumes:
    - postgres_data:/var/lib/postgresql/data/
  environment:
    - "POSTGRES_HOST_AUTH_METHOD=trust"
```

- **db:** This is the name of the database service.
- **image: postgres:13**: Specifies the Docker image to use for the service. Here, it's pulling the PostgreSQL version 13 image from Docker Hub.
- **volumes:** 
  - `- postgres_data:/var/lib/postgresql/data/`: This mounts a named volume `postgres_data` to store the database data in the `/var/lib/postgresql/data/` directory inside the container. It ensures your data persists even if the container stops or is removed.
- **environment:** 
  - **POSTGRES_HOST_AUTH_METHOD=trust**: Sets an environment variable that configures PostgreSQL to trust all connections. This is useful for development but should be handled carefully in production environments.

#### 3. **Defining Volumes 🗂️**

```yaml
volumes:
  postgres_data:
```
- **volumes:** This section is where named volumes are defined. 
  - **postgres_data:** A named volume to persist the database data. This ensures that your database data is not lost when containers are rebuilt or restarted.
---

### 2. **Creating `.dockerignore` and `.gitignore` Files**

Before building the Docker image, create a `.dockerignore` file and a `.gitignore` file to exclude unnecessary files:

#### **.dockerignore**

```plaintext
Pipfile/
Pipfile.lock/
db.sqlite3
.git
```

#### **.gitignore**

```plaintext
Pipfile/
Pipfile.lock/
db.sqlite3
```

### 3. **Building and Running Docker Containers**

Now, let's build the Docker image and run the containers using the following command:

```bash
docker-compose up -d --build
```

Visit `http://127.0.0.1:8000/` in your browser to see the Django welcome page, now running inside Docker! 🐳

---

## 🗄️ Configuring PostgreSQL

Even though we've installed `psycopg2-binary` and included PostgreSQL in our `docker-compose.yml` file, we still need to update Django's settings to use PostgreSQL.

### 1. **Updating the Database Configuration**

In `django_project/settings.py`, replace the default SQLite configuration with the following PostgreSQL settings:

```python
# django_project/settings.py

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.postgresql",
        "NAME": "postgres",
        "USER": "postgres",
        "PASSWORD": "postgres",
        "HOST": "db",
        "PORT": 5432,
    }
}
```

### 2. **Verifying the Setup**

After updating the settings, refresh your browser to confirm that the project is still working correctly.

---

## 👤 Implementing a Custom User Model

Django recommends starting with a custom user model from the beginning to avoid complications later on. We’ll create a custom user model using `AbstractUser`, which is simpler and keeps the default user fields and permissions.

### 1. **Creating the Custom User Model**

Create a new app named `accounts` for the custom user model:

```bash
docker-compose exec web python manage.py startapp accounts
```

In `accounts/models.py`, define the `CustomUser` model:

```python
# accounts/models.py

from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    pass
```

### 2. **Updating `settings.py`**

Add the `accounts` app to `INSTALLED_APPS` and set the `AUTH_USER_MODEL` to our custom user model:

```python
# django_project/settings.py

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # Local
    "accounts, # new
]

AUTH_USER_MODEL = 'accounts.CustomUser' # new
```

### 3. **Creating and Applying Migrations**

Create the migration file for the changes and then apply the migrations:

```bash
docker-compose exec web python manage.py makemigrations accounts
docker-compose exec web python manage.py migrate
```

You should see the migration files created and applied successfully.

---

## 📝 Custom User Forms

Next, we'll update the default user forms (`UserCreationForm` and `UserChangeForm`) to use the custom user model.

### 1. **Creating Custom Forms**

In `accounts/forms.py`, define the custom forms:

```python
# accounts/forms.py

from django.contrib.auth import get_user_model
from django.contrib.auth.forms import UserCreationForm, UserChangeForm

class CustomUserCreationForm(UserCreationForm):
    class Meta:
        model = get_user_model()
        fields = ("email", "username")

class CustomUserChangeForm(UserChangeForm):
    class Meta:
        model = get_user_model()
        fields = ("email", "username")
```

### 📝 **Understanding the Custom User Forms in Django**

In a Django project, forms are a crucial part of handling user input, particularly for tasks like user registration and updating user details. The code you’ve provided defines two custom forms for these purposes. Let's break down what each form does and how it works.

#### 🔧 **CustomUserCreationForm**

```python
from django.contrib.auth import get_user_model
from django.contrib.auth.forms import UserCreationForm

class CustomUserCreationForm(UserCreationForm):
    class Meta:
        model = get_user_model()
        fields = ("email", "username")
```
##### **What is it?**
- **CustomUserCreationForm**: This form is specifically designed to handle the creation of new users. It inherits from Django’s built-in `UserCreationForm`, which already provides the basic functionality for registering new users, such as password validation and confirmation.

##### **Key Components:**
- **`get_user_model()`**: This is a function that returns the currently active user model in your project, which could be a custom user model if you've defined one.
- **`Meta class`**: Inside the `Meta` class, you specify:
  - **`model`**: This points to the user model returned by `get_user_model()`.
  - **`fields`**: These are the fields that will be included in the form. In this case, only the `email` and `username` fields are exposed for user creation.

##### **How does it work?**
- When a user fills out this form and submits it, Django will automatically handle the creation of a new user using the specified fields (email and username). The form also ensures that the password fields (inherited from `UserCreationForm`) are included, even though they’re not explicitly listed in `fields`.

#### 🔄 **CustomUserChangeForm**

```python
from django.contrib.auth import get_user_model
from django.contrib.auth.forms import UserChangeForm

class CustomUserChangeForm(UserChangeForm):
    class Meta:
        model = get_user_model()
        fields = ("email", "username")
```
##### **What is it?**
- **CustomUserChangeForm**: This form is used when an existing user needs to update their profile information, such as changing their email or username. It inherits from Django’s `UserChangeForm`, which provides the framework for updating user data.

##### **Key Components:**
- **`get_user_model()`**: Similar to the `CustomUserCreationForm`, this retrieves the active user model.
- **`Meta class`**:
  - **`model`**: Again, this points to the user model.
  - **`fields`**: Only `email` and `username` are exposed for updates, allowing users to modify these fields.

##### **How does it work?**
- When a user accesses their profile to make changes, this form will present the fields defined (`email` and `username`) for editing. The form takes care of validating the inputs and updating the user's information in the database.

### 🎨 **Why Customize These Forms?**

By creating these custom forms, you gain full control over the user creation and update processes. You can decide which fields are available to the user, enforce specific validation rules, and even customize the look and feel of the forms if needed. This is particularly useful in projects where the default user model has been extended with additional fields or functionality.

### 🚀 **Summary**

- **CustomUserCreationForm**: Manages user registration with `email` and `username` fields.
- **CustomUserChangeForm**: Handles profile updates, allowing users to change their `email` and `username`.

Both forms rely on your custom user model and ensure that the correct fields are available for user creation and updating, making them essential tools in managing user data in your Django application. 🌟

> **Note:** We import the custom user model using `get_user_model()` to ensure the correct model is referenced according to the `AUTH_USER_MODEL` setting.

#### 🔍 **What This Means:**

- **`AUTH_USER_MODEL` Setting:** In Django, you can specify a custom user model using the `AUTH_USER_MODEL` setting in `settings.py`.

- **`get_user_model()` Function:** Instead of directly importing a user model, using `get_user_model()` dynamically retrieves the correct user model based on the `AUTH_USER_MODEL` setting. 

#### 🚀 **Why Use It:**
- **Flexibility:** Adapts automatically if the user model changes.
- **Consistency:** Ensures all parts of your app use the correct model without needing to change imports.
- **Avoids Hardcoding:** Keeps your code adaptable and clean.

Using `get_user_model()` ensures your forms and other components always reference the correct user model, making your code more robust and future-proof. 🌟


### 2. **Updating the Admin Interface**

Update the `accounts/admin.py` file to manage the custom user model in the admin interface:

```python
# accounts/admin.py

from django.contrib import admin
from django.contrib.auth import get_user_model
from django.contrib.auth.admin import UserAdmin

from .forms import CustomUserCreationForm, CustomUserChangeForm

CustomUser = get_user_model()

class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = ["email", "username", "is_superuser"]

admin.site.register(CustomUser, CustomUserAdmin)
```

---

## 🔐 Creating a Superuser

To verify that the custom user model is working correctly, create a superuser account:

```bash
docker-compose exec web python manage.py createsuperuser
```

You can use any username, email, and password you prefer. After creating the superuser, log in to the Django admin at `http://127.0.0.1:8000/admin` using your new superuser credentials. You should see your superuser’s details displayed.

---

## 🧪 Writing Tests

With our new functionality added, it's important to write tests to ensure everything works as expected. We'll start with some unit tests for the custom user model.

### 1. **Writing Unit Tests**

In `accounts/tests.py`, add the following tests:

```python
# accounts/tests.py

from django.contrib.auth import get_user_model
from django.test import TestCase

class CustomUserTests(TestCase):
    def test_create_user(self):
        User = get_user_model()
        user = User.objects.create_user(
            username="will", email="will@email.com", password="testpass123"
        )
        self.assertEqual(user

.username, "will")
        self.assertEqual(user.email, "will@email.com")
        self.assertTrue(user.is_active)
        self.assertFalse(user.is_staff)
        self.assertFalse(user.is_superuser)

    def test_create_superuser(self):
        User = get_user_model()
        admin_user = User.objects.create_superuser(
            username="superadmin", email="superadmin@email.com", password="testpass123"
        )
        self.assertEqual(admin_user.username, "superadmin")
        self.assertEqual(admin_user.email, "superadmin@email.com")
        self.assertTrue(admin_user.is_active)
        self.assertTrue(admin_user.is_staff)
        self.assertTrue(admin_user.is_superuser)
```

### 2. **Running the Tests**

To run the tests within Docker, use the following command:

```bash
docker-compose exec web python manage.py test
```

If everything is set up correctly, you should see all tests passing! ✅

---

## 🗂️ Version Control with Git

We’ve accomplished quite a lot in this section, so it's a good point to commit our work to Git. Initialize a new Git repository, add the changes, and include a commit message:

```bash
git init
git status
git add .
git commit -m 'Bookstore Project'
```

You can compare your work with the official source code for this section on [GitHub](https://github.com).

---

## 🎉 Conclusion

Our Bookstore project is now running with Docker and PostgreSQL. We've also configured a custom user model and written initial tests. In the next section, we'll create a `pages` app for our static pages.
