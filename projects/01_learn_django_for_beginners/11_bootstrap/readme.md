# Bootstrap

Web development requires many skills. Not only do you have to program the website correctly, but users also expect it to look good. Adding all the necessary HTML/CSS for a beautiful site can be overwhelming when creating everything from scratch.

While it’s possible to hand-code all the required CSS and JavaScript for a modern-looking website, in practice, most developers use a framework like [Bootstrap](https://getbootstrap.com/). We’ll use Bootstrap for our project, which can be extended and customized as needed.

## Pages App

In the previous section, we displayed our homepage by including view logic in our `urls.py` file. While this approach works, it feels hackish and certainly doesn’t scale as a website grows over time. It is also confusing to Django newcomers. Instead, we can and should create a dedicated `pages` app for all of our static pages, such as the homepage, a future about page, etc. This will keep our code organized.

### Creating the Pages App

On the command line, use the `startapp` command to create our new `pages` app. If the server is still running, you must type `Control+c` first to quit.

#### Shell Command

```sh
$ python manage.py startapp pages
```

Then, immediately update our `django_project/settings.py` file. I often forget to do this, so it is a good practice to think of creating a new app as a two-step process: run the `startapp` command, then update `INSTALLED_APPS`.

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
    "accounts",
    "pages", # new
]
```

Now, we can update our `urls.py` file inside the `django_project` directory by adding the `pages` app and removing the import of `TemplateView` and the previous URL path for the older homepage.

### Code

```python
# django_project/urls.py

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("accounts/", include("accounts.urls")),
    path("accounts/", include("django.contrib.auth.urls")),
    path("", include("pages.urls")), # new
]
```

It’s time to add our homepage, which means Django’s standard URLs/views/templates structure. We’ll start with the `pages/urls.py` file. First, create it with your text editor. Then, import our not-yet-created views, set the route paths, and name each URL.

### Code

```python
# pages/urls.py

from django.urls import path
from .views import HomePageView

urlpatterns = [
    path("", HomePageView.as_view(), name="home"),
]
```

The `views.py` code should look familiar at this point. We’re using Django’s `TemplateView` generic class-based view, meaning we only need to specify our `template_name` to use it.

### Code

```python
# pages/views.py

from django.views.generic import TemplateView

class HomePageView(TemplateView):
    template_name = "home.html"
```

We already have an existing `home.html` template. Let’s confirm it still works as expected with our new URL and view. Start the local server with `python manage.py runserver` and navigate to the homepage at `http://127.0.0.1:8000/` to confirm it remains unchanged. It should show the name and age of your logged-in superuser account, which we used at the end of the last section.

## Tests

We’ve added new code and functionality, so it is time for tests. You can never have enough tests in your projects. Even though they take some upfront time to write, they always save you time down the road and provide you with confidence as a project grows in complexity.

Let’s add tests to ensure our new homepage works properly. The code should look like this in your `pages/tests.py` file.

### Code

```python
# pages/tests.py

from django.test import SimpleTestCase
from django.urls import reverse

class HomePageTests(SimpleTestCase):
    def test_url_exists_at_correct_location_homepageview(self):
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_homepage_view(self):
        response = self.client.get(reverse("home"))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, "home.html")
        self.assertContains(response, "Home")
```

On the top line, we import `SimpleTestCase` since our homepage does not rely on the database. If it did, we’d have to use `TestCase` instead. Then, we import `reverse` to test our URL and view. Our test class, `HomePageTests`, has two tests that check the homepage URL returns a `200` status code and that it uses our expected URL name, template, and contains “Home” in the response.

Quit the local server with `Control+c` and then run our tests to confirm everything passes.

### Shell Command

```sh
$ python manage.py test
Found 7 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.......
----------------------------------------------------------------------
Ran 7 tests in 0.185s
OK
Destroying test database for alias 'default'...
```

### Testing Philosophy

### Testing Philosophy Explained

When testing an application, there's practically no limit to what you can test. For instance, you could create tests that check if a user is logged in or logged out, or if a webpage template shows the right content. However, a common principle known as the 80/20 rule applies here: 80% of the consequences often come from 20% of the causes. This means that focusing on testing the most critical parts of your application is usually more effective than trying to test every single detail.

