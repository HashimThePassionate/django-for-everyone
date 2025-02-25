# 🔐 **Developing User Account Functionalities in Django**

In this section, we will **build user account functionalities** to create a **social website**. Users will be able to **register, manage their accounts, and authenticate securely**. Later, we will extend these features to include **social interactions**, such as **image sharing, bookmarking, following users, and liking images**. 🚀

---

## 📌 Features Covered in This section

### ✅ **User Authentication & Management**

We will implement user authentication using **Django’s built-in authentication framework** to handle:

- **User login/logout**
- **Password management (change/reset)**
- **Session handling for authentication**

### ✅ **User Registration**

- Create a **user registration view** that allows new users to sign up.
- Validate user inputs and store user credentials securely.

### ✅ **Profile Editing**

- Extend the default **Django User model** with a **custom profile model**.
- Allow users to update **profile information**, such as name, bio, and profile picture.

### ✅ **Social Features (Coming Soon!)**

- **Image Sharing** → Users can **bookmark and share images** from the internet.
- **User Interactions** → Users can **follow other users** and **like/unlike shared images**.
- **Activity Feed** → Users will see **updates from followed users**.

### ✅ **Handling Media Files**

- Configure the **project to upload and store media files**, such as profile pictures and shared images


<div align="center">

# `New Section Functional Overview`

</div>

<div align="center">
  <img src="./images/01.jpg" alt="" width="600px"/>

  **Figure 4.1**: Diagram of functionalities built in this section

</div>

<div align="center">

# `New Section Setting Django Project`

</div>

# **Setting Up a Django Project** 🚀

In this section, we will **initialize a new Django project**, create a user authentication application, and configure Django to use **MySQL** instead of the default SQLite database. We will also **store sensitive database credentials in an environment file (**`.env`**)** for enhanced security. 🔐

---

## 📌 Step 1: Create a New Django Project

Run the following command in your terminal to **create a new Django project**:

```sh
django-admin startproject bookmarks .
```

### ✅ Explanation:

- **`django-admin startproject bookmarks .`** → Creates a new Django project named `bookmarks`.
- The `.` at the end ensures that the project files are placed in the **current directory**, instead of creating a separate subdirectory.

### 📂 Initial Project Structure:

After running the command, your project folder will contain:

```
├── bookmarks/
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   ├── asgi.py
│   ├── wsgi.py
├── manage.py
```

---

## 📌 Step 2: Install Required Packages

To use MySQL as our database and load environment variables securely, install the required packages:

```sh
pip install pymysql python-decouple
```

- **`pymysql`** → Enables Django to connect to MySQL.
- **`python-decouple`** → Helps manage sensitive credentials using a `.env` file.

---

## 📌 Step 3: Configure MySQL Database in `settings.py`

First, create a **`.env`** file in your project root and add the following database credentials:

```ini
DB_NAME=social
DB_USER=****
DB_PASSWORD=****
DB_HOST=localhost
DB_PORT=3306
```

Then, modify `settings.py` to load these values securely:

```python
from decouple import config  # Import python-decouple to read .env file

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',  # Use MySQL as the database backend
        'NAME': config('DB_NAME'),  # Load database name from .env
        'USER': config('DB_USER'),  # Load MySQL username from .env
        'PASSWORD': config('DB_PASSWORD'),  # Load MySQL password from .env
        'HOST': config('DB_HOST'),  # Load MySQL host from .env
        'PORT': config('DB_PORT'),  # Load MySQL port from .env
    }
}
```

Next, open the `bookmarks/__init__.py` file and **import \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*****`pymysql`**:

```python
import pymysql
pymysql.install_as_MySQLdb()
```

### ✅ Explanation:

- **`config('DB_NAME')`** → Retrieves the database name from `.env`.
- **`config('DB_USER')`** → Retrieves the MySQL username securely.
- **`config('DB_PASSWORD')`** → Stores the database password outside the codebase.
- **`config('DB_HOST')`** → Retrieves the database server hostname.
- **`config('DB_PORT')`** → Loads the MySQL port dynamically.

🔹 **Ensure your ****************************`.env`**************************** file is added to ****************************`.gitignore`**************************** to prevent exposing credentials in version control.**

Before running migrations, make sure your **MySQL database exists**:

```sh
mysql -u root -p
CREATE DATABASE social;
```

---

## 📌 Step 4: Create a New Application for User Authentication

Next, create a **new application** named `account` that will handle user authentication:

```sh
django-admin startapp account
```

### ✅ Explanation:

