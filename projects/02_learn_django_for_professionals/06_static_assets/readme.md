# Section: Static Assets 🎨

Static assets like CSS, JavaScript, and images are core components of any modern web application. Django provides us with a large degree of flexibility around their configuration and storage, which can be confusing to newcomers, but in practice, the pattern is almost identical for all projects. In this section, we’ll configure our initial static assets and add Bootstrap for improved styling.

## Local Development 🛠️

For local development, the Django web server automatically serves static files, and minimal configuration is required. Static files can be placed in an app-level directory called `static`. For example, you could create a new directory within the `pages` app called `pages/static/`. However, most projects reuse static assets across multiple apps, and our bookstore app will certainly do this! A more common approach is to create a base-level `static` folder and place all static files there, making it easier to reason about as a developer.

### Creating the Static Folder Structure 🗂️

From the command line, create a new `static` folder along with subdirectories for CSS, JavaScript, and images.

```bash
mkdir static
mkdir static/css
mkdir static/js
mkdir static/images
```

Your Django project should have the following structure at this point:

```
Project Structure
├── Dockerfile
├── accounts
│ ...
├── db.sqlite3
├── django_project
│ ...
├── docker-compose.yml
├── manage.py
├── pages
│ ...
├── requirements.txt
├── static
│ ├── css
│ ├── images
│ └── js
└── templates
...
```

### Adding Files to Static Directories 📁

Git, by default, will not track directories that are empty. Thus, when we eventually push our code to both GitHub and Heroku, these empty directories will not appear, which can cause problems in deployment when `collectstatic` is run. To avoid this, we will add an empty file to each directory now.

In your text editor, create the following three files:

- `static/css/base.css`
- `static/js/base.js`
- `static/images/.keep`

## Configuring STATICFILES_DIRS 🛠️

At the bottom of the `django_project/settings.py` file, you'll find a section on "Static files," which has already set `STATIC_URL` to `"static/"`. This is the URL used when referring to static files. It means that for local usage, all static files are located at `http://127.0.0.1:8000/static/`.

The built-in `staticfiles` app that ships with Django (visible in the `INSTALLED_APPS` section of `django_project/settings.py`) includes a helper view that will serve files locally for development. It will automatically look for a static directory within each application.

Many static files are not app-specific and are intended to be used project-wide. That’s why creating a base-level `static` folder, as we did above, is a common practice. We just need to provide Django with a list of additional directories to look in, which is the job of `STATICFILES_DIRS`. Since this is a list, we must place brackets `[]` around it in standard Python syntax.

Here is what the updated `django_project/settings.py` file should look like:

```python
# django_project/settings.py
STATIC_URL = "/static/"
STATICFILES_DIRS = [BASE_DIR / "static"]  # new
```

## Adding CSS Styling 🎨

Let’s update `base.css` now and keep things simple by making our `h1` headline red. The point is to show how CSS can be added to our project, not to delve too deeply into CSS itself.

```css
/* static/css/base.css */
h1 {
    color: red;
}
```

### Loading Static Assets in Templates 📄

To see the changes, static assets must be explicitly loaded into templates! Add `{% load static %}` at the top of `_base.html` and then use the `static` template tag to reference our `base.css` file. Even though this file is located at `static/css/base.css`, we can refer to it as `css/base.css` because the `static` tag automatically looks within the `/static/` directory specified in `STATIC_URL`.

Here is what the updated `templates/_base.html` file should look like:

```html
<!-- templates/_base.html -->
{% load static %}
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{% block title %}Bookstore{% endblock %}</title>
    <!-- CSS -->
    <link rel="stylesheet" href="{% static 'css/base.css' %}">
</head>
...
```

### Refresh and Verify 🖥️

Refresh the homepage to see our work in action. If instead you see an error screen saying "Invalid block tag on line 7: 'static'. Did you forget to register or load this tag?" then you forgot to include the line `{% load static %}` at the top of the file.

## Adding Images 🖼️

Let’s add an image to our homepage. You can download the book cover at this [link](./static/images/fluentpython.png). Save it into the directory `static/images` as `fluentpython.png`.

