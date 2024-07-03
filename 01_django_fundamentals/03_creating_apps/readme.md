# Installing Apps

# Django Project Setup and App Explanation

This guide provides an overview of Django apps, explains the purpose of built-in apps, and walks you through creating and installing custom apps named `store` and `tags`.

## Table of Contents
- [Installing Apps](#installing-apps)
- [Django Project Setup and App Explanation](#django-project-setup-and-app-explanation)
  - [Table of Contents](#table-of-contents)
  - [What is an App in Django?](#what-is-an-app-in-django)
  - [Django Built-in Apps](#django-built-in-apps)
    - [`django.contrib.admin`](#djangocontribadmin)
    - [`django.contrib.auth`](#djangocontribauth)
    - [`django.contrib.contenttypes`](#djangocontribcontenttypes)
    - [`django.contrib.messages`](#djangocontribmessages)
    - [`django.contrib.staticfiles`](#djangocontribstaticfiles)
  - [Creating Custom Apps](#creating-custom-apps)
  - [Installing Custom Apps](#installing-custom-apps)

## What is an App in Django?

In Django, an app is a self-contained module that encapsulates a specific functionality or feature of your web application. Each app is responsible for handling a particular aspect of the project, such as user authentication, blog posts, or an online store. Apps make it easy to manage and reuse code across multiple projects.

## Django Built-in Apps

Django comes with several built-in apps that provide common functionalities. Here are some of them:

### `django.contrib.admin`

- **Location:** `django/contrib/admin`
- **Purpose:** This app provides an administrative interface for managing site content. It includes features for adding, editing, and deleting records in the database through a user-friendly interface.

### `django.contrib.auth`

- **Location:** `django/contrib/auth`
- **Purpose:** This app handles authentication and authorization. It includes models for users, groups, and permissions, as well as forms and views for login, logout, password management, and more.

### `django.contrib.contenttypes`

- **Location:** `django/contrib/contenttypes`
- **Purpose:** This app provides a generic interface for dealing with different models. It is a foundational part of the Django ORM and is required by several other apps, including the auth app.

### `django.contrib.messages`

- **Location:** `django/contrib/messages`
- **Purpose:** This app provides a framework for sending one-time messages to users. It is often used to display notifications and alerts after form submissions or other user actions.

### `django.contrib.staticfiles`

- **Location:** `django/contrib/staticfiles`
- **Purpose:** This app handles the management and serving of static files (CSS, JavaScript, images) in your project. It includes utilities for collecting static files from different apps and serving them efficiently.

## Creating Custom Apps

To create custom apps named `store` and `tags`, follow these steps:

1. **Navigate to your project directory:**
    ```bash
    cd storefront
    ```

2. **Create the `store` app:**
    ```bash
    python manage.py startapp store
    ```

3. **Create the `tags` app:**
    ```bash
    python manage.py startapp tags
    ```

## Installing Custom Apps

To install the custom apps in your Django project, you need to add them to the `INSTALLED_APPS` list in your `settings.py` file.

1. **Open `settings.py` and locate the `INSTALLED_APPS` section:**

2. **Add the custom apps to `INSTALLED_APPS`:**
    ```python
    INSTALLED_APPS = [
        'django.contrib.admin',
        'django.contrib.auth',
        'django.contrib.contenttypes',
        'django.contrib.messages',
        'django.contrib.staticfiles',
        'store',  # Add the store app
        'tags',   # Add the tags app
    ]
    ```

3. **Save the `settings.py` file.**

Now your custom apps `store` and `tags` are created and installed in your Django project. You can start adding models, views, templates, and other functionality to these apps as needed.
