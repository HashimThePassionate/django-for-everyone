# User Registration 📚

User registration is a core feature in any dynamic website, and it will be in our Bookstore project too. In this section, we will implement log in, log out, and sign up functionality. The first two are relatively straightforward since Django provides us with the necessary views and URLs for them. However, sign up is more challenging since there is no built-in solution.

## Auth App 🔒

Let’s begin by implementing log in and log out using Django’s own `auth` app. Django provides us with the necessary views and URLs, meaning we only need to update a template for things to work. This saves us a lot of time as developers and ensures we don’t make mistakes, as the underlying code has already been tested and used by millions of developers.

### Django Magic ✨

However, this simplicity comes at the cost of feeling “magical” to Django newcomers. This section will dive deeper to understand the underlying source code, which can also be used to explore any other built-in Django functionality on your own.

The first thing we need to do is make sure the `auth` app is included in our `INSTALLED_APPS` setting. You might have added your own apps here previously, but have you ever taken a close look at the built-in apps Django adds automatically for us? Let's do that now!

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",  # Yoohoo!!!!
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # Local
    "accounts",
    "pages",
]
```

There are 6 apps already there that Django provides for us, which power the site. The first is `admin` and the second is `auth`. This confirms that the `auth` app is present in our Django project.

When we earlier ran the `migrate` command for the first time, all these apps were linked together in the initial database. We used the `AUTH_USER_MODEL` setting to tell Django to use our custom user model, not the default User model. This is why we had to wait until that configuration was complete before running `migrate` for the first time.

## Auth URLs and Views 🌐

To use Django’s built-in `auth` app, we must explicitly add it to our `config/urls.py` file. The easiest approach is to use `accounts/` as the prefix since that is commonly used in the Django community.

Here's how to add it:

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    # Django admin
    path("admin/", admin.site.urls),
    # User management
    path("accounts/", include("django.contrib.auth.urls")),  # new
    # Local apps
    path("", include("pages.urls")),
]
```

### What's Included in the Auth App? 🛠️

The `auth` app includes a lot of associated URLs:

```text
accounts/login/ [name="login"]
accounts/logout/ [name="logout"]
accounts/password_change/ [name="password_change"]
accounts/password_change/done/ [name="password_change_done"]
accounts/password_reset/ [name="password_reset"]
accounts/password_reset/done/ [name="password_reset_done"]
accounts/reset/<uidb64>/<token>/ [name="password_reset_confirm"]
accounts/reset/done/ [name="password_reset_complete"]
```