- **`startapp account`** → Creates a new Django application named `account`.
- This app will contain **user-related views, models, and templates**.

### 📂 Application Structure:

After running the command, the new app directory will be structured as:

```
account/
├── migrations/
├── __init__.py
├── admin.py
├── apps.py
├── models.py
├── tests.py
├── views.py
```

---

## 📌 Step 5: Register the New App in `settings.py`

Django needs to know about the new app. Open **`settings.py`** and **add it to `INSTALLED_APPS`**:

```python
INSTALLED_APPS = [
    'account.apps.AccountConfig',  # Register the account app
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```

### ✅ Explanation:

- **`account.apps.AccountConfig`** → Registers the new `account` application.
- Django **processes apps in the order they appear** in `INSTALLED_APPS`.
- Placing `account` **first** ensures our **custom authentication templates** take priority over the default templates from `django.contrib.admin`.

---

## 📌 Step 6: Apply Migrations to Set Up the MySQL Database

After modifying `INSTALLED_APPS` and configuring MySQL, run the following command to apply **database migrations**:

```sh
python manage.py migrate
```

### ✅ Expected Output:

```sh
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying auth.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying sessions.0001_initial... OK
```

### ✅ Explanation:

- **Django applies the initial database migrations** to create necessary tables for user authentication, session management, and permissions.
- **Each app in **`INSTALLED_APPS`** is checked**, and its database models are added if necessary.

<div align="center">

# `New Section Authentication Framework`

</div>

# 🔐 **Using the Django Authentication Framework**

Django provides a **built-in authentication framework** that handles **user authentication, sessions, permissions, and user groups**. This system includes views for common user actions such as **logging in, logging out, password changes, and password resets**. 🚀

---

## 📌 Key Features of Django’s Authentication Framework

Django’s authentication system is part of `django.contrib.auth` and is used by various **Django contrib applications**. This framework provides:

- **User authentication** (login/logout)
- **Session management**
- **User permission**s and **group manage*****ment***
- **Pre-built authentication views and forms**

🔹 **Previously Used in the Blog Application**
We used this authentication framework earlier while **building a blog application**, where we created a **superuser** to access the Django **admin panel**.

---

## 📌 Authentication Framework in a New Django Project

When we create a new Django project using:

```sh
django-admin startproject account
```

The authentication framework is **included by default** in `INSTALLED_APPS`.

```python
INSTALLED_APPS = [
    'django.contrib.auth',  # Authentication framework
    'django.contrib.sessions',  # Session management
    'django.contrib.contenttypes',
    'django.contrib.admin',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```

Django also includes **two essential middleware classes** in `MIDDLEWARE`:

```python
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',  # Handles sessions
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',  # Associates users with requests
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
```

### ✅ Explanation of Middleware

- **`AuthenticationMiddleware`** → Associates **users with requests** using **sessions**.
- **`SessionMiddleware`** → Manages user **sessions** across multiple requests.
- Middleware executes **globally** during **request and response processing**.

You will encounter **middleware classes** on various occasions throughout development, and you will also learn how to **create custom middleware** later.

---

## 📌 Models in the Authentication Framework

Django’s authentication system includes **pre-built models** in `django.contrib.auth.models`, such as:

### ✅ **User Model**

Django provides a built-in **User model**, which contains essential fields:

```python
from django.contrib.auth.models import User

user = User.objects.create_user(username='john', password='securepassword')
```

| Field        | Description                        |
| ------------ | ---------------------------------- |
| `username`   | Unique username for authentication |
| `password`   | Hashed password stored securely    |
| `email`      | User’s email address               |
| `first_name` | User’s first name                  |
| `last_name`  | User’s last name                   |
| `is_active`  | Determines if the user is active   |

### ✅ **Group Model**

Django provides a **Group model** to categorize users:

```python
from django.contrib.auth.models import Group

admin_group = Group.objects.create(name='Admin')
```

- Groups allow assigning **permissions** to multiple users at once.

### ✅ **Permission Model**

Permissions are used to **restrict access to certain actions**:

```python
from django.contrib.auth.models import Permission

permission = Permission.objects.get(codename='add_user')
```

- Permissions can be assigned to **users** or **groups**.

---

## 📌 Built-in Authentication Views & Forms

Django includes **pre-built authentication views and forms** for:

- **Login/logout**
- **Password reset**
- **User authentication & session management**

You will use these **authentication views and forms** in later sections to build **secure login systems**.

<div align="center">

# `New Section Starts here`

</div>