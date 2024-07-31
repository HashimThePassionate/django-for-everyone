# Blog Application User Accounts

One major area still needs to be added to our Blog application: user accounts. We have an author field but no way, currently, for a user to sign up, log in, log out, and so on. Implementing user authentication from scratch is famously hard and not advised! It is one area where you really don’t want to make a mistake because of all the resulting security implications. Fortunately, Django has a powerful, battle-tested, built-in [User Authentication System](https://docs.djangoproject.com/en/5.0/topics/auth/) that we can use and customize as needed.

Whenever you create a new project, by default, Django installs the auth app, which provides us with a User object containing:
- username
- password
- email
- first_name
- last_name

We will use this User object to implement login, logout, and signup in our blog application.

## Log In

Django provides us with a default view for a login page via [`LoginView`](https://docs.djangoproject.com/en/5.0/topics/auth/default/#django.contrib.auth.views.LoginView). All we need to add is a URL pattern for the auth system, a login template, and a minor update to our `django_project/settings.py` file.

First, update the `django_project/urls.py` file. We’ll place our login and logout pages at the `accounts/` URL: a one-line addition to the next-to-last line.

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("accounts/", include("django.contrib.auth.urls")), # new
    path("", include("blog.urls")),
]
```

As the  [`LoginView`](https://docs.djangoproject.com/en/5.0/topics/auth/default/#django.contrib.auth.views.LoginView) documentation notes, by default, Django will look within a templates directory called `registration` for a file called `login.html` for a login form. So we need to create a new directory within templates called `registration` and the requisite file within it. From the command line, type `Control+c` to quit our local server. Then, create the new directory.

```sh
(pipenv) $ mkdir templates/registration
```

Then, with your text editor, create a new template file, `templates/registration/login.html`, filled with the following code:

```html
<!-- templates/registration/login.html -->
{% extends "base.html" %}
{% block content %}
    <h2>Log In</h2>
    <form method="post">{% csrf_token %}
        {{ form }}
        <button type="submit">Log In</button>
    </form>
{% endblock content %}
```

We’re using HTML `<form></form>` tags and specifying the POST method since we’re sending data to the server (we’d use GET if we were requesting data, such as in a search engine form). We add `{% csrf_token %}` for security concerns to prevent a CSRF Attack and then include a “submit” button.

The final step is to specify where to redirect the user upon successful login. We can set this with the `LOGIN_REDIRECT_URL` setting. At the bottom of the `django_project/settings.py` file, add the following:

```python
# django_project/settings.py
LOGIN_REDIRECT_URL = "home" # new
```

Now the user will be redirected to the “home” template, which is our homepage. And we’re actually done at this point! If you now start up the Django server again with `python manage.py runserver` and navigate to our login page at `http://127.0.0.1:8000/accounts/login/`, you’ll see the following:

Upon entering the login info for our superuser account, we are redirected to the homepage. Notice that we didn’t add any view logic or create a database model because the Django auth system automatically provided both for us. Thanks, Django!

Let’s update our `base.html` template so we display a message to users regardless of whether they are logged in. We can use the `is_authenticated` attribute for this. For now, place this code in a prominent position. Later on, we can style it more appropriately. Update the `base.html` file with new code starting beneath the closing `</header>` tag.

```html
<!-- templates/base.html -->
...
<body>
    <div>
        <header>
            <div class="nav-left">
                <h1><a href="{% url 'home' %}">Django blog</a></h1>
            </div>
            <div class="nav-right">
                <a href="{% url 'post_new' %}">+ New Blog Post</a>
            </div>
        </header>
        <!-- start new HTML... -->
        {% if user.is_authenticated %}
            <p>Hi {{ user.username }}!</p>
        {% else %}
            <p>You are not logged in.</p>
            <a href="{% url 'login' %}">Log In</a>
        {% endif %}
        <!-- end new HTML... -->
        {% block content %}
        {% endblock content %}
    </div>
</body>
</html>
```

If the user is logged in, we say hello to them by name; if not, we provide a link to our newly created login page.

### Log Out Link

One of the major changes to Django 5.0, as noted in the release notes, is the removal support for logging out via GET requests. Previously, you could add a logout link such as `<a href=” {% url 'logout' %}”>Log Out</a>` to a template file. But now a POST request via a form is required.

Add a logout button to the `home.html` file under the “Hi {{ user.username }}¡ section.

```html
<!-- templates/base.html-->
...
{% if user.is_authenticated %}
    <p>Hi {{ user.username }}!</p>
    <form action="{% url 'logout' %}" method="post">
        {% csrf_token %}
        <button type="submit">Log Out</button>
    </form>
{% else %}
...
```

The Django auth app provides us with the necessary view, so all we need to do is specify where to redirect a user when logging out. Update `django_project/settings.py` to provide a redirect link called `LOGOUT_REDIRECT_URL`. We can add it right next to our login redirect, so the bottom of the file should look as follows:

```python
# django_project/settings.py
LOGIN_REDIRECT_URL = "home"
LOGOUT_REDIRECT_URL = "home" # new
```

If you refresh the homepage, you’ll see it now has a “log out” button for logged-in users.

And clicking it takes you back to the homepage with a login link. Try logging in and out several times with your user account.

## Sign Up

Django does not provide a built-in view, URL, or template for signup. A common approach is to create a dedicated app, called `accounts` here, but also sometimes `users` in other projects, for this. That way, if we need to make further customizations to the user authentication process in the future, it is only contained in one place.

On the command line, stop the local server with `Control+c` and create a dedicated new app, `accounts`.

```sh
(pipenv) $ python manage.py startapp accounts
```

Then, add the new app to the `INSTALLED_APPS` setting in our `django_project/settings.py` file so it is registered with Django.

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "blog",
    "accounts", # new
]
```

Next, add a new URL path in `django_project/urls.py` pointing to this new app directly below where we include the built-in auth app.

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("accounts/", include("django.contrib.auth.urls")),
    path("accounts/", include("accounts.urls")), # new
    path("", include("blog.urls")),
]
```

