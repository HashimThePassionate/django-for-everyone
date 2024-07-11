# Hello World App

## Overview
In this chapter, we will build a Django project that displays "Hello, World" on the homepage. This is a traditional starting point for learning a new programming language or framework. We will also work with Git for the first time and deploy our code to GitHub.

## Initial Set Up
1. **Open Terminal**: Use the built-in terminal in VS Code by clicking "Terminal" at the top and then "New Terminal."

2. **Create and activate a virtual environment, then install Django using pipenv**:

   ```shell
   # Windows and macOS
   > pipenv install django
   > pipenv shell
   ```

3. **Create a new Django project**:

   ```shell
   (helloworld) > django-admin startproject helloworld .
   ```

4. **Examine the default project structure**:

   ```plaintext
   helloworld/
   ├── __init__.py
   ├── asgi.py
   ├── settings.py
   ├── urls.py
   ├── wsgi.py
   ├── manage.py
   └── Pipfile
   ```

5. **Run the Django server**:

   ```shell
   # Windows
   (helloworld) > python manage.py runserver

   # macOS
   (helloworld) % python3 manage.py runserver
   ```

   Visit [http://127.0.0.1:8000/](http://127.0.0.1:8000/) in your web browser to see the Django welcome page.

6. **Apply migrations to remove warnings**:

   ```shell
   # Windows
   (helloworld) > python manage.py migrate

   # macOS
   (helloworld) % python3 manage.py migrate
   ```

## HTTP Request/Response Cycle
HTTP (Hypertext Transfer Protocol) is a request-response protocol that works in a client-server computing model. An HTTP request is sent to a URL by a client (your computer), and a server sends back an HTTP response.

## Create An App
1. **Create a new app**:

   ```shell
   # Windows
   (helloworld) > python manage.py startapp pages

   # macOS
   (helloworld) % python3 manage.py startapp pages
   ```

2. **Update `INSTALLED_APPS` in `helloworld/settings.py`**:

   ```python
   # helloworld/settings.py
   INSTALLED_APPS = [
       "django.contrib.admin",
       "django.contrib.auth",
       "django.contrib.contenttypes",
       "django.contrib.sessions",
       "django.contrib.messages",
       "django.contrib.staticfiles",
       "pages",  # new
   ]
   ```

## Hello, World
1. **Create a view in `pages/views.py`**:

   ```python
   # pages/views.py
   from django.http import HttpResponse

   def homePageView(request):
       return HttpResponse("Hello, World!")
   ```

2. **Create a URL configuration for the new view**:

   ```python
   # pages/urls.py
   from django.urls import path
   from .views import homePageView

   urlpatterns = [
       path("", homePageView, name="home"),
   ]
   ```

3. **Update the project's URL configuration**:

   ```python
   # helloworld/urls.py
   from django.contrib import admin
   from django.urls import path, include  # new

   urlpatterns = [
       path("admin/", admin.site.urls),
       path("", include("pages.urls")),  # new
   ]
   ```

4. **Run the server again**:

   ```shell
   # Windows
   (helloworld) > python manage.py runserver

   # macOS
   (helloworld) % python3 manage.py runserver
   ```

   Visit [http://127.0.0.1:8000/](http://127.0.0.1:8000/) in your web browser to see the text “Hello, World!”
