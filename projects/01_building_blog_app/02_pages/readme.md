# Pages App

In this section, we will build, test, and deploy a Pages app containing a homepage and an about page. We won't touch the database yet—that comes in the next section—but we’ll learn about class-based views and templates, which are the building blocks for more complex web applications built later on in the section.


## Initial Set Up

As in section 2: Hello World App, our initial setup involves the following steps:

1. Create a new directory for our code called `pages` and navigate into it.
2. Create a new virtual environment using `pipenv`.
3. Install Django.
4. Create a new Django project called `django_project`  .
5. Create a new app called `pages`.

On the command line, make sure you’re not working in an existing virtual environment. If there is text before the command line prompt—either `>` on Windows or `%` on macOS—then you are! Type `deactivate` to leave it.

Within a new command line shell, start by typing the following:

#### Windows
```shell
cd onedrive\desktop\code
mkdir pages
cd pages
pipenv install django==5.0
pipenv shell
django-admin startproject django_project .
python manage.py startapp pages
```

#### macOS
```shell
cd ~/desktop/code
mkdir pages
cd pages
pipenv install django==5.0
pipenv shell
django-admin startproject django_project .
python manage.py startapp pages
```

Even though we added a new app, Django will not recognize it until it is added to the `INSTALLED_APPS` setting within `django_project/settings.py`. Open your text editor and add it to the bottom now:

```python
# django_project/settings.py
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

Migrate the database with `migrate` and start the local web server with `runserver`.

```shell
python manage.py migrate
python manage.py runserver
```

Then navigate to [http://127.0.0.1:8000/](http://127.0.0.1:8000/).

---

### Templates

Every web framework needs a convenient way to generate HTML files. In Django, the approach is to use templates: individual HTML files that can be linked together and also include basic logic.

In this section, we’ll learn how to use templates to more easily create our desired homepage and about page. The first consideration is where to place templates within the structure of a Django project.

#### Template Directory Structure

By default, Django’s template loader looks within each app for related templates. This structure involves creating a `templates` directory within the app, another directory with the same name as the app, and then the template file:

```shell
└── pages
    ├── templates
    ├── pages
        ├── home.html
```

Alternatively, we can create a single project-level `templates` directory and place all templates within it. By making a small tweak to our `django_project/settings.py` file, we can tell Django to also look in this directory for templates.

First, quit the running server with the `Control+c` command. Then create a directory called `templates`.

```shell
mkdir templates
```

Next, update `django_project/settings.py` to tell Django the location of our new `templates` directory. This is a one-line change to the setting `"DIRS"` under `TEMPLATES`.

```python
# django_project/settings.py
TEMPLATES = [
    {
        ...
        "DIRS": [BASE_DIR / "templates"],  # new
        ...
    },
]
```

Within the `templates` directory, create a new file called `home.html`. The file will have a simple headline for now.

```html
<!-- templates/home.html -->
<h1>Homepage</h1>
```

---

### Class-Based Views

In our view, we will use the built-in `TemplateView` to display our template. Update the `pages/views.py` file.

```python
# pages/views.py
from django.views.generic import TemplateView

class HomePageView(TemplateView):
    template_name = "home.html"
```

### URLs

The last step is to update our URLs. Update the `django_project/urls.py` file to point at our pages app.

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include  # new

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include("pages.urls")),  # new
]
```

Next, create a file called `pages/urls.py` and add the code below. When using Class-Based Views, you always add `as_view()` at the end of the view name.

```python
# pages/urls.py
from django.urls import path
from .views import HomePageView

urlpatterns = [
    path("", HomePageView.as_view(), name="home"),
]
```