To display it on the homepage, update `templates/home.html` by adding the `{% load static %}` tag at the top. Then, under the `<h1>` tags, add an `<img>` class that uses `static` to display the new cover.

```html
<!-- templates/home.html -->
{% extends "_base.html" %}
{% load static %}
{% block title %}Home{% endblock title %}
{% block content %}
<h1>This is our home page.</h1>
<img class="bookcover" src="{% static 'images/dfp.jpg' %}">
{% if user.is_authenticated %}
<p>Hi {{ user.email }}!</p>
<p><a href="{% url 'logout' %}">Log Out</a></p>
{% else %}
<p>You are not logged in</p>
<p><a href="{% url 'login' %}">Log In</a> |
<a href="{% url 'signup' %}">Sign Up</a></p>
{% endif %}
{% endblock content %}
```

### Adjusting Image Size with CSS 🖌️

The raw image file is quite large! Let’s control that with some additional CSS.

```css
/* static/css/base.css */
h1 {
    color: red;
}
.bookcover {
    height: 300px;
    width: auto;
}
```

Now, refresh the homepage, and the book cover image should fit nicely.

### Hard Refresh for Changes 🔄

If you don’t see the changes, you might need to perform a “hard refresh” to bypass your web browser’s local cache. On Windows, this can be done by holding `Ctrl+F5`; on macOS, hold `Cmd+Shift+R`.

## Adding JavaScript 📝

We already have a `base.js` file where we can add JavaScript to our project. For demonstration purposes, we’ll add a `console.log` statement so we can confirm the JavaScript loaded correctly.

```javascript
// static/js/base.js
console.log("JavaScript here!")
```

### Including JavaScript in Templates 🧩

JavaScript should be added at the bottom of the file so it is loaded last, after the HTML, CSS, and other assets that appear first on the screen when rendered in the web browser. This gives the appearance of the complete webpage loading faster.

```html
<!-- templates/_base.html -->
{% load static %}
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{% block title %}Bookstore{% endblock %}</title>
    <!-- CSS -->
    <link rel="stylesheet" href="{% static 'css/base.css' %}">
</head>
<body>
    <div class="container">
        {% block content %}
        {% endblock content %}
    </div>
    <!-- JavaScript -->
    <script src="{% static 'js/base.js' %}"></script>
</body>
</html>
```

### Verifying JavaScript 🕵️

In your web browser, open Developer Tools and make sure you’re on the “Console” section. If you refresh the page, you should see the message: `JavaScript here!`.

## Preparing for Production 🚀

Local development is designed to keep things easy for static files. However, in a production environment, it is more efficient to combine all static files into one location and serve them in a single, larger HTTP request.

Django comes with a built-in management command, `collectstatic`, that does this for us. But we need to configure two more settings in our `django_project/settings.py` file before `collectstatic` will work properly.

### Setting STATIC_ROOT 🏠

The first setting is `STATIC_ROOT`, which sets the absolute location of these collected files. We typically name this directory “staticfiles”.

```python
# django_project/settings.py
STATIC_URL = "/static/"
STATICFILES_DIRS = [BASE_DIR / "static"]
STATIC_ROOT = BASE_DIR / "staticfiles"  # new
```

### Configuring STATICFILES_STORAGE 🗃️

The second setting is `STATICFILES_STORAGE`, which is the file storage engine used when collecting static files with the `collectstatic` command.

```python
# django_project/settings.py
STATIC_URL = "/static/"
STATICFILES_DIRS = [BASE_DIR / "static"]
STATIC_ROOT = BASE_DIR / "staticfiles"
STATICFILES_STORAGE = "django.contrib.staticfiles.storage.StaticFilesStorage"  # new
```

### Running collectstatic 🏃

Now we can run the command `python manage.py collectstatic`, which will combine all static files into a new `staticfiles` directory.

```bash
docker-compose exec web python manage.py collectstatic
131 static files copied to '/code/staticfiles'.
```

## Using Bootstrap 🎨

