# Django Templates and Static Files

This guide provides an overview of Django templates, explains why we use them, and includes a step-by-step tutorial to create a Django view that renders an HTML page using template tags. It also covers setting up a templates directory, using static files, and integrating Bootstrap for styling.

## Table of Contents
- [Django Templates and Static Files](#django-templates-and-static-files)
  - [Table of Contents](#table-of-contents)
  - [What are Templates?](#what-are-templates)
  - [Why Use Templates?](#why-use-templates)
  - [Setting Up Templates](#setting-up-templates)
    - [Creating a Template Directory](#creating-a-template-directory)
    - [Creating an HTML Template](#creating-an-html-template)
  - [Using Django Template Tags](#using-django-template-tags)
  - [Creating Views and Passing Dynamic Data](#creating-views-and-passing-dynamic-data)
  - [Setting Up Static Files](#setting-up-static-files)
    - [Creating a Static Directory](#creating-a-static-directory)
    - [Using Bootstrap CSS and JS](#using-bootstrap-css-and-js)
  - [Example Bootstrap Page](#example-bootstrap-page)
    - [Directory Structure](#directory-structure)
    - [Final `index.html` Template](#final-indexhtml-template)
    - [How URLs Work](#how-urls-work)
    - [Example Explanation](#example-explanation)

## What are Templates?

Templates in Django are used to define the structure and layout of HTML pages. They allow you to separate the presentation logic from the business logic by using a template language to dynamically generate HTML.

## Why Use Templates?

- **Separation of Concerns:** Templates help separate the presentation layer from the business logic, making your code cleaner and more maintainable.
- **Dynamic Content:** Templates enable you to dynamically generate HTML content based on data from your views.
- **Reusable Components:** You can create reusable components and include them in multiple templates, promoting DRY (Don't Repeat Yourself) principles.

## Setting Up Templates

### Creating a Template Directory

1. **Create a `templates` directory inside your app:**
    ```bash
    mkdir store/templates
    ```

2. **Create a subdirectory named `store` inside the `templates` directory:**
    ```bash
    mkdir store/templates/store
    ```

### Creating an HTML Template

1. **Create an `index.html` file inside `store/templates/store`:**
    ```html
    <!-- store/templates/store/index.html -->
   <!DOCTYPE html>
   {% load static %}
   <html lang="en">
   <head>
       <meta charset="UTF-8">
       <meta name="viewport" content="width=device-width, initial-scale=1.0">
       <title>Django Template Example</title>
       <link rel="stylesheet" href="{% static 'css/bootstrap.css' %}">
   </head>
   <body>
       <div class="container">
           <h1>Hello, {{ name }}!</h1>
           <p>Welcome to our Django tutorial.</p>
           <ul>
               {% for item in items %}
               <li>{{ item }}</li>
               {% endfor %}
           </ul>
       </div>
       <script src="{% static 'js/bootstrap.js' %}"></script>
   </body>
   </html>
    ```

## Using Django Template Tags

Django template tags allow you to perform various operations within your templates. Here are some commonly used template tags:

- **Variable Tag:** `{{ variable }}`
- **For Loop Tag:** `{% for item in items %}{% endfor %}`
- **If Tag:** `{% if condition %}{% endif %}`
- **Include Tag:** `{% include 'path/to/template.html' %}`

## Creating Views and Passing Dynamic Data

1. **Create a view in `store/views.py`:**
    ```python
    from django.shortcuts import render

    def index(request):
        context = {
            'name': 'Django Learner',
            'items': ['Learn Django', 'Build Projects', 'Deploy Applications']
        }
        return render(request, 'store/index.html', context)
    ```

2. **Map the view in `store/urls.py`:**
    ```python
    from django.urls import path
    from .views import index

    urlpatterns = [
        path('', index, name='index'),
    ]
    ```

3. **Include the `store` URLs in the main `urls.py`:**
    ```python
    from django.contrib import admin
    from django.urls import path, include

    urlpatterns = [
        path('admin/', admin.site.urls),
        path('store/', include('store.urls')),
    ]
    ```

## Setting Up Static Files

### Creating a Static Directory

1. **Create a `static` directory inside your app:**
    ```bash
    mkdir store/static
    ```

2. **Create subdirectories for CSS and JS files:**
    ```bash
    mkdir store/static/css
    mkdir store/static/js
    ```

### Using Bootstrap CSS and JS

1. **Download Bootstrap CSS and JS files from the official website:**
    - [Bootstrap Download](https://getbootstrap.com/docs/5.0/getting-started/download/)

2. **Place the downloaded files in the appropriate directories:**
    - `bootstrap.min.css` in `store/static/css`
    - `bootstrap.bundle.min.js` in `store/static/js`

## Example Bootstrap Page

Here is the final structure of your Django project with the necessary files:

### Directory Structure

```
store/
│
├── static/
│   ├── css/
│   │   └── bootstrap.css
│   └── js/
│       └── bootstrap.js
│
├── templates/
│   └── store/
│       └── index.html
│
├── views.py
├── urls.py
```

### Final `index.html` Template

```html
<!-- store/templates/store/index.html -->
<!DOCTYPE html>
{% load static %}
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Django Template Example</title>
    <link rel="stylesheet" href="{% static 'css/bootstrap.css' %}">
</head>
<body>
    <div class="container">
        <h1>Hello, {{ name }}!</h1>
        <p>Welcome to our Django tutorial.</p>
        <ul>
            {% for item in items %}
            <li>{{ item }}</li>
            {% endfor %}
        </ul>
    </div>
    <script src="{% static 'js/bootstrap.js' %}"></script>
</body>
</html>
```

### How URLs Work

1. **URLconf (URL Configuration):**
    - Django uses a URL configuration (URLconf) to map URL patterns to views.
    - Each URL pattern in `urls.py` points to a specific view that handles the request for that URL.

2. **URL Dispatcher:**
    - When a request comes in, Django's URL dispatcher examines each URL pattern in the `urlpatterns` list from top to bottom and stops at the first pattern that matches the requested URL.

3. **Including Other URLconfs:**
    - You can include other URLconfs to keep your project organized. This is done using the `include()` function.

### Example Explanation

1. **Request Flow:**
    - When a user navigates to `http://127.0.0.1:8000/store/`, Django first looks at the `urlpatterns` in `project/urls.py`.
    - The URL pattern `path('store/', include('store.urls'))` tells Django to include `store/urls.py`.
    - In `store/urls.py`, the pattern `path('', index, name='index')` matches the URL `/store/` and calls `index`.

2. **View Processing:**
    - The `index` function processes the request and passes the context data to the template.

3. **Template Rendering:**
    - The template engine renders the `index.html` template, dynamically inserting the context data.

4. **Response Sent:**
    - The rendered HTML is sent back to the user's browser, and they see the page displayed.
