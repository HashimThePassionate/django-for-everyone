# Installing and Configuring Django Debug Toolbar

This guide provides step-by-step instructions to install and configure Django Debug Toolbar, a powerful tool for debugging Django applications. The Django Debug Toolbar displays various panels of diagnostic information about the current request/response.

## Table of Contents
- [Installing and Configuring Django Debug Toolbar](#installing-and-configuring-django-debug-toolbar)
  - [Table of Contents](#table-of-contents)
  - [Prerequisites](#prerequisites)
  - [Installing Django Debug Toolbar](#installing-django-debug-toolbar)
  - [Configuring Django Debug Toolbar](#configuring-django-debug-toolbar)
  - [Adding Middleware](#adding-middleware)
  - [Adding Debug Toolbar URL Configuration](#adding-debug-toolbar-url-configuration)
  - [Using Django Debug Toolbar](#using-django-debug-toolbar)

## Prerequisites

- A working Django project. For this example, we assume the project name is `storefront`.

## Installing Django Debug Toolbar

1. **Activate Your Virtual Environment** (if not already activated):

    ```bash
    pipenv shell
    ```

2. **Install Django Debug Toolbar**:

    ```bash
    pipenv install django-debug-toolbar
    ```

## Configuring Django Debug Toolbar

1. **Add to Installed Apps**:
    - Open your `settings.py` file and add `'debug_toolbar'` to the `INSTALLED_APPS` list:

    ```python
    INSTALLED_APPS = [
        ...
        'debug_toolbar',
    ]
    ```

2. **Add Internal IPs**:
    - Add `INTERNAL_IPS` to your `settings.py` file to specify the IP addresses where the toolbar will be displayed. For local development, you can use the loopback address:

    ```python
    INTERNAL_IPS = [
        '127.0.0.1',
    ]
    ```

## Adding Middleware

1. **Add Debug Toolbar Middleware**:
    - Open your `settings.py` file and add `'debug_toolbar.middleware.DebugToolbarMiddleware'` to the `MIDDLEWARE` list. Ensure it is placed after `'django.middleware.common.CommonMiddleware'`:

    ```python
    MIDDLEWARE = [
        'django.middleware.security.SecurityMiddleware',
        'django.contrib.sessions.middleware.SessionMiddleware',
        'django.middleware.common.CommonMiddleware',
        'debug_toolbar.middleware.DebugToolbarMiddleware', #Here
        'django.middleware.csrf.CsrfViewMiddleware',
        'django.contrib.auth.middleware.AuthenticationMiddleware',
        'django.contrib.messages.middleware.MessageMiddleware',
        'django.middleware.clickjacking.XFrameOptionsMiddleware',
    ]
    ```

## Adding Debug Toolbar URL Configuration

1. **Update URL Configuration**:
    - Open your project's main `urls.py` file (e.g., `storefront/urls.py`) and include the debug toolbar URLs. Add the following code to the end of the `urlpatterns` list:

    ```python
    from django.conf import settings
    from django.conf.urls import include, url
    from django.contrib import admin

    urlpatterns = [
        path('admin/', admin.site.urls),
        path('store/', include('store.urls')),
        path("__debug__/", include("debug_toolbar.urls")),
    ]
    ```

## Using Django Debug Toolbar

1. **Run the Django Development Server**:

    ```bash
    python manage.py runserver
    ```

2. **Access the Toolbar**:
    - Open your web browser and navigate to your Django application (e.g., `http://127.0.0.1:8000/store/`).
    - The Django Debug Toolbar will appear on the right side of the browser window.

3. **Explore the Panels**:
    - The toolbar contains various panels that provide diagnostic information about the current request/response, including SQL queries, cache usage, template rendering times, and more.
    - Click on the panels to expand them and view detailed information.