You can find more information in the official [auth docs](https://docs.djangoproject.com/en/5.1/topics/auth/default/#module-django.contrib.auth.views) or by looking directly at the Django [source code on GitHub](https://github.com/django/django/tree/b9cf764be62e77b4777b3a75ec256f6209a57671/django/contrib/auth).

## Updating the Homepage 🏠

Next, let's update our existing homepage to notify us if a user is logged in or not. Here’s the updated `home.html` template:

```html
<!-- templates/home.html -->
{% extends "_base.html" %}

{% block title %}Home{% endblock title %}

{% block content %}
<h1>This is our home page.</h1>
{% if user.is_authenticated %}
<p>Hi {{ user.email }}!</p>
{% else %}
<p>You are not logged in</p>
<a href="{% url 'login' %}">Log In</a>
{% endif %}
{% endblock content %}
```

If the user is logged in (authenticated), we display a greeting that says “Hi” and includes their email address. If not, we show a message prompting them to log in.

### How Does Django Handle This? 🤔

The answer lies in Django's template context, which loads data from the corresponding `views.py` file. You can access `user` within template tags to check if a user is logged in using the `is_authenticated` attribute.

## Log In and Redirects 🔄

When clicking on the “Log In” link, Django might throw a `TemplateDoesNotExist` error, expecting a login template at `registration/login.html`. You can create this file and add the following code:

```html
<!-- templates/registration/login.html -->
{% extends "_base.html" %}

{% block title %}Log In{% endblock title %}

{% block content %}
<h2>Log In</h2>
<form method="post">
    {% csrf_token %}
    {{ form.as_p }}
    <button type="submit">Log In</button>
</form>
{% endblock content %}
```

Don’t forget to add CSRF protection to the form! This ensures that a malicious website cannot attack the site and user.

### Handling Redirects after Login 🚪

Django redirects users to `/accounts/profile/` after login by default, which may result in a `Page not found (404)` error. To fix this, add the following line to the bottom of your `settings.py` file:

```python
# django_project/settings.py
LOGIN_REDIRECT_URL = "home"  # new
```

This will redirect the user to the homepage upon successful login.

## Log Out Functionality 🚪

To add a log out option to our homepage, update `home.html`:

```html
<!-- templates/home.html -->
{% extends "_base.html" %}

{% block title %}Home{% endblock title %}

{% block content %}
<h1>This is our home page.</h1>
{% if user.is_authenticated %}
<p>Hi {{ user.email }}!</p>
<p><a href="{% url 'logout' %}">Log Out</a></p>
{% else %}
<p>You are not logged in</p>
<a href="{% url 'login' %}">Log In</a>
{% endif %}
{% endblock content %}
```

To ensure that a logged out user is redirected to the homepage, add this line to `settings.py`:

```python
# django_project/settings.py
LOGOUT_REDIRECT_URL = "home"  # new
```

## Implementing Sign Up ✍️

Implementing a sign-up page for user registration involves several steps:

1. Create an app-level `accounts/urls.py` file.
2. Update the project-level `django_project/urls.py` to point to the `accounts` app.
3. Add a view called `SignupPageView`.
4. Create a `signup.html` template file.
5. Update `home.html` to display the sign-up page.

### Creating `accounts/urls.py` 📂

Create an `accounts/urls.py` file:

```python
# accounts/urls.py
from django.urls import path
from .views import SignupPageView

urlpatterns = [
    path("signup/", SignupPageView.as_view(), name="signup"),
]
```

### Updating `django_project/urls.py` 🌐

Next, update the `django_project/urls.py` file:

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    # Django admin
    path("admin/", admin.site.urls),
    # User management
    path("accounts/", include("django.contrib.auth.urls")),
    # Local apps
    path("accounts/", include("accounts.urls")),  # new
    path("", include("pages.urls")),
]
```

### Creating the `SignupPageView` 📄

Now, create the view `SignupPageView`:

```python
# accounts/views.py
from django.urls import reverse_lazy
from django.views import generic
from .forms import CustomUserCreationForm

class SignupPageView(generic.CreateView):
    form_class = CustomUserCreationForm
    success_url = reverse_lazy("login")
    template_name = "registration/signup.html"
```

### Creating `signup.html` 📝

Finally, create the `signup.html` file:

```html
<!-- templates/registration/signup.html -->
{% extends "_base.html" %}

{% block title %}Sign Up{% endblock title %}

{% block content %}
<h2>Sign Up</h2>
<form method="post">
    {% csrf_token %}
    {{ form.as_p }}
    <button type="submit">Sign Up</button>
</form>
{% endblock content %}
```

### Adding the Sign Up Link to `home.html` 🔗

Update `home.html` to include a sign-up link:

```html
<!-- templates/home.html -->
{% extends "_base.html" %}

{% block title %}Home{% endblock title %}

{% block content %}
<h1>This is our home page.</h1>
{% if user.is_authenticated %}
<p>Hi {{ user.email }}!</p>
<form action="{% url 'logout' %}" method="post">
        {% csrf_token %}
        <button type="submit">Log Out</button>
</form>
{% else %}
<p>You are not logged in</p>
<a href="{% url 'login' %}">Log In</a>
<a href="{% url 'signup' %}">Sign Up</a>
{% endif %}
{% endblock content %}
```

## Running Tests 🧪

Although we don't need to test log in and log out features (as these are built into Django), we do need to test our sign-up functionality.

Start by creating a `setUpTestClass` method that loads our page and populates the `test_signup_template` method with tests for status code, template used, and both included and excluded text:

```python
# accounts/tests.py
from django.contrib.auth import get_user_model
from django.test import TestCase
from django.urls import reverse

class CustomUserTests(TestCase): ...

class SignUpPageTests(TestCase):
    def setUp(self):
        url = reverse("signup")
        self.response = self.client.get(url)

    def test_signup_template(self):
        self.assertEqual(self.response.status_code, 200)
        self.assertTemplateUsed(self.response, "registration/signup.html")
        self.assertContains(self.response, "Sign Up")
        self.assertNotContains(self.response, "Hi there! I should not be on the page.")
```

Then, run our tests:

```bash
docker-compose exec web python manage.py test
```

### Testing `CustomUserCreationForm` and View Resolution 🔍

Next, test that our `CustomUserCreationForm` is being used and that the page resolves to `SignupPageView`:

```python
# accounts/tests.py
from django.contrib.auth import get_user_model
from django.test import TestCase
from django.urls import reverse, resolve  # new
from .forms import CustomUserCreationForm  # new
from .views import SignupPageView  # new