In a web application, it’s not always necessary to create an extensive number of unit tests for things that are unlikely to fail. For example, if you were working on something high-stakes like a nuclear reactor, you would definitely want to test every possible scenario. But for most websites, the risks are much lower, so it’s okay to have partial test coverage at the start.
The important thing is to add tests for new features as you develop them. Then, as you encounter errors or bugs in new parts of your project (like in new Git branches or features), you can add tests specifically for those issues. This way, you ensure that the same problem doesn’t happen again. This approach is called **regression testing**. It involves running tests each time there’s a new change to make sure the existing software continues to work as expected.
Django, a popular web framework, has a built-in testing suite that makes it easy to create unit tests and perform automatic regression tests. This helps developers ensure that their projects remain consistent and reliable as they evolve.

## Bootstrap

It’s now time to add some style to our application. If you’ve never used Bootstrap, you’re in for a real treat. Much like Django, it accomplishes so much in so little code.

There are two ways to add Bootstrap to a project: download and serve all the files locally or rely on a Content Delivery Network (CDN). The second approach is simpler to implement, provided you have a consistent internet connection, so we’ll use it here.

Our template will mimic the “Starter template” provided on the [Bootstrap introduction](https://getbootstrap.com/docs/5.3/getting-started/introduction/) page and involves adding the following:

- `meta name="viewport"` and content information at the top within `<head>`
- Bootstrap CSS link within `<head>`
- Bootstrap JavaScript bundle at the bottom of the `<body>` section

Typing out all code yourself is recommended, but adding the Bootstrap CDN is an exception since it is lengthy and easy to mistype. I recommend copying and pasting the Bootstrap CSS and JavaScript Bundle links from the Bootstrap website into the `base.html` file.

### Code

```html
<!-- templates/base.html -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{% block title %}Newspaper App{% endblock title %}</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384..." crossorigin="anonymous">
</head>
<body>
    <main>
        {% block content %}
        {% endblock content %}
    </main>
    <!-- Bootstrap JavaScript Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384..." crossorigin="anonymous"></script>
</body>
</html>
```

> **Note:** This code snippet does not include the full links for Bootstrap CSS and JavaScript; it is abbreviated. Copy and paste the full links for Bootstrap 5.3 from the [quick start docs](https://getbootstrap.com/docs/5.3/getting-started/introduction/#quick-start).

If you start the server again with `python manage.py runserver` and refresh the homepage at `http://127.0.0.1:8000/`, you’ll see that the font size and link colors have changed.

Let’s add a navigation bar at the top of the page containing our links for the homepage, login, logout, and signup pages. Notably, we can use the [if/else](https://docs.djangoproject.com/en/5.0/ref/templates/language/#tags) tags in the Django templating engine to add some basic logic. We want the “log in” and “sign up” buttons to appear for a logged-out user and the “log out” and “change password” buttons when a

 user is logged in.

Again, it’s okay to copy/paste here since this section focuses on learning Django, not HTML, CSS, and Bootstrap. If there are any formatting issues, you can view the code  [GitHub repository](https://github.com/HashimThePassionate/) for reference.

### Code

```html
<!-- templates/base.html -->
...
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary">
    <div class="container-fluid">
        <a class="navbar-brand" href="{% url 'home' %}">Newspaper</a>
        <button class="navbar-toggler" type="button"
                data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false"
                aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">Home</a>
                </li>
                {% if user.is_authenticated %}
                <li><a href="#" class="nav-link px-2 link-dark">+ New</a></li>
            </ul>
            <div class="mr-auto">
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            {{ user.username }}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="{% url 'password_change' %}">
                                Change password</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li>
                                <form method="post" action="{% url 'logout' %}"
                                      style="display:inline;">
                                    {% csrf_token %}
                                    <button type="submit" class="btn btn-link nav-link"
                                            style="display:inline; cursor:pointer;">Logout</button>
                                </form>
                            </li>
                        </ul>
                    </li>
                {% else %}
                </ul>
            </div>
            <div class="mr-auto">
                <form class="form d-flex">
                    <a href="{% url 'login' %}" class="btn btn-outline-secondary">Log in</a>
                    <a href="{% url 'signup' %}" class="btn btn-primary ms-2">Sign up</a>
                </form>
            </div>
            {% endif %}
        </div>
    </div>
</nav>
<main>
    <div class="container">
        {% block content %}
        {% endblock content %}
    </div>
</main>
...
```

If you refresh the homepage at `http://127.0.0.1:8000/`, our new navbar has magically appeared! Note that there are no actual links yet for new articles “+ New”; a placeholder is represented in the code by `href="#"`. We will add that later on. Also, note that our logged-in username is now in the upper right corner, along with a dropdown arrow. If you click on it, there are links for “Change password” and “Log Out.”

### Logged-In Homepage with Bootstrap Nav

![Homepage with Bootstrap Nav Logged In](https://via.placeholder.com/800x300?text=Homepage+with+Bootstrap+Nav+Logged+In)

If you click “Log Out” in the dropdown, the navbar changes to button links for either “Log In” or “Sign Up,” and the “+ New” link disappears. There is no sense in letting logged-out users create articles.

### Logged-Out Homepage with Bootstrap Nav

![Homepage with Bootstrap Nav Logged Out](https://via.placeholder.com/800x300?text=Homepage+with+Bootstrap+Nav+Logged+Out)

If you click on the “Log In” button in the top nav, you can also see that our login page at `http://127.0.0.1:8000/accounts/login` looks better.

### Bootstrap Login Page

![Bootstrap Login Page](https://via.placeholder.com/800x300?text=Bootstrap+Login+Page)

The only thing that looks off is our gray “Log In” button. We can use Bootstrap to add some nice styling, such as making it green and inviting. Change the “button” line in the `templates/registration/login.html` file.

### Code

```html
<!-- templates/registration/login.html -->
{% extends "base.html" %}
{% block title %}Log In{% endblock title %}
{% block content %}
<h2>Log In</h2>
<form method="post">{% csrf_token %}
    {{ form }}
    <!-- new code here -->
    <button class="btn btn-success ms-2" type="submit">Log In</button>
    <!-- end new code -->
</form>
{% endblock content %}
```

Now refresh the page to see our new button in action.

### Bootstrap Login with New Button

![Bootstrap Login with New Button](https://via.placeholder.com/800x300?text=Bootstrap+Login+with+New+Button)

## Signup Form

If you click on the link for “Sign Up,” you’ll see that the page has Bootstrap stylings and distracting helper text. For example, after “Username,” it says, “Required. 150 characters or fewer. Letters, digits, and @/./+/-/_ only.” So, where did that text come from? Whenever something feels like “magic” in Django, rest assured that it is decidedly not. If you did not write the code, it exists somewhere within Django.

The best method to figure out what’s happening under the hood in Django is to download the source code and take a look yourself. All the code development occurs on GitHub, and you can find the Django repo at [https://github.com/django/django/](https://github.com/django/django/). To copy it onto your local computer, open a new tab (Command + t) on your command line and navigate to the desired location. Let’s navigate there now since we’ve been using a code folder on the desktop.

### Shell Command

**Windows:**

```sh
$ cd onedrive\desktop\code
```

**macOS:**

```sh
$ cd ~/desktop/code
```

On the GitHub website, you’ll see a green “<> Code” button. Click it and select “GitHub CLI” to view the command line instructions to download the repo.

![GitHub Django Repo](https://via.placeholder.com/800x300?text=GitHub+Django+Repo)

On the command line, type `gh repo clone django/django` to copy the Django source code onto your computer in a new directory called `django`.

### Shell Command

```sh
$ gh repo clone django/django
```

Having the Django source code on your computer will require manual updates now and then to stay current. After all, Django undergoes regular updates to fix bugs, improve security, and add new features. Why not just use the built-in GitHub search? Searching on GitHub sometimes works, but lately, it has been inconsistent, something GitHub is well aware of and working to improve. Downloading the source code and searching yourself are valuable tools, so it is worth taking the time to learn how to do so, as we are here.

In your text editor, open the Django source code to perform searches. For example, press the keys `command + shift + f` in the VS Code text editor to do a “find” search in all files. Type in a search for “150 characters or fewer” and you’ll find the top link to the page for `django/contrib/auth/models.py`. The specific code is on line 350, and the text is part of the `auth` app, on the `username` field for `AbstractUser`.

> **Note:** We now have two command line tabs open: one for our project code and one for the Django source code. Make sure you understand which is which. In the future, we will do additional searches on the source code, but all code in this section requires switching back to the terminal tab with the project source code. Switch back as we are about to add more code to our project.

We have three options now:

- override the existing `help_text`
- hide the `help_text`
- restyle the `help_text`

We’ll choose the third option since it’s a good way to introduce the excellent 3rd party package [django-crispy-forms](https://github.com/django-crispy-forms/django-crispy-forms).

Working with forms is challenging, and `django-crispy-forms` makes writing DRY (Don’t Repeat Yourself) code easier. First, stop the local server with `Control+c`. Then use pip to install the package in our project. We’ll also install the [Bootstrap5 template pack](https://github.com/django-crispy-forms/crispy-bootstrap5).

### Shell Command

```sh
$ python -m pip install django-crispy-forms==2.2
$ python -m pip install crispy-bootstrap5==2024.2
```

Add the new apps to our `INSTALLED_APPS` list in the `django_project/settings.py` file. As the number of apps starts to grow, it can be helpful to distinguish between “3rd party” apps and “local” apps. Here’s what the code looks like now.

### Code

```python
# django_project/settings.py

INSTALLED_APPS

 = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # 3rd Party
    "crispy_forms", # new
    "crispy_bootstrap5", # new
    # Local
    "accounts",
    "pages",
]
```

And then, at the bottom of the `settings.py` file, add two new lines as well.

### Code

```python
# django_project/settings.py

CRISPY_ALLOWED_TEMPLATE_PACKS = "bootstrap5" # new
CRISPY_TEMPLATE_PACK = "bootstrap5" # new
```

Now in our `signup.html` template, we can quickly use crispy forms. First, we load `crispy_forms_tags` at the top and then swap out `{{ form }}` for `{{ form|crispy }}`. We’ll also update the “Sign Up” button to be green with the `btn-success` styling.

### Code

```html
<!-- templates/registration/signup.html -->
{% extends "base.html" %}
{% load crispy_forms_tags %}
{% block title %}Sign Up{% endblock title%}
{% block content %}
<h2>Sign Up</h2>
<form method="post">{% csrf_token %}
    {{ form|crispy }}
    <button class="btn btn-success" type="submit">Sign Up</button>
</form>
{% endblock content %}
```

We can see the new changes if you start the server again with `python manage.py runserver` and refresh the signup page.

### Crispy Signup Page

![Crispy Signup Page](https://via.placeholder.com/800x300?text=Crispy+Signup+Page)

We can also add crispy forms to our login page. The process is the same. Here is that updated code:

### Code

```html
<!-- templates/registration/login.html -->
{% extends "base.html" %}
{% load crispy_forms_tags %}
{% block title %}Log In{% endblock title %}
{% block content %}
<h2>Log In</h2>
<form method="post">{% csrf_token %}
    {{ form|crispy }}
    <button class="btn btn-success ms-2" type="submit">Log In</button>
</form>
{% endblock content %}
```

Refresh the login page, and the update will be visible.

### Crispy Login Page

![Crispy Login Page](https://via.placeholder.com/800x300?text=Crispy+Login+Page)

## Git and requirements.txt

We have now added several packages to our Django project, so it is a good time to create a `requirements.txt` file.

### Shell Command

```sh
$ pip freeze > requirements.txt
```

At the moment, this is how mine looks:

### Code

```plaintext
# requirements.txt
asgiref==3.8.1
black==24.4.2
click==8.1.7
crispy-bootstrap5==2024.2
Django==5.0.6
django-crispy-forms==2.2
mypy-extensions==1.0.0
packaging==24.1
pathspec==0.12.1
platformdirs==4.2.2
sqlparse==0.5.0
```

Then we can add a quick Git commit to save our work in this section and store it on GitHub.

### Shell Commands

```sh
$ git status
$ git add -A
$ git commit -m "add Bootstrap styling"
$ git push origin main
```

## Conclusion

Our Newspaper app looks good. To improve the look of our forms, we added Bootstrap and Django Crispy Forms to our website. The last step of our user authentication flow is configuring password change and reset. Again, Django has taken care of the heavy lifting, requiring a minimal amount of code on our part.