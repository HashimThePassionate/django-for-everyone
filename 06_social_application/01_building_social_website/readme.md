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

# `New Section login view`

</div>

# 🔐 **Creating a Login View in Django**

We will use Django's built-in **authentication framework** to allow users to log in to our website. This process involves:

1️⃣ **Displaying a login form** to users. <br>
2️⃣ **Capturing user credentials** (username and password). <br>
3️⃣ **Authenticating the user** against stored database records. <br>
4️⃣ **Verifying if the user is active** before allowing access. <br>
5️⃣ **Logging in the user** and starting an authenticated session. <br>

This guide will walk through implementing a **login form** and **view logic** for authentication. 🚀

---

## 📌 Step 1: Creating the Login Form

First, create a `forms.py` file inside the **account application** directory and define a login form:

```python
from django import forms

class LoginForm(forms.Form):
    username = forms.CharField()
    password = forms.CharField(widget=forms.PasswordInput)
```

### ✅ Explanation:

- **`forms.Form`** → This defines a standard Django form.
- **`username = forms.CharField()`** → Creates a text input field for the username.
- **`password = forms.CharField(widget=forms.PasswordInput)`** → Uses **`PasswordInput`** to hide password characters in the HTML form.

🔹 When rendered in HTML, the password input field will look like this:

```html
<input type="password" name="password">
```

---

# 🔐 Implementing the Login View in views.py

Now that we have created a login form, we need to build a **login view** that processes authentication requests. This view will:

1️⃣ Display the login form for **GET requests**.

2️⃣ Validate user credentials for **POST requests**.

3️⃣ Authenticate users against the **database**.

4️⃣ Log in the user if authentication is successful.

---

## 📌 Step 1: Edit `views.py` to Add the Login View

Modify the `views.py` file inside the `account` application and add the following code:

```python
from django.contrib.auth import authenticate, login
from django.http import HttpResponse
from django.shortcuts import render
from .forms import LoginForm

def user_login(request):
    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            cd = form.cleaned_data
            user = authenticate(
                request,
                username=cd['username'],
                password=cd['password']
            )
            if user is not None:
                if user.is_active:
                    login(request, user)
                    return HttpResponse('Authenticated successfully')
                else:
                    return HttpResponse('Disabled account')
            else:
                return HttpResponse('Invalid login')
    else:
        form = LoginForm()
    return render(request, 'account/login.html', {'form': form})
```

---

## 🔍 Step 2: Understanding the Code

### ✅ Handling GET Requests

```python
if request.method == 'POST':
```

- If the **request method is GET**, an **empty login form** is instantiated and rendered in the template.
- The form is then passed to `login.html` so the user can enter credentials.

### ✅ Processing POST Requests

```python
form = LoginForm(request.POST)
if form.is_valid():
```

- The form is instantiated with **submitted user data**.
- **`form.is_valid()`** checks whether the required fields (username & password) are correctly filled.

### ✅ Authenticating Users

```python
user = authenticate(
    request,
    username=cd['username'],
    password=cd['password']
)
```

- **`authenticate()`** checks the **username** and **password** against the database.
- If credentials are **valid**, it returns a **User object**; otherwise, it returns `None`.

### ✅ Checking User Status

```python
if user is not None:
    if user.is_active:
```

- If authentication succeeds, the `is_active` attribute is checked.
- If the **account is disabled**, an `HttpResponse` is returned with the message **Disabled account**.

### ✅ Logging in the User

```python
login(request, user)
return HttpResponse('Authenticated successfully')
```

- If authentication is successful and the user is **active**, `login()` is called.
- This **creates a session** for the user, keeping them logged in.

### ❗ Difference Between `authenticate()` and `login()`

| Method               | Purpose                                                                   |
| -------------------- | ------------------------------------------------------------------------- |
| **`authenticate()`** | Validates user credentials and returns a **User object** if valid.        |
| **`login()`**        | Stores the **authenticated user** in the session, keeping them logged in. |

---

# 🔗 **Setting Up URL Routing**

Now that we have implemented the **login view**, we need to **define URL routes** to access it. This involves:

1️⃣ Creating a **URL configuration** inside the `account` app.

2️⃣ Including `account.urls` in the **main project’s URL patterns**.

3️⃣ Ensuring the login page is accessible via a URL like **`/account/login/`**.

---

## 📌 Step 1: Create `urls.py` in the `account` Application

Inside the `account` application directory, create a new **`urls.py`** file and add the following code:

```python
from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.user_login, name='login'),  # Login URL
]
```

### ✅ Explanation:

- **`path('login/', views.user_login, name='login')`** → Defines a route for the login view.
- **`name='login'`** → Assigns a name to the URL pattern for easy referencing.

Now, visiting **`http://127.0.0.1:8000/account/login/`** will trigger the `user_login` view. 🚀

---

## 📌 Step 2: Include `account.urls` in the Main `urls.py`

Edit the **main ****************`urls.py`**************** file** in the **bookmarks project directory** and modify it as follows:

```python
from django.contrib import admin
from django.urls import path, include  # Import include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('account/', include('account.urls')),  # Include account app
]
```

### ✅ Explanation:

- **`include('account.urls')`** → Includes all URL patterns from the `account` app.
- Now, all routes inside `account.urls.py` will be prefixed with `/account/`.

🔹 Example URLs:

| Feature         | URL               |
| --------------- | ----------------- |
| **Admin Panel** | `/admin/`         |
| **Login Page**  | `/account/login/` |

---

# 🎨 **Creating the Login Template**

To make the login view functional, we need to create a **template** that renders the login form. Since this is our first template, we will also create a **base template (`base.html`**) that can be extended across multiple pages.

---

## 📌 Step 1: Creating Template Directories

