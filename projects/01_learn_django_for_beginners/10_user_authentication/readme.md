# User Authentication

Now that we have a working custom user model, we can add the functionality every website needs: the ability for users to sign up, log in, and log out. Django provides everything we need for users to log in and out, but we must create our own form to allow new users to sign up. We’ll also build a basic homepage with links to all three features so users don’t have to type in the URLs by hand every time.

## Templates

By default, the Django template loader looks for templates in a nested structure within each app. For example, the structure `accounts/templates/accounts/home.html` would be needed for a `home.html` template within the `accounts` app. However, a single project-level templates directory approach is cleaner and scales better, so that’s what we’ll use.

### Shell Commands

Create a new project-level templates directory and a registration directory within where Django will look for templates related to logging in and signing up.

```sh
mkdir templates
mkdir templates/registration
```

We need to tell Django about this new directory by updating the configuration for "DIRS" in `django_project/settings.py`.

### Code

```python
# django_project/settings.py

TEMPLATES = [
    {
        ...
        "DIRS": [BASE_DIR / "templates"], # new
        ...
    }
]
```

If you think about what happens when you log in or out of a site, you are immediately redirected to a subsequent page. We need to tell Django where to send users in each case. The `LOGIN_REDIRECT_URL` and `LOGOUT_REDIRECT_URL` settings do that. We’ll configure both to redirect to our homepage with the named URL of 'home'. Remember that when we create our URL routes, we can add a name to each one. So when we make the homepage URL, we’ll call it 'home'.

Add these two lines at the bottom of the `django_project/settings.py` file.

### Code

```python
# django_project/settings.py

LOGIN_REDIRECT_URL = "home" # new
LOGOUT_REDIRECT_URL = "home" # new
```

Now we can create four new templates within our text editor:

- `templates/base.html`
- `templates/home.html`
- `templates/registration/login.html`
- `templates/registration/signup.html`

Here’s the HTML code for each file to use. The `base.html` will be inherited by every other template in our project. Using a block like `{% block content %}`, we can later override the content just in this place in other templates.

### Code

**`templates/base.html`:**

```html
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>{% block title %}Newspaper App{% endblock title %}</title>
</head>
<body>
    <main>
        {% block content %}
        {% endblock content %}
    </main>
</body>
</html>
```

**`templates/home.html`:**

```html
{% extends "base.html" %}
{% block title %}Home{% endblock title %}
{% block content %}
    {% if user.is_authenticated %}
        <p>Hi {{ user.username }}!</p>
        <form action="{% url 'logout' %}" method="post">
            {% csrf_token %}
            <button type="submit">Log Out</button>
        </form>
    {% else %}
        <p>You are not logged in</p>
        <a href="{% url 'login' %}">Log In</a> |
        <a href="{% url 'signup' %}">Sign Up</a>
    {% endif %}
{% endblock content %}
```

**`templates/registration/login.html`:**

```html
{% extends "base.html" %}
{% block title %}Log In{% endblock title %}
{% block content %}
    <h2>Log In</h2>
    <form method="post">{% csrf_token %}
        {{ form }}
        <button type="submit">Log In</button>
    </form>
{% endblock content %}
```

**`templates/registration/signup.html`:**

```html
{% extends "base.html" %}
{% block title %}Sign Up{% endblock title %}
{% block content %}
    <h2>Sign Up</h2>
    <form method="post">{% csrf_token %}
        {{ form.as_p }}
        <button type="submit">Sign Up</button>
    </form>
{% endblock content %}
```

Our templates are now all set. The related URLs and views are still to go.

## URLs

Let’s start with the URL routes. In our `django_project/urls.py` file, we want our `home.html` template to appear as the homepage, but we don’t want to build a dedicated pages app yet. We can use the shortcut of importing `TemplateView` and setting the `template_name` right in our URL pattern.

Next, we want to “include” the `accounts` app and the built-in `auth` app. The reason is that the built-in `auth` app already provides views and URLs for logging in and out. But to sign up, we must create our own view and URL. To ensure that our URL routes are consistent, we place them both at `accounts/` so the eventual URLs will be `/accounts/login`, `/accounts/logout`, and `/accounts/signup`.

### Code

```python
# django_project/urls.py

from django.contrib import admin
from django.urls import path, include # new
from django.views.generic.base import TemplateView # new

urlpatterns = [
    path("admin/", admin.site.urls),
    path("accounts/", include("accounts.urls")), # new
    path("accounts/", include("django.contrib.auth.urls")), # new
    path("", TemplateView.as_view(template_name="home.html"), name="home"), # new
]
```

Now create a file with your text editor called `accounts/urls.py` and update it with the following code:

### Code

```python
# accounts/urls.py

from django.urls import path
from .views import SignUpView

urlpatterns = [
    path("signup/", SignUpView.as_view(), name="signup"),
]
```

