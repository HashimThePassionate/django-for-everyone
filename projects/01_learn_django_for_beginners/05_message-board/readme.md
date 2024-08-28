# Message Board Website

In this section, we will create our first database-backed website, a Message Board application. We will learn about relational databases, write a Django model, perform queries, and manipulate data using the powerful built-in admin interface. We will also write function-based and class-based views before ending with more advanced tests to ensure everything works properly.

## Initial Set Up

Since we’ve already set up several Django projects in the section, we can quickly run through the standard commands to begin a new one. We need to do the following:

- Make a new directory for our code called `message-board` on the desktop
- Set up a new Python virtual environment using `pipenv` and activate it

In a new command line console, enter the following commands:

### Shell Commands

```shell
# Windows
cd onedrive\desktop\code
mkdir message-board
cd message-board
pipenv install django~=5.0.0 black
pipenv shell
```

Then, finish the setup by performing the following actions:

- Create a new project called `django_project`
- Create a new app called `posts`

### Shell Commands

```shell
django-admin startproject django_project .
python manage.py startapp posts
```

As a final step, update `django_project/settings.py` to alert Django to the new app, `posts`, by adding it to the bottom of the `INSTALLED_APPS` section.

### Code

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "posts",  # new
]
```

Then, execute the `migrate` command to create an initial database based on Django’s default settings.

### Shell Commands

```shell
(message-board) $ python manage.py migrate
```

A `db.sqlite3` file is now present with our local database and Django default tables. Spin up our local server to confirm everything works correctly.

### Shell Commands

```shell
python manage.py runserver
```

In your web browser, navigate to `http://127.0.0.1:8000/` to see the familiar Django welcome page.

A major design philosophy of Django, which you will see repeatedly in this section, is that it allows for customization. For example, we don’t have to use port 8000 for local development. We could change it to any other available port, such as 8080. Stop the server with `Ctrl + c` and restart it by passing in the desired port number.

### Shell Commands

```shell
python manage.py runserver 8080
```

If you refresh `http://127.0.0.1:8000/`, you will see an error message, but switching to `http://127.0.0.1:8080/` displays our Hello, World! greeting.

## Databases

Before implementing our Message Board model, it is worth reviewing how databases, ORMs, and Django work together. A database is a place to store and access different types of data, and there are two main types of databases: relational and non-relational.

A relational database stores information in tables containing columns and rows, roughly analogous to an Excel spreadsheet. The columns define what information can be stored; the rows contain the actual data. Frequently, data in separate tables have some relation to each other, hence the term “relational database” to describe databases with this structure of tables, columns, and rows.

SQL (Structured Query Language) is typically used to interact with relational databases to perform basic CRUD (Create, Read, Update, Delete) operations and define the type of relationship (like a many-to-one relationship, for example. We’ll learn more about these shortly.).

A non-relational database is any database that doesn’t use the tables, fields, rows, and columns inherent in relational databases to structure its data: examples include document-oriented, key-value, graph, and wide-column.

Relational databases are best when data is consistent and structured and relationships between entities are essential. Non-relational databases have advantages when data is not structured, needs to be flexible in size or shape, and is open to change in the future. Relational databases have been around far longer and are more widely used, while many non-relational databases were designed recently for specific use in the cloud.

Database design and implementation is an entire field of computer engineering that is very deep and quite interesting but far beyond the scope of this section. The important takeaway for our purposes is that these two types of databases exist. Still, Django only has built-in support for relational databases, so we will focus on that.

### Django’s ORM

An ORM (Object-Relational Mapper) is a powerful programming technique that makes working with data and relational databases much easier. In the case of Django, its ORM means we can write Python code to define database models; we don’t have to write raw SQL ourselves. And we don’t have to worry about subtle differences in how each database interprets SQL. Instead, the Django ORM supports five relational databases: SQLite, PostgreSQL, MySQL, MariaDB, and Oracle. It also comes with support for migrations, which provides a way to track and sync database changes over time. In sum, the Django ORM saves developers a tremendous amount of time, which is one of the major reasons why Django is so efficient.