Writing custom CSS for your website is a worthy goal, but front-end frameworks like Bootstrap can save you a ton of time when starting a new project. Bootstrap can be installed locally or used via a CDN. The latter is simpler, so we will adopt it here.

### Adding Bootstrap to Templates 📜

```html
<!-- templates/_base.html -->
{% load static %}
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{% block title %}Bookstore{% endblock %}</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- CSS -->
    <link rel="stylesheet" href="{% static 'css/base.css' %}">
</head>
<body>
    <div class="container">
        {% block content %}
        {% endblock content %}
    </div>
    <!-- Bootstrap JavaScript -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- JavaScript -->
    <script src="{% static 'js/base.js' %}"></script>
</body>
</html>
```

### Using Bootstrap Components 🧩

Now it’s time to use Bootstrap. Let’s add a fixed navbar to the `_base.html` file at the top of the `<body>` section.

```html
<!-- templates/_base.html -->
<body>
    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Bookstore</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <ul class="navbar-nav me-auto mb-2 mb-md-0">
                    {% if user.is_authenticated %}
                    <li class="nav-item">
                        <a class="nav-link" href="{% url 'logout' %}">Log Out</a>
                    </li>
                    {% else %}
                    <li class="nav-item">
                        <a class="nav-link" href="{% url 'login' %}">Log In</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{% url 'signup' %}">Sign Up</a>
                    </li>
                    {% endif %}
                </ul>
            </div>
        </div>
    </nav>
    <div class="container">
        {% block content %}
        {% endblock content %}
    </div>
</body>
```

### Updating CSS for Navbar 🖌️

```css
/* static/css/base.css */
body {
    min-height: 75rem;
    padding-top: 4.5rem;
}
h1 {
    color: red;
}
img.bookcover {
    height: 300px;
    width: auto;
}
```

### Simplifying Home Page Template 🧹

```html
<!-- templates/home.html -->
{% extends "_base.html" %}
{% load static %}
{% block title %}Home{% endblock title %}
{% block content %}
<h1>This is our home page.</h1>
<img class="bookcover" src="{% static 'images/fluentpython.png' %}">
{% endblock content %}
```

Refresh the homepage now to see our new navbar and updated homepage.

## Adding an About Page 📄

Let’s add an About page to our project and to the navbar. It is quite straightforward to do now that we have our site’s scaffolding configured. Since this will be a static page, we don’t need a database model involved. However, we will need a template, view, and URL.

### Creating the About Template 🖋️

```html
<!-- templates/about.html -->
{% extends "_base.html" %}
{% block title %}About{% endblock title %}
{% block content %}
<h1>About Page</h1>
{% endblock content %}
```

### Adding the About View 🖼️

```python
# pages/views.py
from django.views.generic import TemplateView

class HomePageView(TemplateView):
    template_name = "home.html"

class AboutPageView(TemplateView):  # new
    template_name = "about.html"
```

### Configuring the About URL 🌐

```python
# pages/urls.py
from django.urls import path
from .views import HomePageView, AboutPageView  # new

urlpatterns = [
    path("about/", AboutPageView.as_view(), name="about"),  # new
    path("", HomePageView.as_view(), name="home"),
]
```

If you now visit the URL `http://127.0.0.1:8000/about/`, you can see the About page.

### Updating Navbar with About Link 🔗

```html
<!-- templates/_base.html -->
<div class="collapse navbar-collapse" id="navbarCollapse">
    <ul class="navbar-nav me-auto mb-2 mb-md-0">
        <li class="nav-item">
            <a class="nav-link" href="{% url 'about' %}">About</a>
        </li>
        {% if user.is_authenticated %}
        ...
    </ul>
</div>
```

Refresh the About page now to see the "About" link in the navbar.

## Testing the About Page 🧪

We’ve added a new About page, so we should add basic tests for it in `pages/tests.py`. These tests will be very similar to those we added previously for our homepage.