## Views

The last step is our `views.py` file containing the logic for our signup form. We’re using Django’s generic `CreateView` here and telling it to use our `CustomUserCreationForm`, to redirect to login once a user signs up successfully and that our template is named `signup.html`.

### Code

```python
# accounts/views.py

from django.urls import reverse_lazy
from django.views.generic import CreateView
from .forms import CustomUserCreationForm

class SignUpView(CreateView):
    form_class = CustomUserCreationForm
    success_url = reverse_lazy("login")
    template_name = "registration/signup.html"
```

## Testing the Setup

Let’s test things out. Start the server with `python manage.py runserver` and go to the homepage.

- If you are logged in, you should see a personalized greeting.
- Log out, and the homepage should show links to log in and sign up.
- Test the signup and login functionality to ensure everything works.

### Adding Age to the Homepage

Since we have the new age field, let’s add that to the `home.html` template. It is a field on the user model, so to display it, we only need to use `{{ user.age }}`.

### Code

```html
<!-- templates/home.html -->
{% extends "base.html" %}
{% block title %}Home{% endblock title %}
{% block content %}
    {% if user.is_authenticated %}
        <!-- new code here! -->
        Hi {{ user.username }}! You are {{ user.age }} years old.
        <!-- end of new code -->
        <form action="{% url 'logout' %}" method="post">
            {% csrf_token %}
            <button type="submit">Log Out</button>
        </form>
    {% else %}
        <p>You are not logged in</p>
        <a href="{% url 'login' %}">Log In</a> |
        <a href="{% url 'signup' %}">Sign Up</a>
    {% endif %}
{% endblock content %}
```

Save the file and refresh the homepage. Everything should work as expected.

## Admin Interface

Navigate to the admin at `http://127.0.0.1:8000/admin` in your web browser and log in to view the user accounts. 

- Only a superuser account has permission to log in to the admin. Make sure you're logged in with a superuser account.

Once logged in, you should see all user accounts listed.

### Adding Email to Signup Form

Our signup page has no email field because it was not included in `accounts/forms.py`. This is an important point: just because the user model has a field does not mean it will be included in our custom signup form unless explicitly added. Let’s do so now.

### Code

```python
# accounts/forms.py

from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from .models import CustomUser

class CustomUserCreationForm(UserCreationForm):
    class Meta:
        model = CustomUser
        fields = (
            "username",
            "email",
            "age",
        ) # new

class CustomUserChangeForm(UserChangeForm):
    class Meta:
        model = CustomUser
        fields = (
            "username",
            "email",
            "age",
        ) # new
```

Log out of your superuser account and try `http://127.0.0.1:8000/accounts/signup/` again. You should see the additional “Email address” field there. Sign up with a new user account to confirm it works.



## Tests

The new signup page has a view, URL, and template that all should be tested. Open up the `accounts/tests.py` file containing code from the last section for `UsersManagersTests`. Below it, add a new class called `SignupPageTests`.

### Code

```python
# accounts/tests.py

from django.contrib.auth import get_user_model
from django.test import TestCase
from django.urls import reverse # new

class UsersManagersTests(TestCase):
    ...

class SignupPageTests(TestCase): # new
    def test_url_exists_at_correct_location_signupview(self):
        response = self.client.get("/accounts/signup/")
        self.assertEqual(response.status_code, 200)

    def test_signup_view_name(self):
        response = self.client.get(reverse("signup"))
        self.assertEqual(response.status_code, 200)
        self.assertTemplateUsed(response, "registration/signup.html")

    def test_signup_form(self):
        response = self.client.post(
            reverse("signup"),
            {
                "username": "testuser",
                "email": "testuser@email.com",
                "password1": "testpass123",
                "password2": "testpass123",
            },
        )
        self.assertEqual(response.status_code, 302)
        self.assertEqual(get_user_model().objects.all().count(), 1)
        self.assertEqual(get_user_model().objects.all()[0].username, "testuser")
        self.assertEqual(
            get_user_model().objects.all()[0].email, "testuser@email.com"
        )
```

Run the tests with `python manage.py test` to check that everything passes as expected.

### Shell Command

```sh
python manage.py test
Found 5 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
...
----------------------------------------------------------------------
Ran 5 tests in 0.183s
OK
Destroying test database for alias 'default'...
```

## Git

Before moving on to the next section, let’s record our work with Git and store it on GitHub.

### Shell Commands

```sh
git status
git add .
git commit -m "user authentication"
git push origin main
```

## Conclusion

So far, our Newspaper app has a custom user model and working signup, login, and logout pages. But you may have noticed that our site could look better. In the next section, we’ll add CSS styling with Bootstrap and create a dedicated pages app.