class SignUpPageTests(TestCase):  # new
    def setUp(self):
        url = reverse("signup")
        self.response = self.client.get(url)

    def test_signup_template(self):
        self.assertEqual(self.response.status_code, 200)
        self.assertTemplateUsed(self.response, "registration/signup.html")
        self.assertContains(self.response, "Sign Up")
        self.assertNotContains(
            self.response, "Hi there! I should not be on the page.")

    def test_signup_form(self):
        form = self.response.context.get("form")
        self.assertIsInstance(form, CustomUserCreationForm)
        self.assertContains(self.response, "csrfmiddlewaretoken")

    def test_signup_form(self):  # new
        form = self.response.context.get("form")
        self.assertIsInstance(form, CustomUserCreationForm)
        self.assertContains(self.response, "csrfmiddlewaretoken")

    def test_signup_view(self):  # new
        view = resolve("/accounts/signup/")
        self.assertEqual(view.func.__name__, SignupPageView.as_view().__name__)
```

## Test Cases Explanation

---

### 🧪 **SignUpPageTests Class**

This class `SignUpPageTests` is a set of automated tests for the Sign Up page of your Django app. It's like a checklist 📝 to make sure everything works correctly on this page.

---

### 🛠️ **setUp Method**

```python
def setUp(self):
    url = reverse("signup")
    self.response = self.client.get(url)
```

- **🛠️ Preparation (setUp)**: This method runs before each test. It fetches the URL for the Sign Up page (`/accounts/signup/`) using `reverse("signup")` and stores the response 📄 from the server in `self.response`.
- **🔄 Why?** This is done to make sure each test has fresh data from the page.

---

### 📝 **test_signup_template Method**

```python
def test_signup_template(self):
    self.assertEqual(self.response.status_code, 200)
    self.assertTemplateUsed(self.response, "registration/signup.html")
    self.assertContains(self.response, "Sign Up")
    self.assertNotContains(self.response, "Hi there! I should not be on the page.")
```

- **🔍 Template Check**: 
  - **✅ Status Code**: It checks if the page loaded successfully with a status code of `200` (which means "OK").
  - **🗂️ Template Used**: It ensures the correct template `registration/signup.html` is used to render the page.
  - **🔎 Content Check**: It looks for the text "Sign Up" on the page 📝.
  - **🚫 Not Found**: It makes sure an unwanted message ("Hi there! I should not be on the page.") isn't accidentally showing up.

---

### 📑 **test_signup_form Method** (First Instance)

```python
def test_signup_form(self):
    form = self.response.context.get("form")
    self.assertIsInstance(form, CustomUserCreationForm)
    self.assertContains(self.response, "csrfmiddlewaretoken")
```

- **📑 Form Presence**:
  - **🔍 Form Check**: It ensures the form used on the Sign Up page is an instance of `CustomUserCreationForm` (a custom form for creating users).
  - **🔒 CSRF Protection**: It checks if the page includes a `csrfmiddlewaretoken`, which protects against CSRF attacks (a type of security threat) 🛡️.

---

### 📑 **test_signup_form Method** (Second Instance - Duplicate)**

```python
def test_signup_form(self):
    form = self.response.context.get("form")
    self.assertIsInstance(form, CustomUserCreationForm)
    self.assertContains(self.response, "csrfmiddlewaretoken")
```

- **⚠️ Duplicate Alert**: This method is exactly the same as the previous one and might be an accidental duplication. You can remove it to avoid redundancy. 

---

### 🔍 **test_signup_view Method**

```python
def test_signup_view(self):
    view = resolve("/accounts/signup/")
    self.assertEqual(view.func.__name__, SignupPageView.as_view().__name__)
```

- **🔍 View Resolution**:
  - **🛤️ URL to View**: It checks that the URL `/accounts/signup/` is correctly mapped to the `SignupPageView` class-based view.
  - **✅ View Function**: It compares the name of the function associated with this view to ensure it's correctly linked.

---

Run the tests again:

```bash
docker-compose exec web python manage.py test
```

## Committing Your Work to Git 🗃️

Make sure to save your work by adding changes into Git:

```bash
git status
git add .
git commit -m 'User Registration'
```

The official source code is located on [GitHub](https://github.com/django/django) if you want to compare your code.

## Conclusion 🎉

Our Bookstore project is not the most beautiful site in the world, but it is very functional at this point. In the next section, we’ll configure our static assets and add Bootstrap for improved styling.
😊