While the ORM abstracts much of the work, we still need a basic understanding of relational databases to implement them correctly. For example, before writing any actual code, let’s look at structuring the data in our Message Board model. We will have only one table called “Post” and a single field, “text,” containing the contents of a message. If we drew this out as a simple schema, it would look something like this:

### Post Schema

| Post |
|------|
| TEXT |

The actual database table with rows of actual messages would look like this:

### Post Database Table

| Post                         |
|------------------------------|
| My first message board post. |
| A 2nd post!                  |
| A third message.             |

### Database Model

Now that we know how our database table should look, let’s use Django’s ORM to define it using Python. Open the `posts/models.py` file and look at the default code which Django provides:

### Code

```python
# posts/models.py
from django.db import models

# Create your models here
```

Django imports a module, `models`, to help us build new database models that will “model” the characteristics of the data in our database. For each database model we want to create, the approach is to subclass (meaning to extend) `django.db.models.Model` and then add our fields. Type in the following code, which we will review below:

### Code

```python
# posts/models.py
from django.db import models

class Post(models.Model):  # new
    text = models.TextField()
```

We’ve created a new table model called `Post`, which has the table field `text`. We’ve also specified the type of content it will hold, `TextField()`. Django provides many [model fields](https://docs.djangoproject.com/en/5.0/ref/models/fields/) supporting common types of content such as characters, dates, integers, emails, and so on. We will explore these later. For now, we have written our first model!

### Activating Models

After creating a model, the next step is activating it. From now on, whenever we make or modify an existing model, we’ll need to update Django in a two-step process:

1. First, we create a migrations file with the `makemigrations` command. Migration files record any changes to the database models, which means we can track changes over time and debug errors as necessary.
2. Second, we build the database with the `migrate` command, which executes the instructions in our migrations file.

Ensure the local server is stopped by typing `Control+c` on the command line and then run the commands `python manage.py makemigrations posts` and `python manage.py migrate`.

### Shell Commands

```shell
python manage.py makemigrations posts

Migrations for 'posts':
  posts/migrations/0001_initial.py
    - Create model Post

python manage.py migrate

Operations to perform:
  Apply all migrations: admin, auth, contenttypes, posts, sessions
Running migrations:
  Applying posts.0001_initial... OK
```

You don’t have to include a name after `makemigrations`. If you just run `makemigrations` without specifying an app, a migrations file will be created for all available changes throughout the Django project. That is fine in a small project like ours with only a single app, but most Django projects have more than one app! Therefore, if you made model changes in multiple apps, the resulting migrations file would include all those changes: not ideal! Migration files should be as small and concise as possible, making it easier to debug in the future or even roll back changes as needed. Therefore, as a best practice, adopt the habit of always including the name of an app when executing the `makemigrations` command!

### Django Admin

One of Django’s killer features is its robust admin interface that visually interacts with data. It came about because  [Django started](https://docs.djangoproject.com/en/5.0/faq/general/) as a newspaper CMS (Content Management System). The idea was that journalists could write and edit their stories in the admin without needing to touch code.Over time, the built-in admin app has evolved into a fantastic, out-of-the-box tool for managing all aspects of a Django project.

To use the Django admin, we must first create a superuser who can log in. In your command line console, type `python manage.py createsuperuser` and respond to the prompts for a username, email, and password:

### Shell Commands

```shell
python manage.py createsuperuser
Username (leave blank to use 'dell'): hashim
Email address: hashiimtahir@gmail.com
Password: 
Password (again): 
Bypass password validation and create user anyway? [y/N]: y
Superuser created successfully.
```

When you type your password, it will not appear visible in the command line console for security reasons. For local development, I often use `testpass123`. Restart the Django server with `python manage.py runserver` and, in your web browser, go to `http://127.0.0.1:8000/admin/`. You should see the login screen for the admin:

Log in by entering the username and password you just created. You will see the Django admin homepage next:

But where is our `posts` app since it is not displayed on the main admin page? Just as we must explicitly add new apps to the `INSTALLED_APPS` config, we must also update an app’s `admin.py` file for it to appear in the admin.

In your text editor, open up `posts/admin.py` and add the following code to display the `Post` model.

### Code

```python
# posts/admin.py
from django.contrib import admin
from .models import Post

admin.site.register(Post)
```

Django knows it should display our `posts` app and its database model `Post` on the admin page. If you refresh your browser, you’ll see that it appears:


Let’s create our first message board post for our database. Click the `+ Add` button opposite `Posts` and enter your content in the Text form field.


Then click the “Save” button to redirect you to the main `Post` page. However, if you look closely, there’s a problem: our new entry is called “Post object (1)”, which isn’t very descriptive!


Let’s change that. Within the `posts/models.py` file, add a new method called `__str__`, which provides a human-readable representation of the model. In this case, we’ll have it display the first 50 characters of the `text` field.

### Code

```python
# posts/models.py
from django.db import models

class Post(models.Model):
    text = models.TextField()

    def __str__(self):  # new
        return self.text[:50]
```

If you refresh your Admin page in the browser, you’ll see that it now represents our database entry in a much more descriptive and helpful way.


Much better! It’s a best practice to add `__str__()` methods to all your models to improve their readability.

Let’s add two more entries using the same method, so we have three total to work with in the next section. You can use the “Add Post +” button in the upper right corner.


## Function-Based View

To display our message board posts on the homepage, we have to wire up a view, template, and URL. This pattern should start to feel familiar now.

Let’s begin with the view. We’ll initially write a function-based view and switch to a generic class-based view. In the `posts/views.py` file, replace the default text and enter the Python code below:

### Code

```python
# posts/views.py
from django.shortcuts import render
from .models import Post

def post_list(request):
    posts = Post.objects.all()
    return render(request, "post_list.html", {"posts": posts})
```

On the first line, we import the `render()` shortcut function, which combines a template with a context dictionary and returns an `HttpResponse` object. Then, we import our database model, `Post`, from the `models.py` file.

We define a function, `post_list`, and name the request object `request` per Django convention. Then, we set a variable, `posts`, to a database query containing all `Post` objects. Then we use `render()` to return the request object, define the template as the second argument, and then in the third argument, define a context dictionary called `posts` that matches the value of the `posts` variable we set on the previous line.

Let’s examine `Post.objects.all()` in more detail as it is the first example of a Database query via the Django ORM.

1. **Post**: This refers to our model class, which represents a table in the database where each row corresponds to an instance of the `Post` model.
 
2. **objects**: This is the default manager for the `Post` model. A [manager](https://docs.djangoproject.com/en/5.0/topics/db/managers/) provides a way to interact with the database and perform queries. By default, Django adds a Manager named “objects” to every Django model class.

3. **all()**: This is a method provided by the manager that returns a [QuerySet](https://docs.djangoproject.com/en/5.0/ref/models/querysets/) containing all instances of the `Post` model from the database. A `QuerySet` is a collection of database queries to retrieve objects.

The `QuerySet API reference` is an invaluable resource in the official documentation that covers all available methods. You are not expected to memorize all of these. Rather, the traditional approach is to have a problem with querying data and then search for a built-in method. You will likely find one already exists.

## Templates and URLs

We already have a model and view, which means only a template and URL are left to configure. Let’s start with the template. Create a new project-level directory called `templates`.

### Shell Commands

```shell
mkdir templates
```

Then, update the `DIRS` field in our `django_project/settings.py` file so Django can look in this new `templates` directory.

### Code

```python
# django_project/settings.py
TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [BASE_DIR / "templates"],  # new
        "APP_DIRS": True,
        ...
    },
]
```

In your text editor, create a new file called `templates/post_list.html`. Our template context contains a dictionary called `posts` which we need to loop over via the `for` template tag. We’ll create a variable called `post` and can then access the desired field we want to be displayed, `text`, as `post.text`.

### Code

```html
<!-- templates/post_list.html -->
<h1>Message Board Homepage</h1>
<ul>
    {% for post in posts %}
    <li>{{ post.text }}</li>
    {% endfor %}
</ul>
```

The last step is to set up our URLs. Let’s start with the `django_project/urls.py` file, where we include our `posts` app and add `include` on the second line.

### Code

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include  # new

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include("posts.urls")),  # new
]
```

Then, in your text editor, create a new `urls.py` file within the `posts` app and update it like so:

### Code

```python
# posts/urls.py
from django.urls import path
from .views import post_list

urlpatterns = [
    path("", post_list, name="home"),
]
```

Restart the server with `python manage.py runserver` and navigate to our homepage, which lists our message board posts.

If you navigate to the Django admin and add or delete message board posts, the homepage will be updated to reflect the changes.

## ListView

In the previous section, we wrote a function-based view and then switched to the built-in generic `TemplateView` to display a template file on our homepage. Listing out all items in a database model is so common that a generic class-based view exists for this, too, called `ListView`. We will now switch over to it for educational purposes. There is no right or wrong answer regarding function-based versus generic class-based views: it is a matter of preference.

In the `posts/views.py` file, comment out the existing code for our function-based view and add new code for the class-based view implementation. Import on the top line `ListView` and then create a `PostList` class that extends it. We define the desired model, `Post`, and then the template name, `post_list.html`.

### Code

```python
# posts/views.py
# from django.shortcuts import render
# from .models import Post

# def post_list(request):
#     posts = Post.objects.all()
#     return render(request, "post_list.html", {"posts": posts})

from django.views.generic import ListView  # new
from .models import Post

class PostList(ListView):  # new
    model = Post
    template_name = "post_list.html"
```

The current template uses a context dictionary called `posts`. By default, `ListView` returns a context variable called `<model>_list`, where `<model>` is our model name. Since our model is named `post`, we need to loop over `post_list` with our `for` loop. The rest of the template remains the same.

### Code

```html
<!-- templates/post_list.html -->
<h1>Message board homepage</h1>
<ul>
    {% for post in post_list %}
    <li>{{ post.text }}</li>
    {% endfor %}
</ul>
```

The final step is to update `posts/urls.py` with the new name for our view, `PostList`. We can comment out or delete the previous code. Remember that we must also add the `as_view()` method to return a callable view.

### Code

```python
# posts/urls.py
from django.urls import path
# from .views import post_list
from .views import PostList  # new

urlpatterns = [
    # path("", post_list, name="post_list"),
    path("", PostList.as_view(), name="home"),  # new
]
```

And that’s it! If you refresh your home page, it should work just as before. We have written a new view, updated the name of the context variable in the template, and updated the URL file.

## Initial Commit

Everything works, so it is a good time to initialize our directory and create a `.gitignore` file. We can initialize a new Git repository from the command line with the `git init` command.

### Shell Commands

```shell
git init
```

Then, in your text editor, create a new `.gitignore` file in the root directory and add three lines so that the `Pipfile` and `Pipfile.lock` files, Python bytecode, and the `db.sqlite` file are not tracked.

### .gitignore

```plaintext
Pipfile
Pipfile.lock
__pycache__/
*.sqlite3
```

If you now run `git status`, the `Pipfile` and `Pipfile.lock` files, `__pycache__` directory, and the `db.sqlite3` file are ignored. Use `git add -A` to add the intended files/directories and write an initial commit message.

### Shell Commands

```shell
git status -s
git add .
git commit -m "initial commit"
```

## Tests

Now that our project works with a database, we need to use `TestCase`, which will let us create a test database. In other words, we don’t need to run tests on our actual database, but instead, we can make a separate test database, fill it with sample data, and test against it, which is a much safer and more performant approach.

Our `Post` model contains only one field, `text`, so let’s set up our data and then check that it is stored correctly in the database. All test methods must start with the phrase `test` so Django knows to test them!

We will use the hook `setUpTestData()` to create our test data: it is much faster than using the `setUp()` hook from Python’s `unittest` because it creates the test data only once per test case rather than per test. It is still common, however, to see Django projects that rely on `setUp()` instead. Converting any such tests over to `setUpTestData` is a reliable way to speed up a test suite and should be done!

`setUpTestData()` is a `classmethod`, which means it is a method that can transform into a class. To use it, we’ll use the `@classmethod` function decorator. As [PEP 8](https://peps.python.org/pep-0008/#function-and-method-arguments) explains, in Python, it is a best practice to always use `cls` as the first argument to class methods. Here is what the code looks like:

### Code

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

At the top, we import `TestCase` and our `Post` model. Then, we create a test class, `PostTests`, that extends `TestCase` and uses the built-in method `setUpTestData` to develop initial data. In this instance, we only have one item stored as `cls.post` that can be referred to in subsequent tests within the class as `self.post`. Our first test, `test_model_content`, uses `assertEqual` to check that the content of the `text` field matches what we expect.

Run the test on the command line with the command `python manage.py test`.

### Shell Commands

```shell
python manage.py test

Found 1 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.
----------------------------------------------------------------------
Ran 1 test in 0.001s

OK
Destroying test database for alias 'default'...
```

It passed! Why does the output say only one test ran when we have two functions? Again, only functions that start with the name `test` will be run! So, while we can use setup functions and classes to help with our tests, unless a function is named correctly, it won’t be executed with the `python manage.py test` command.

It is time to check our URLs, views, and templates. We want to check the following four things for our message board page:

- URL exists at `/` and returns a 200 HTTP status code
- URL is available by its name of `home`
- Correct template is used called `post_list.html`
- Homepage content matches what we expect in the database

Since this project has only one webpage, we can include all of these tests in our existing `PostTests` class. Make sure to import `reverse` at the top of the page and add the four tests as follows:

### Code

```python
# posts/tests.py
from django.test import TestCase
from django.urls import reverse  # new
from .models import Post

class PostTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.post = Post.objects.create(text="This is a test!")

    def test_model_content(self):
        self.assertEqual(self.post.text, "This is a test!")

    def test_url_exists_at_correct_location(self):  # new
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_url_available_by_name(self):  # new
        response = self.client.get(reverse("home"))
        self.assertEqual(response.status_code, 200)

    def test_template_name_correct(self):  # new
        response = self.client.get(reverse("home"))
        self.assertTemplateUsed(response, "post_list.html")

    def test_template_content(self):  # new
        response = self.client.get(reverse("home"))
        self.assertContains(response, "This is a test!")
```

If you rerun our tests, you should see that they all pass.

### Shell Commands

```shell
python manage.py test

Found 5 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.
----------------------------------------------------------------------
Ran 5 tests in 0.006s

OK
Destroying test database for alias 'default'...
```

In the previous section, we discussed how unit tests work best when they are self-contained and highly verbose. However, there is an argument to be made here that the bottom three tests are just testing that the homepage works as expected: it uses the correct URL name and the intended template name and contains expected content. We can combine these three tests into one unit test, `test_homepage`.

### Code

```python
# posts/tests.py
from django.test import TestCase
from django.urls import reverse  # new
from .models import Post

class PostTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.post = Post.objects.create(text="This is a test!")

    def test_model_content(self):
        self.assertEqual(self.post.text, "This is a test!")

    def test_url_exists_at_correct_location(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_homepage(self):  # new
        response = self.client.get(reverse("home"))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, "post_list.html")
        self.assertContains(response, "This is a test!")
```

Run the tests one last time to confirm that they all pass.

### Shell Commands

```shell
python manage.py test

Found 3 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.
----------------------------------------------------------------------
Ran 3 tests in 0.005s

OK
Destroying test database for alias 'default'...
```

Ultimately, we want our test suite to cover as much code functionality as possible yet remain easy for us to reason about. This update is easier

 to read and understand.

That’s enough tests for now; it’s time to commit the changes to Git.

### Shell Commands

```shell
git add .
git commit -m "added tests"
```

## GitHub

We also need to store our code on GitHub. Since you should already have a GitHub account from previous sections, create a new repo called `message-board`. Select the “Private” radio button.

On the next page, scroll down to where it says, “…or push an existing repository from the command line.” Copy and paste the two commands there into your terminal, which should look like the below after replacing `wsvincent` (my username) with your GitHub username:

### Shell Commands

```shell
git remote add origin https://github.com/yourusername/message-board.git
git branch -M main
git push -u origin main
```

## Conclusion

We’ve built and tested our first database-driven app and learned how to create a database model, update it with the admin panel, and write tests. We also looked at both function-based and class-based approaches for the views. In the next section, we will build a more complex Blog application with user accounts for signup and login, allowing users to create/edit/delete their posts and then add CSS for styling.