```python
# pages/tests.py
from django.test import SimpleTestCase
from django.urls import reverse, resolve
from .views import HomePageView, AboutPageView  # new

class HomepageTests(SimpleTestCase):
    ...
    
class AboutPageTests(SimpleTestCase):  # new
    def setUp(self):
        url = reverse("about")
        self.response = self.client.get(url)

    def test_aboutpage_status_code(self):
        self.assertEqual(self.response.status_code, 200)

    def test_aboutpage_template(self):
        self.assertTemplateUsed(self.response, "about.html")

    def test_aboutpage_contains_correct_html(self):
        self.assertContains(self.response, "About Page")

    def test_aboutpage_does_not_contain_incorrect_html(self):
        self.assertNotContains(self.response, "Hi there! I should not be on the page.")

    def test_aboutpage_url_resolves_aboutpageview(self):
        view = resolve("/about/")
        self.assertEqual(view.func.__name__, AboutPageView.as_view().__name__)
```

Run the tests:

```bash
docker-compose exec web python manage.py test
Found 15 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
...............
----------------------------------------------------------------------
Ran 15 tests in 0.161s
OK
Destroying test database for alias 'default'...
```

All tests should pass, ensuring that any future changes won’t mess up the About page.

## Using Django Crispy Forms 📝

One last update with Bootstrap is to our forms. The popular third-party package `django-crispy-forms` provides a host of welcome upgrades and has a Bootstrap5 dedicated template pack `crispy-bootstrap5` that we can use too.

### Adding Crispy Forms to Requirements 📋

Add both to our `requirements.txt` file as follows:

```plaintext
asgiref==3.5.2
Django==4.0.4
psycopg2-binary==2.9.3
sqlparse==0.4.2
django-crispy-forms==1.14.0
crispy-bootstrap5==0.6
```

Then stop our Docker container and rebuild it so that `django-crispy-forms` and `crispy-bootstrap5` are available.

```bash
docker-compose down
docker-compose up -d --build
```

### Adding Crispy Forms to Installed Apps 🖥️

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # Third-party
    "crispy_forms",  # new
    "crispy_bootstrap5",  # new
    # Local
    "accounts",
    "pages",
]

# django-crispy-forms
CRISPY_ALLOWED_TEMPLATE_PACKS = "bootstrap5"  # new
CRISPY_TEMPLATE_PACK = "bootstrap5"  # new
```

### Updating Templates for Crispy Forms ✨

Start with the `templates/registration/signup.html` file and make the updates below.

```html
<!-- templates/registration/signup.html -->
{% extends "_base.html" %}
{% load crispy_forms_tags %}
{% block title %}Sign Up{% endblock title %}
{% block content %}
<h2>Sign Up</h2>
<form method="post">
    {% csrf_token %}
    {{ form|crispy }}
    <button class="btn btn-success" type="submit">Sign Up</button>
</form>
{% endblock content %}
```



Then navigate to the signup page at `http://127.0.0.1:8000/accounts/signup/`.

Next, update `templates/registration/login.html` as well with `crispy_forms_tags` at the top and `{{ form|crispy }}` in the form.

```html
<!-- templates/registration/login.html -->
{% extends "_base.html" %}
{% load crispy_forms_tags %}
{% block title %}Log In{% endblock title %}
{% block content %}
<h2>Log In</h2>
<form method="post">
    {% csrf_token %}
    {{ form|crispy }}
    <button class="btn btn-success" type="submit">Log In</button>
</form>
{% endblock content %}
```

Navigate to the login page at `http://127.0.0.1:8000/accounts/login/`.

## Wrapping Up with Git 🎉

Wrapping up, we should always do a Git commit for our work. Check the status of changes in this section, add them all, and then provide a commit message.

```bash
git status
git add .
git commit -m 'Static Assets and Bootstrap'
```

As always, you can compare your code with the official code on GitHub if there are any issues.

## Conclusion 🏁

Static assets are a core part of every website, and in Django, we have to take several additional steps so they are compiled and hosted efficiently in production. We also saw how easy it is to add additional static pages, such as our About page, to our existing site. Additionally, we added Bootstrap and `django-crispy-forms` to improve the styling of our site and our forms. Later on in this section, we’ll learn how to use a dedicated content delivery network (CDN) for hosting and displaying our project’s static files.