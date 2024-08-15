# Section: Pages App 📄

## 🏠 Building a Homepage

Let's build a homepage for our new project. For now, this will be a static page, meaning it won't interact with the database in any way. Later on, it will be a dynamic page displaying books for sale, but… one thing at a time. 😉

It's common to have multiple static pages in even a mature project, such as an "About" page. So, let's create a dedicated `pages` app for them. Use the `startapp` command again to make a pages app.

### Clean the Data Directory: 
if you stuck with volumes and postgresql is not started

```bash
docker-compose down -v  # This will remove the volumes
docker-compose up -d --build
```

I get error postgresql services not started, because of previous volume already created 

### 🛠 Shell Commands

```bash
docker-compose exec web python manage.py startapp pages
```

**Command**: `docker-compose exec web python manage.py startapp pages`

1. **`docker-compose exec`** 🐳🔧
   - **Docker Compose** tool 🛠️
   - **`exec`** to run a command inside a container ✨

2. **`web`** 🖥️
   - Target container name 📦

3. **`python manage.py`** 🐍📜
   - Run **Python** script 🐍
   - **`manage.py`** for Django project management 📜

4. **`startapp pages`** 🆕📄
   - Create new Django app 🆕
   - Name it **`pages`** 📄


Then, add it to our `INSTALLED_APPS` setting. We’ll also update `TEMPLATES` so that Django will look for a project-level templates folder. By default, Django looks within each app for a `templates` folder, but organizing all templates in one place is easier to manage.

### 🔧 Code Updates

Update your `settings.py` file as follows:

```python
# django_project/settings.py

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # Local
    "accounts",
    "pages", # new
]

TEMPLATES = [
    {
        ...
        "DIRS": [BASE_DIR / "templates"], # new
        ...
    }
]
```

Updating the `DIRS` setting means that Django will also look in this new folder; it will still look for any `templates` folders within an app.

## 📂 Setting Up Templates

Next, let's create that new `templates` directory on the command line.

### 🛠 Shell Commands

```bash
mkdir templates
```

Then, with your text editor, create two new files within it: `templates/_base.html` and `templates/home.html`. The first base-level file will be inherited by all other files, and `home.html` will be our homepage.

### 💡 Naming Conventions

Why call the base template `_base.html` with the underscore instead of `base.html`? This is an optional practice, but some developers prefer to add an underscore (`_`) to files solely meant to be inherited by other files.

In the base file, we’ll include the bare minimum needed and add block tags for both `title` and `content`. Block tags give higher-level templates the option to override just the content within the tags. For example, the homepage will have a title of “Home,” but we want that to appear between HTML `<title></title>` tags. Using block tags makes it easier to update this content, as needed, in inherited templates.

Why use the name `content` for the main content of our project? This name could be anything—`main` or some other generic indicator—but using `content` is a common naming convention in the Django world. Can you use something else? Absolutely. Is `content` the most common one you’ll see? Yes. 😊

### 🔧 Base Template Code

```html
<!-- templates/_base.html -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{% block title %}Bookstore{% endblock title %}</title>
</head>
<body>
    <div class="container">
        {% block content %}
        {% endblock content %}
    </div>
</body>
</html>
```

### 🔧 Homepage Template Code

```html
<!-- templates/home.html -->
{% extends "_base.html" %}

{% block title %}Home{% endblock title %}

{% block content %}
<h1>This is our home page.</h1>
{% endblock content %}
```

## 🌐 URLs and Views

Every webpage in our Django project needs a `urls.py` and `views.py` file to go along with the template. For beginners, the fact that order doesn’t really matter here—we need all three files and often a fourth, `models.py`, for the database—can be confusing. Generally, I prefer to start with the URLs and work from there, but there is no “right way” to build out this connected web of Django files.

### 🛠 Setting up URLs

Let’s start with our project-level `urls.py` to set the proper path for webpages within the pages app. Since we want to create a homepage, we add no additional prefix to the URL route, which is designated by the empty string `""`. We also import `include` on the second line to concisely add the pages app to our main `urls.py` file.

```python
# django_project/urls.py

from django.contrib import admin
from django.urls import path, include # new

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include("pages.urls")), # new
]
```

### 🛠 Creating URLs for Pages

Next, create a `pages/urls.py` file with your text editor. This file will import the `HomePageView` and set the path, again, to the empty string `""`. Note that we provide an optional, but recommended, named URL of `"home"` at the end. This will come in handy shortly.

```python
# pages/urls.py

from django.urls import path
from .views import HomePageView

urlpatterns = [
    path("", HomePageView.as_view(), name="home"),
]
```

### 🛠 Creating the Views

Finally, we need a `views.py` file. We can leverage Django’s built-in `TemplateView` so that the only tweak needed is to specify our desired template, `home.html`.