Start up the local web server with `python manage.py runserver` and navigate to [http://127.0.0.1:8000/](http://127.0.0.1:8000/) to see our new homepage.

---

### About Page

The process for adding an about page is very similar to what we just did. We’ll create a new template file, a new view, and a new URL route.

Create a new template file called `templates/about.html` and populate it with a short HTML headline.

```html
<!-- templates/about.html -->
<h1>About page</h1>
```

Then add a new view for the page.

```python
# pages/views.py
from django.views.generic import TemplateView

class HomePageView(TemplateView):
    template_name = "home.html"

class AboutPageView(TemplateView):  # new
    template_name = "about.html"
```

Finally, import the view name and connect it to a URL at `about/`.

```python
# pages/urls.py
from django.urls import path
from .views import HomePageView, AboutPageView  # new

urlpatterns = [
    path("about/", AboutPageView.as_view(), name="about"),  # new
    path("", HomePageView.as_view(), name="home"),
]
```

Start up the web server with `runserver` and navigate to [http://127.0.0.1:8000/about](http://127.0.0.1:8000/about). The new About page is visible.

---

### Extending Templates

The real power of templates is their ability to be extended. Let’s create a `base.html` file containing a header with links to our two pages. In your text editor, make this new file called `templates/base.html`.

```html
<!-- templates/base.html -->
<header>
    <a href="{% url 'home' %}">Home</a> |
    <a href="{% url 'about' %}">About</a>
</header>
{% block content %} {% endblock content %}
```

Update `home.html` and `about.html` files to extend the `base.html` template.

```html
<!-- templates/home.html -->
{% extends "base.html" %}
{% block content %}
<h1>Homepage</h1>
{% endblock content %}
```

```html
<!-- templates/about.html -->
{% extends "base.html" %}
{% block content %}
<h1>About page</h1>
{% endblock content %}
```

Start up the server with `python manage.py runserver` and open our webpages again at [http://127.0.0.1:8000/](http://127.0.0.1:8000/). The header is included.

---

### Tests

It's important to add automated tests and run them whenever a codebase changes. Testing can be divided into two main categories: unit and integration.

Since no database is involved yet in our project, we will import `SimpleTestCase` at the top of the file. For our first tests, we’ll check that the two URLs for our website, the homepage and about page, both return HTTP status codes of 200.

```python
# pages/tests.py
from django.test import SimpleTestCase

class HomepageTests(SimpleTestCase):
    def test_url_exists_at_correct_location(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

class AboutpageTests(SimpleTestCase):
    def test_url_exists_at_correct_location(self):
        response = self.client.get("/about/")
        self.assertEqual(response.status_code, 200)
```

To run the tests, quit the server with `Control+c` and type `python manage.py test` on the command line.

```shell
python manage.py test
System check identified no issues (0 silenced).
..
----------------------------------------------------------------------
Ran 2 tests in 0.006s
OK
```

We can use the Django utility function `reverse` to check the URL name for each page. Make sure to import `reverse` at the top of the file and add a new unit test for each below.

```python
# pages/tests.py
from django.test import SimpleTestCase
from django.urls import reverse  # new

class HomepageTests(SimpleTestCase):
    def test_url_exists_at_correct_location(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_url_available_by_name(self):  # new
        response = self.client.get(reverse("home"))
        self.assertEqual(response.status_code, 200)

class AboutpageTests(Simple

TestCase):
    def test_url_exists_at_correct_location(self):
        response = self.client.get("/about/")
        self.assertEqual(response.status_code, 200)

    def test_url_available_by_name(self):  # new
        response = self.client.get(reverse("about"))
        self.assertEqual(response.status_code, 200)
```

Run the tests again to confirm that they work correctly.

```shell
python manage.py test
System check identified no issues (0 silenced).
..
----------------------------------------------------------------------
Ran 4 tests in 0.007s
OK
```

We have tested our URL locations and URL names so far but not our templates. Let’s make sure that the correct templates—`home.html` and `about.html`—are used on each page and that they display the expected content of `<h1>Homepage</h1>` and `<h1>About page</h1>` respectively.

```python
# pages/tests.py
from django.test import SimpleTestCase
from django.urls import reverse

class HomepageTests(SimpleTestCase):
    def test_url_exists_at_correct_location(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_url_available_by_name(self):
        response = self.client.get(reverse("home"))
        self.assertEqual(response.status_code, 200)

    def test_template_name_correct(self):  # new
        response = self.client.get(reverse("home"))
        self.assertTemplateUsed(response, "home.html")

    def test_template_content(self):  # new
        response = self.client.get(reverse("home"))
        self.assertContains(response, "<h1>Homepage</h1>")

class AboutpageTests(SimpleTestCase):
    def test_url_exists_at_correct_location(self):
        response = self.client.get("/about/")
        self.assertEqual(response.status_code, 200)

    def test_url_available_by_name(self):
        response = self.client.get(reverse("about"))
        self.assertEqual(response.status_code, 200)

    def test_template_name_correct(self):  # new
        response = self.client.get(reverse("about"))
        self.assertTemplateUsed(response, "about.html")

    def test_template_content(self):  # new
        response = self.client.get(reverse("about"))
        self.assertContains(response, "<h1>About page</h1>")
```

Run the tests one last time to check our new work. Everything should pass.

```shell
python manage.py test
System check identified no issues (0 silenced).
..
----------------------------------------------------------------------
Ran 8 tests in 0.009s
OK
```

---

### Git and GitHub

It's time to track our changes with Git and push them up to GitHub. Start by initializing our directory and checking the status of our changes.

```shell
git init
git status
```

Use `git status` to see all our code changes. Notice that the `.venv` directory with our virtual environment is included? We don’t want that. In your text editor, create a new hidden file, `.gitignore`, so we can specify what Git will not track.

```text
__pycache__/
migrations/ 
db.sqlite3
Pipfile
Pipfile.lock 
```

Run `git status` again to confirm these two files are being ignored, then use `git add -A` to add the intended files/directories, and finally add an initial commit message.

```shell
git status
git add .
git commit -m "initial commit"
```

On GitHub, create a new repo called `pages` and make sure to select the “Private” radio button. Then click on the “Create repository” button.

On the next page, scroll down to where it says “…or push an existing repository from the command line.” Copy and paste the two commands there into your terminal. It should look like the below:

```shell
git remote add origin https://github.com/YOUR_USERNAME/pages.git
git push -u origin main
```

---

### Local vs Production

To make our site available on the Internet, we need to deploy our code to an external server and database. This is called putting our code into production. Local code lives only on our computer; production code lives on an external server available to everyone.

The `startproject` command creates a new project configured for local development via the file `django_project/settings.py`. This ease-of-use means when it does come time to push the project into production, a number of settings have to be changed.

One of these is the web server. Django comes with its own basic server, suitable for local usage, but it is not suitable for production. We will use Gunicorn and Heroku for our hosting provider.

#### Heroku

Sign up for a free Heroku account on their website. After registration, install Heroku’s Command Line Interface (CLI).

#### Windows

To install the Heroku CLI on Windows, follow these steps:

1. Go to the [Heroku CLI download page](https://devcenter.heroku.com/articles/heroku-cli#download-and-install).
2. Click on the "Windows 64-bit installer" link to download the installer.
3. Run the installer and follow the on-screen instructions to complete the installation.

Once the installation is complete, open a new command prompt and type `heroku login` to log in to your Heroku account.

```shell
heroku login
```

#### macOS

Use the package manager Homebrew for installation. If not already on your machine, install Homebrew by copying and pasting the command on the Homebrew website into your command line.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Next, install the Heroku CLI:

```shell
brew tap heroku/brew && brew install heroku
```

Once installation is complete, return to the initial tab with the pages virtual environment active. Type the command `heroku login` and use your Heroku email and password.

```shell
heroku login
```

#### Deployment Checklist

Deployment requires several steps. Here is the current checklist:

1. Install Gunicorn
2. Create a `requirements.txt` file
3. Update `ALLOWED_HOSTS` in `django_project/settings.py`
4. Create a `Procfile`
5. Create a `runtime.txt` file

Install Gunicorn:

```shell
pipenv install gunicorn==20.1.0
```

Create a `requirements.txt` file:

```shell
pip freeze > requirements.txt
```

Update `ALLOWED_HOSTS` in `django_project/settings.py`:

```python
# django_project/settings.py
ALLOWED_HOSTS = ["*"]
```

Create a `Procfile` in the base directory next to `manage.py`:

```text
Procfile
web: gunicorn django_project.wsgi --log-file -
```

Specify the Python version in a `runtime.txt` file:

```text
runtime.txt
python-3.12.2
```

Use `git status` to check our changes, add the new files, and then commit them:

```shell
git status
git add -A
git commit -m "New updates for Heroku deployment"
```

Push to GitHub:

```shell
git push -u origin main
```

Create a new Heroku app:

```shell
heroku create
```

Disable the collection of static files:

```shell
heroku config:set DISABLE_COLLECTSTATIC=1
```

Push our code to Heroku:

```shell
git push heroku main
```

Make our Heroku app live:

```shell
heroku ps:scale web=1
```

Confirm our app is live and online:

```shell
heroku open
```

---

### Conclusion

Congratulations on building and deploying your second Django project! This time we used templates, class-based views, explored URLs more fully, added basic tests, and used Heroku. Deployment is hard even with a tool like Heroku, but the steps required are the same for most projects.