Inside the `account` application directory, create the following structure:

```
account/
│── templates/
│   ├── account/
│   │   ├── login.html
│   ├── base.html
```

This structure ensures that Django can find the **login.html** template when rendering the login page.

---

## 📌 Step 2: Creating `base.html`

Edit `base.html` and add the following code:

```html
{% load static %}
<!DOCTYPE html>
<html>
<head>
    <title>{% block title %}{% endblock %}</title>
    <link href="{% static 'css/base.css' %}" rel="stylesheet">
</head>
<body>
    <div id="header">
        <span class="logo">Bookmarks</span>
    </div>
    <div id="content">
        {% block content %}
        {% endblock %}
    </div>
</body>
</html>
```

### ✅ Explanation:

- **`{% load static %}`** → Loads Django's **static files** (CSS, JS, etc.).
- **Defines a `<title>` block** → This allows pages extending `base.html` to customize their title.
- Defines a **`{% block content %}`** → Pages extending `base.html` will **inject their content** here.

---

## 📌 Step 3: Creating `login.html`

Edit `account/login.html` and add the following code:

```html
{% extends "base.html" %}
{% block title %}Log-in{% endblock %}
{% block content %}
    <h1>Log-in</h1>
    <p>Please, use the following form to log in:</p>
    <form method="post">
        {{ form.as_p }}
        {% csrf_token %}
        <p><input type="submit" value="Log in"></p>
    </form>
{% endblock %}
```

### ✅ Explanation:

- **`{% extends "base.html" %}`** → Inherits from the base template.
- **Renders the form** using `{{ form.as_p }}`.
- Includes **`{% csrf_token %}`** → Provides **CSRF protection** for the form.
- **Adds a submit button** to send the login request.

---

## 📌 Step 4: Creating a Superuser

Before logging in, we need at least one user in the database. Run the following command to create a **superuser**:

```sh
python manage.py createsuperuser
```

### ✅ Example Input:

```sh
Username (leave blank to use 'admin'): admin
Email address: admin@admin.com
Password: ********
Password (again): ********
```

### ✅ Expected Output:

```sh
Superuser created successfully.
```

---

## 📌 Step 5: Running the Development Server

Start the Django server using:

```sh
python manage.py runserver
```

Now, open **[http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/)** in your browser and log in with the **superuser credentials**.

<div align="center">
  <img src="./images/02.jpg" alt="" width="600px"/>

  **Figure 4.2**: The Django administration site index page including Users and Groups

</div>

You can also create a **regular user** through the **Django admin panel**:

1. Go to **Users** → **Add User**.

<div align="center">
  <img src="./images/03.jpg" alt="" width="600px"/>

  **Figure 4.3**: The Add user form on the Django administration site

</div>

1. Fill in the username and password.

<div align="center">
  <img src="./images/04.jpg" alt="" width="600px"/>

  **Figure 4.4**: The user editing form on the Django administration site

</div>

2. Click **Save** to create the user.
3. Update the **first name, last name, and email address**.
4. Click **Save** again.


---

## 📌 Step 6: Testing the Login Page

Navigate to **[http://127.0.0.1:8000/account/login/](http://127.0.0.1:8000/account/login/)** in your browser. You should see the **login form rendered**.

<div align="center">
  <img src="./images/05.jpg" alt="" width="600px"/>

  **Figure 4.5**: The user Log-in page

</div>

### ✅ Testing Scenarios:

1️⃣ **Enter invalid credentials** → You should see an **Invalid login** message.

<div align="center">
  <img src="./images/06.jpg" alt="" width="600px"/>

  **Figure 4.6**: The invalid login plain text response

</div>


2️⃣ **Enter valid credentials** → You should see **Authenticated successfully**.

<div align="center">
  <img src="./images/07.jpg" alt="" width="600px"/>

  **Figure 4.7**: The successful authentication plain text response

</div>

<div align="center">

# `New Section Built-in Authentication Views`

</div>

# 🔐 **Using Django’s Built-in Authentication Views**

Django provides **ready-to-use authentication views** in `django.contrib.auth.views` that can save time when building web applications with user authentication. These built-in views handle **user login, logout, password changes, and password resets**. 🚀

---

## 📌 Why Use Django’s Built-in Authentication Views?

Instead of manually creating login and logout views, Django offers **pre-built authentication views** that:

✅ Provide a **secure** authentication system.

✅ Follow **best security practices** (e.g., password hashing, session handling).

✅ Are **customizable** (templates, forms, redirection, etc.).

✅ Save **development time** when building user account functionality.

---

## 📌 Authentication Views in `django.contrib.auth.views`

### 🔑 **Login & Logout Views**

| View             | Purpose                                             |
| ---------------- | --------------------------------------------------- |
| **`LoginView`**  | Handles login form submission and logs in the user. |
| **`LogoutView`** | Logs out the user and clears the session.           |

### 🔐 **Password Change Views**

| View                         | Purpose                                                  |
| ---------------------------- | -------------------------------------------------------- |
| **`PasswordChangeView`**     | Displays a form to allow users to change their password. |
| **`PasswordChangeDoneView`** | Redirects the user after a successful password change.   |

### 🔄 **Password Reset Views**

| View                            | Purpose                                                           |
| ------------------------------- | ----------------------------------------------------------------- |
| **`PasswordResetView`**         | Sends an email with a password reset link.                        |
| **`PasswordResetDoneView`**     | Informs the user that an email has been sent.                     |
| **`PasswordResetConfirmView`**  | Allows users to set a new password after clicking the reset link. |
| **`PasswordResetCompleteView`** | Redirects the user after successfully resetting their password.   |

💡 These views work **out of the box** but can be **customized** (e.g., changing templates, modifying form fields).

---