The order of our URLs matters here because Django reads this file from top to bottom. Therefore when we request the `/accounts/signup` URL, Django will first look in auth, not find it, and then proceed to the accounts app.

In your text editor, create a file called `accounts/urls.py` and add the following code:

```python
# accounts/urls.py
from django.urls import path
from .views import SignUpView

urlpatterns = [
    path("signup/", SignUpView.as_view(), name="signup"),
]
```

We’re using a not-yet-created view called `SignUpView`, which we already know is class-based since it is capitalized and has the `as_view()` suffix. Its path is just `signup/`, so the complete URL path will be `accounts/signup/`.

For the view, Django has a built-in form class, `UserCreationForm`, that comes with three fields: `username`, `password1`, and `password2`. We can use it with `CreateView` to create our signup page. Replace the default `accounts/views.py` code with the following:

```python
# accounts/views.py
from django.contrib.auth.forms import UserCreationForm
from django.urls import reverse_lazy
from django.views.generic import CreateView

class SignUpView(CreateView):
    form_class = UserCreationForm
    success_url = reverse_lazy("login")
    template_name = "registration/signup.html"
```

We’re subclassing the generic class-based view `CreateView` in our `SignUpView` class and specifying `UserCreationForm`, the not-yet-created template `registration/signup.html

`. We also use `reverse_lazy` to redirect the user to the login page upon successful registration.

Why use `reverse_lazy` here instead of `reverse`? The URLs are not loaded when the file is imported for generic class-based views, so we have to use the lazy form of `reverse` to load them later when they’re available.

Create the file `templates/registration/signup.html` in your text editor and populate it with the code below.

```html
<!-- templates/registration/signup.html -->
{% extends "base.html" %}
{% block content %}
    <h2>Sign Up</h2>
    <form method="post">{% csrf_token %}
        {{ form.as_p }}
        <button type="submit">Sign Up</button>
    </form>
{% endblock content %}
```

This format is very similar to what we’ve done before. We extend our base template at the top, place our logic between `<form></form>` tags with the added `as_p` to render it with paragraph tags, use the `csrf_token` for security, and include a submit button.

We’re done! To test it out, start the local server with the `python manage.py runserver` command and navigate to `http://127.0.0.1:8000/accounts/signup/`.

Notice the large amount of extra text that Django includes by default. We can customize this using something like the [built-in messages framework](https://docs.djangoproject.com/en/5.0/ref/contrib/messages/), but for now, try out the form.

I created a new user called “hashim” and was redirected to the login page upon submission. After logging in successfully with my new username and password, I was redirected to the homepage with our personalized “Hi username” greeting.

Our ultimate flow is, therefore: Signup -> Login -> Homepage. And, of course, we can tweak this however we want. The `SignUpView` redirects to login because we set `success_url = reverse_lazy('login')`. The Login page redirects to the homepage because in our `django_project/settings.py` file, we set `LOGIN_REDIRECT_URL = 'home'`.

It may initially be overwhelming to keep track of all the various parts of a Django project, but that’s normal. With time, they’ll start to make more sense.

### Sign Up Link

One last improvement we can make is to add a signup link to the logged-out homepage. We can’t expect our users to know the correct URL after all! How do we do this? Well, we need to figure out the URL name, and then we can pop it into our template. In `accounts/urls.py`, we provided it the name of `signup`, so that’s all we need to add to our `base.html` template with the `url` template tag just as we’ve done for our other links.

Add the link for “Sign Up” just below the existing link for “Log In” as follows:

```html
<!-- templates/base.html-->
...
<p>You are not logged in.</p>
<a href="{% url 'login' %}">Log In</a> |
<a href="{% url 'signup' %}">Sign Up</a>
...
```

The signup link will be visible if you navigate to the logged-out homepage. Much better!

### GitHub

It’s been a while since we made a git commit. Let’s do that and then push a copy of our code onto GitHub. First, check all the new work we’ve done with `git status`.

```sh
$ git status
```

Then add the new content and enter a commit message.

```sh
$ git add .
$ git commit -m "forms, user accounts, and static files"
```

Create a new repo on GitHub and follow the recommended steps. I’ve chosen the name `blog` here; my username is `hashimthepassionate`. Make sure to use your own GitHub username and repo name for the command setting up a remote origin.

```sh
$ git remote add origin https://github.com/hashimthepassionate/blog.git
$ git branch -M main
$ git push -u origin main
```
## .gitignore

```text
Pipfile
Pipfile.lock
db.sqlite3
__pycache__
```

All set!

## Conclusion

With a small amount of code, we have added a robust user authentication flow to our website: login, logout, and signup. Under the hood, Django has taken care of the many security gotchas that can crop up if you create a user authentication flow from scratch. The Blog website is now complete. It is intentionally minimalist in design, but the combination of user authentication and full CRUD functionality is present in most websites.

In the next section, we will start the final project in the section: a Newspaper website that incorporates even more features.

