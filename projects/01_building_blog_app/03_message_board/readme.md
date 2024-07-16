# Message Board App

In this chapter, we will use a database for the first time to build a basic Message Board application where users can post and read short messages. We’ll explore Django’s powerful built-in admin interface which provides a visual way to make changes to our data. After adding tests, we will push our code to GitHub and deploy the app on Heroku.

Thanks to the powerful Django ORM (Object-Relational Mapper), there is built-in support for multiple database backends: PostgreSQL, MySQL, MariaDB, Oracle, and SQLite. This means that we, as developers, can write the same Python code in a `models.py` file and it will automatically be translated into the correct SQL for each database. The only configuration required is to update the `DATABASES` section of our `django_project/settings.py` file.

For local development, Django defaults to using SQLite because it is file-based and therefore far simpler to use than the other database options that require a dedicated server to be running separate from Django itself.

## Initial Set Up

Since we’ve already set up several Django projects at this point in the book, we can quickly run through the standard commands to begin a new one. We need to do the following:
- Make a new directory for our code called `message-board`
- Install Django in a new virtual environment
- Create a new project called `django_project`
- Create a new app called `posts`
- Update `django_project/settings.py`

In a new command line console, enter the following commands:

```sh
# Windows
cd onedrive\desktop\code
mkdir message-board
cd message-board
pipenv shell
python --version
pipenv install django
django-admin startproject django_project .
python manage.py startapp posts

# macOS
cd ~/desktop/code
mkdir message-board
cd message-board
pipenv shell
python --version
pipenv install django
django-admin startproject django_project .
python manage.py startapp posts
```

Next, we must alert Django to the new app, `posts`, by adding it to the top of the `INSTALLED_APPS` section of our `django_project/settings.py` file.

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "posts", # new
]
```

Then execute the `migrate` command to create an initial database based on Django’s default settings.

```sh
python manage.py migrate
```

If you look inside our directory with the `ls` command, you’ll see the `db.sqlite3` file representing our SQLite database.

```sh
dir
db.sqlite3 django_project manage.py posts
```

To confirm everything works correctly, spin up our local server.

```sh
python manage.py runserver
```

In your web browser, navigate to [http://127.0.0.1:8000/](http://127.0.0.1:8000/) to see the familiar Django welcome page.

## Create a Database Model

Our first task is to create a database model where we can store and display posts from our users. Django’s ORM will automatically turn this model into a database table for us.

Open the `posts/models.py` file and add the following code:

```python
# posts/models.py
from django.db import models

class Post(models.Model): # new
    text = models.TextField()
```

Now that our new model is created we need to activate it. Going forward, whenever we create or modify an existing model we’ll need to update Django in a two-step process:

1. First, we create a migrations file with the `makemigrations` command.
2. Second, we build the actual database with the `migrate` command which executes the instructions in our migrations file.

```sh
python manage.py makemigrations posts
python manage.py migrate
```

## Django Admin

To use the Django admin, we first need to create a superuser who can log in. In your command line console, type `python manage.py createsuperuser` and respond to the prompts for a username, email, and password:

```sh
python manage.py createsuperuser
```

Restart the Django server with `python manage.py runserver` and in your web browser go to [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/). You should see the log in screen for the admin. Log in by entering the username and password you just created. You will see the Django admin homepage next.

In your text editor, open up `posts/admin.py` and add the following code so that the `Post` model is displayed.

```python
# posts/admin.py
from django.contrib import admin
from .models import Post

admin.site.register(Post)
```

Let’s create our first message board post for our database. Click on the + Add button opposite Posts and enter your own content in the Text form field. Click the “Save” button, which will redirect you to the main Post page.

Within the `posts/models.py` file, add a new function `__str__` as follows:

```python
# posts/models.py
from django.db import models

class Post(models.Model):
    text = models.TextField()
    
    def __str__(self): # new
        return self.text[:50]
```

This will display the first 50 characters of the text field. If you refresh your Admin page in the browser, you’ll see it’s changed to a much more descriptive and helpful representation of our database entry.

## Views/Templates/URLs

To display our database content on our homepage, we have to wire up our views, templates, and URLs. Let’s begin with the view. In the `posts/views.py` file, enter the following code:

```python
# posts/views.py
from django.views.generic import ListView
from .models import Post

class HomePageView(ListView):
    model = Post
    template_name = "home.html"
```

Create a new directory called `templates`.

```sh
mkdir templates
```

Update the `DIRS` field in our `django_project/settings.py` file so that Django knows to look in this new `templates` directory.

```python
# django_project/settings.py
TEMPLATES = [
    {
        ...
        "DIRS": [BASE_DIR / "templates"], # new
        ...
    },
]
```

In your text editor, create a new file called `templates/home.html`.

```html
<!-- templates/home.html -->
<h1>Message board homepage</h1>
<ul>
    {% for post in post_list %}
        <li>{{ post.text }}</li>
    {% endfor %}
</ul>
```

The last step is to set up our URLs. Start with the `django_project/urls.py` file.

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include # new

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include("posts.urls")), # new
]
```

Create a new `urls.py` file within the `posts` app and update it like so:

```python
# posts/urls.py
from django.urls import path
from .views import HomePageView

urlpatterns = [
    path("", HomePageView.as_view(), name="home"),
]
```