```python
# pages/views.py

from django.views.generic import TemplateView

class HomePageView(TemplateView):
    template_name = "home.html"
```

## 🧪 Running the Project

We’re almost done! If you navigate to the homepage now at `http://127.0.0.1:8000/`, you’ll actually see an error. But what’s causing it? Since we’re running the container in background detached mode (that `-d` flag), we must explicitly check the logs to see console output.

### 🛠 Checking Logs

In the shell, type `docker-compose logs`, which will turn up an error: `ModuleNotFoundError: No module named ‘pages.urls’`. What’s happening is that Django does not automatically update the `django_project/settings.py` file for us based on a change. In a non-Docker world, stopping and restarting the server does the trick since the settings variables are loaded upfront. We must do the same here, which means typing `docker-compose down` and then `docker-compose up -d` to load the new pages app properly.

```bash
docker-compose down
docker-compose up -d
```

Refresh the homepage now, and it will work! 🎉

## 🧪 Testing

### 🧪 Setting Up Tests

Time for tests! For our homepage, we can use Django’s `SimpleTestCase`, which is a special subset of Django’s `TestCase` that is designed for webpages that do not have a model included.

Testing can feel overwhelming at first, but it quickly becomes a bit boring. You’ll use the same structure and techniques over and over again. In your text editor, update the existing `pages/tests.py` file. We’ll start by testing the template.

### 🔧 Testing Code

```python
# pages/tests.py

from django.test import SimpleTestCase
from django.urls import reverse

class HomepageTests(SimpleTestCase):

    def test_url_exists_at_correct_location(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_homepage_url_name(self):
        response = self.client.get(reverse("home"))
        self.assertEqual(response.status_code, 200)
```

At the top, we import `SimpleTestCase` as well as `reverse`, which is useful for testing our URLs. Then we create a class called `HomepageTests` that extends `SimpleTestCase` and within it add a method for each unit test.

Note that we’re adding `self` as the first argument of each unit test. This is a Python convention that is worth repeating.

It is best to be overly descriptive with your unit test names but be aware that each method must start with `test` to be run by the Django test suite.

The two tests here both check that the HTTP status code for the homepage equals `200`, which means that it exists. It does not yet tell us anything specific about the contents of the page. For `test_url_exists_at_correct_location`, we’re creating a variable called `response` that accesses the homepage (`/`) and then uses Python’s `assertEqual` to check that the status code matches `200`. A similar pattern exists for `test_homepage_url_name`, except that we are calling the URL name of home via the `reverse` method. Recall that we added this to the `pages/urls.py` file as a best practice. Even if we change the actual route of this page in the future, we can still refer to it by the same `home` URL name.

### 🛠 Running Tests

To run our tests, execute the command prefaced with `docker-compose exec web` so that it runs within Docker itself.

```bash
docker-compose exec web python manage.py test
```

You'll see output like this:

```bash
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
..
----------------------------------------------------------------------
Ran 4 tests in 0.126s
OK
Destroying test database for alias 'default'...
```

Why does it say 4 tests when

 we only created 2? Because we’re testing the entire Django project, and in the previous section under `users/tests.py`, we added two tests for the custom user model. If we wanted to only run tests for the pages app, we simply append that name onto the command:

```bash
docker-compose exec web python manage.py test pages
```

### 🧪 Testing Templates

So far, we’ve tested that the homepage exists, but we should also confirm that it uses the correct template. `SimpleTestCase` comes with a method `assertTemplateUsed` just for this purpose! Let’s use it.

```python
# pages/tests.py

from django.test import SimpleTestCase
from django.urls import reverse

class HomepageTests(SimpleTestCase):

    def test_url_exists_at_correct_location(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_homepage_url_name(self):
        response = self.client.get(reverse("home"))
        self.assertEqual(response.status_code, 200)

    def test_homepage_template(self): # new
        response = self.client.get("/")
        self.assertTemplateUsed(response, "home.html")
```

We’ve created a `response` variable again and then checked that the template `home.html` is used. Let’s run the tests again.

### 🛠 Running Template Tests

```bash
docker-compose exec web python manage.py test pages
```

You should see output like this:

```bash
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
...
----------------------------------------------------------------------
Ran 3 tests in 0.009s
OK
Destroying test database for alias 'default'...
```

Notice that we added the name of our app `pages` so that only the tests within that app were run. At this early stage, it’s fine to run all the tests, but in larger projects, if you know that you’ve only added tests within a specific app, it can save time to just run the updated/new tests and not the entire suite.

### 🧪 Testing HTML

Let’s now confirm that our homepage has the correct HTML code and also does not have incorrect text. It’s always good to test both that tests pass and that tests we expect to fail do actually fail!