Restart the server with `python manage.py runserver` and navigate to our homepage, which now lists out our message board post.

## Adding New Posts

To add new posts to our message board, go back into the Admin and create two more posts. If you then return to the homepage you’ll see it automatically displays the formatted posts.

In your text editor create a new `.gitignore` file and add one line:

```plaintext
Pipfile
pycache/
Pipfile.lock
```

Run `git status` again to confirm the `.venv` directory is being ignored, use `git add -A` to add the intended files/directories, and add an initial commit message.

```sh
git status
git add -A
git commit -m "initial commit"
```

## Tests

In the previous chapter, we were only testing static pages so we used `SimpleTestCase`. Now that our project works with a database, we need to use `TestCase`, which will let us create a test database we can check against.

Our `Post` model contains only one field, `text`, so let’s set up our data and then check that it is stored correctly in the database.

```python
# posts/tests.py
from django.test import TestCase
from .models import Post

class PostTests(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.post = Post.objects.create(text="This is a test!")

    def test_model_content(self):
        self.assertEqual(self.post.text, "This is a test!")
```

Go ahead and run the test on the command line with command `python manage.py test`.

```sh
python manage.py test
```

To check our URLs, views, and templates, we want to verify:
- URL exists at `/` and returns a 200 HTTP status code
- URL is available by its name of “home”
- Correct template is used called `home.html`
- Homepage content matches what we expect in the database

```python
# posts/tests.py
from django.test import TestCase
from django.urls import reverse
from .

models import Post

class PostTests(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.post = Post.objects.create(text="This is a test!")

    def test_model_content(self):
        self.assertEqual(self.post.text, "This is a test!")

    def test_url_exists_at_correct_location(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_url_available_by_name(self):
        response = self.client.get(reverse("home"))
        self.assertEqual(response.status_code, 200)

    def test_template_name_correct(self):
        response = self.client.get(reverse("home"))
        self.assertTemplateUsed(response, "home.html")

    def test_template_content(self):
        response = self.client.get(reverse("home"))
        self.assertContains(response, "This is a test!")
```

Run the tests again to confirm that they all pass.

```sh
python manage.py test
```
we discussed how unit tests work best when they are self-contained and
extremely verbose. However there is an argument to be made here that the bottom three tests
are really just testing that the homepage works as expected: it uses the correct URL name, the
intended template name, and contains expected content. We can combine these three tests into
one single unit test, test_homepage.

```python
# posts/tests.py
from django.test import TestCase
from django.urls import reverse
from .

models import Post

class PostTests(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.post = Post.objects.create(text="This is a test!")

    def test_model_content(self):
        self.assertEqual(self.post.text, "This is a test!")

    def test_url_exists_at_correct_location(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_homepage(self): # new
      response = self.client.get(reverse("home"))
      self.assertEqual(response.status_code, 200)
      self.assertTemplateUsed(response, "home.html")
      self.assertContains(response, "This is a test!")
```

We’re done adding code for our testing so it’s time to commit the changes to git.

```sh
git add -A
git commit -m "added tests"
```

## GitHub

Create a new repo called `message-board` on GitHub. Select the “Private” radio button. Copy and paste the two commands there into your terminal.

```sh
git remote add origin https://github.com/HashimThePassionate/message-board.git
git push -u origin main
```

## Heroku Configuration

You should already have a Heroku account set up and installed. Our deployment checklist contains the following steps:
- Install Gunicorn
- Create a `requirements.txt` file
- Update `ALLOWED_HOSTS` in `django_project/settings.py`
- Create a `Procfile`
- Create a `runtime.txt` file

First, install Gunicorn with Pip.

```sh
pipenv install gunicorn==20.1.0
```

Then output the contents of our virtual environment to a `requirements.txt` file.

```sh
pip freeze > requirements.txt
```

Update `ALLOWED_HOSTS` in `django_project/settings.py`.

```python
# django_project/settings.py
ALLOWED_HOSTS = [".herokuapp.com", "localhost", "127.0.0.1"]
```

Create a `Procfile` in the base directory, next to the `manage.py` file.

```plaintext
web: gunicorn django_project.wsgi --log-file -
```

Create a `runtime.txt` file that specifies what version of Python to run within Heroku.

```plaintext
python-3.12
```

Add and commit our new changes to git and then push them up to GitHub.

```sh
git add -A
git commit -m "New updates for Heroku deployment"
git push -u origin main
```

## Heroku Deployment

Make sure you’re logged into your correct Heroku account.

```sh
heroku login
```

Run the create command and Heroku will randomly generate an app name.

```sh
heroku create
```

Instruct Heroku to ignore static files for now.

```sh
heroku config:set DISABLE_COLLECTSTATIC=1
```

Push the code to Heroku and add free scaling.

```sh
git push heroku main
heroku ps:scale web=1
```

Open the URL of the new project from the command line by typing `heroku open`. To finish up, deactivate the current virtual environment by typing `exit` on the command line.

## Conclusion

We’ve now built, tested, and deployed our first database-driven app. In the next section, we’ll learn how to deploy with PostgreSQL and build a Blog application so that users can create, edit, and delete posts on their own. We’ll also add styling via CSS so the site looks better.