```python
# pages/tests.py

from django.test import SimpleTestCase
from django.urls import reverse

class HomepageTests(SimpleTestCase):

    def test_url_exists_at_correct_location(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_homepage_url_name(self):
        response = self.client.get(reverse("home"))
        self.assertEqual(response.status_code, 200)

    def test_homepage_template(self):
        response = self.client.get("/")
        self.assertTemplateUsed(response, "home.html")

    def test_homepage_contains_correct_html(self): # new
        response = self.client.get("/")
        self.assertContains(response, "home page")

    def test_homepage_does_not_contain_incorrect_html(self): # new
        response = self.client.get("/")
        self.assertNotContains(response, "Hi there! I should not be on the page.")
```

### 🛠 Running HTML Tests

Run the tests again:

```bash
docker-compose exec web python manage.py test
```

You should see output like this:

```bash
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.....
----------------------------------------------------------------------
Ran 7 tests in 0.279s
OK
Destroying test database for alias 'default'...
```

### 🧰 Improving Test Structure with `setUp()`

Have you noticed that we seem to be repeating ourselves with these unit tests? For each one, we are loading a `response` variable, which seems wasteful and prone to errors. It’d be better to stick to something more DRY (Don’t Repeat Yourself) such as doing this once at the top of the tests with a function called `setUp` that loads the response into a `response` variable.

Our current `test_homepage_url_name` test is now redundant since `setUp` first runs `reverse` on our named template `"home"`, so we can remove that test.

### 🔧 Refactored Code with `setUp()`

```python
# pages/tests.py

from django.test import SimpleTestCase
from django.urls import reverse

class HomepageTests(SimpleTestCase):

    def setUp(self): # new
        url = reverse("home")
        self.response = self.client.get(url)

    def test_url_exists_at_correct_location(self):
        self.assertEqual(self.response.status_code, 200)

    def test_homepage_template(self):
        self.assertTemplateUsed(self.response, "home.html")

    def test_homepage_contains_correct_html(self):
        self.assertContains(self.response, "home page")

    def test_homepage_does_not_contain_incorrect_html(self):
        self.assertNotContains(self.response, "Hi there! I should not be on the page.")
```

### 🛠 Running the Final Tests

Now run the tests again. Because `setUp` is a helper method and does not start with `test`, it will not be considered a unit test in the final tally. So only six total tests will run.

```bash
docker-compose exec web python manage.py test
```

You should see:

```bash
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
....
----------------------------------------------------------------------
Ran 6 tests in 0.126s
OK
Destroying test database for alias 'default'...
```

### 🔍 Resolving Views

A final views check we can do is that our `HomePageView` “resolves” a given URL path. Django contains the utility function `resolve` for just this purpose. We will need to import both `resolve` as well as the `HomePageView` at the top of the file.

Our actual test, `test_homepage_url_resolves_homepageview`, checks that the name of the view used to resolve `/` matches `HomePageView`.

### 🔧 Resolve Test Code

```python
# pages/tests.py

from django.test import SimpleTestCase
from django.urls import reverse, resolve # new
from .views import HomePageView # new

class HomepageTests(SimpleTestCase):

    def setUp(self):
        url = reverse("home")
        self.response = self.client.get(url)

    def test_url_exists_at_correct_location(self):
        self.assertEqual(self.response.status_code, 200)

    def test_homepage_template(self):
        self.assertTemplateUsed(self.response, "home.html")

    def test_homepage_contains_correct_html(self):
        self.assertContains(self.response, "home page")

    def test_homepage_does_not_contain_incorrect_html(self):
        self.assertNotContains(self.response, "Hi there! I should not be on the page.")

    def test_homepage_url_resolves_homepageview(self): # new
        view = resolve("/")
        self.assertEqual(view.func.__name__, HomePageView.as_view().__name__)
```

Phew. That’s our last test. Let’s confirm that everything passes. 🎉

### 🛠 Final Test Command

```bash
docker-compose exec web python manage.py test
```

You should see:

```bash
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.....
----------------------------------------------------------------------
Ran 7 tests in 0.126s
OK
Destroying test database for alias 'default'...
```

## 🌳 Source Control with Git

Time to add our new changes to source control with Git. 🎯

### 🛠 Git Commands

```bash
git status
git add .
git commit -m 'Bookstore Pages App'
```

You can compare with the official source code on GitHub for this section.

## 🎉 Conclusion

We have configured our templates and added the first page to our project: a static homepage. We also added tests, which should always be included with new code changes. Some developers prefer a method called Test-Driven Development where they write the tests first and then the code. Personally, I prefer to write the tests immediately after, which is what we’ll do here.

Both approaches work; the key thing is to be rigorous with your testing. Django projects quickly grow in size, where it’s impossible to remember all the working pieces in your head. And if you are working on a team, it is a nightmare to work on an untested codebase. Who knows what will break? 😱

In the next section, we’ll add user registration to our project: log in, log out, and sign up. Stay tuned! 🚀
😊