# 🌟 Advanced User Registration 🌟

In this section, we'll take the standard Django user registration process to the next level by customizing it and adding social authentication. Instead of the traditional username/email/password pattern, we will modernize the process to require only an email and password for sign-up and login. Additionally, we'll incorporate third-party social authentication options like Google, facebook (Facebook), and GitHub. We'll be using the popular third-party package `django-allauth` to simplify this process while ensuring security. 

> **Note:** Always proceed with caution when adding third-party packages to your project to ensure they are up-to-date and well-tested. Fortunately, `django-allauth` ticks all the right boxes! ✅

---

## 📦 Installing django-allauth

Start by installing `django-allauth` along with the latest versions of other necessary packages. Add the following to your `requirements.txt` file:

```txt
asgiref==3.8.1
crispy-bootstrap5==0.6
django-crispy-forms==1.14.0
Django==5.1
django-allauth==64.1.0
psycopg2-binary==2.9.9
sqlparse==0.5.1
tzdata==2024.1
```

After updating the `requirements.txt`, spin down the currently running Docker container, rebuild the Docker image, and start up a new container:

```bash
docker-compose down
docker-compose up -d --build
```

At this point, your website will function the same as before because we haven't yet told Django about `django-allauth`. Let's do that next!

---

## 🛠️ Updating `INSTALLED_APPS` and `AUTHENTICATION_BACKENDS`

To inform Django about the new `django-allauth` package, update the `INSTALLED_APPS` in your `django_project/settings.py` file:

```python
# django_project/settings.py
INSTALLED_APPS = [
    # Django apps
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.sites", # new
    "django.contrib.staticfiles",
    # Third-party apps
    "allauth",  
    "allauth.account",
    "allauth.socialaccount",  # new (for social authentication)
    "allauth.socialaccount.providers.github",
    # Local apps
    "accounts",
    "pages",
    # Other apps...
    "crispy_forms",  # 🆕 Add this line
    "crispy_bootstrap5",  # 🆕 Add this line if using Bootstrap 5
]

# django-allauth config
SITE_ID = 1  # new
AUTHENTICATION_BACKENDS = (
    "django.contrib.auth.backends.ModelBackend",
    "allauth.account.auth_backends.AuthenticationBackend",  # new
)

MIDDLEWARE = [
    ...
    'django.middleware.csrf.CsrfViewMiddleware', # new
    ...
]
```

This setup allows `django-allauth` to manage the authentication process using email, which is more common today than username-based logins.

---

## 📧 Configuring the Email Backend

By default, Django uses an SMTP server to send emails. Since we don’t have an SMTP server configured, we'll redirect emails to the command line console instead. Add the following configuration:

```python
# django_project/settings.py
EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend"  # new
```

This configuration will prevent errors during email sending attempts by `django-allauth`.

---

## 🔄 Logout Redirect Configuration

Django's default logout redirect can be overridden by `django-allauth`. To ensure future flexibility, explicitly set the logout redirect URL as follows:

```python
# django_project/settings.py
LOGIN_REDIRECT_URL = "home"
ACCOUNT_LOGOUT_REDIRECT = "home"  # new
```

This ensures that users are redirected to the homepage after logging out.

---

## 🗂️ Applying Migrations

Since we've made several changes to the `settings.py` file, let's run migrations to update the database:

```bash
docker-compose exec web python manage.py migrate
```

This command will apply necessary migrations for `account`, `accounts`, `admin`, `auth`, `contenttypes`, `sessions`, and `sites`.

---

## 🌐 Updating URLs

Replace Django's built-in auth URLs with `django-allauth`'s URLs in your `urls.py` file:

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    # Django admin
    path("admin/", admin.site.urls),
    # User management
    path("accounts/", include("allauth.urls")),  # new
    # Local apps
    path("", include("pages.urls")),
]
```

You can now delete the `accounts/urls.py` and `accounts/views.py` files, as they are no longer required.

---

## 🖼️ Template Adjustments

Move the `login.html` and `signup.html` templates to a new directory named `templates/account`:

```bash
mkdir templates/account
mv templates/registration/login.html templates/account/login.html
mv templates/registration/signup.html templates/account/signup.html
```

Then, delete the old `templates/registration` directory:

```bash
rm -r templates/registration
```

---

## 🛠️ Updating the Base Template

Update the URL links within `templates/_base.html` to use `django-allauth`’s URL names:

```html
<!-- templates/_base.html -->
<ul class="navbar-nav me-auto mb-2 mb-md-0">
    <li class="nav-item">
        <a class="nav-link" href="{% url 'about' %}">About</a>
    </li>
    {% if user.is_authenticated %}
    <li class="nav-item">
        <a class="nav-link" href="{% url 'account_logout' %}">Log Out</a>
    </li>
    {% else %}
    <li class="nav-item">
        <a class="nav-link" href="{% url 'account_login' %}">Log In</a>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="{% url 'account_signup' %}">Sign Up</a>
    </li>
    {% endif %}
</ul>
```

This change aligns the URLs with `django-allauth`’s routing.

---

## 🔑 Testing the New Login Flow

Refresh the homepage, log out if you’re already logged in, and click on the “Log In” link. The login page now includes a “Remember Me” option. To make sessions always remember the user, add this line to the `settings.py` file:

```python
# django_project/settings.py
ACCOUNT_SESSION_REMEMBER = True  # new
```

Refresh the page to see the changes.

```python
# django_project/settings.py
# Redirects directly to the provider’s authorization page
SOCIALACCOUNT_LOGIN_ON_GET = True
```
use this setting if you want to redirect github login page directly.
---

## 🚪 Customizing the Logout Page

We will now update the default Log Out template by creating a templates/account/logout.html
file to override it. Do so now in your text editor. As in our other templates it will extend
_base.html and include Bootstrap styling on the submitted button
```html
<!-- templates/account/logout.html -->
{% extends "_base.html" %}
{% load crispy_forms_tags %}
{% block title %}Log Out{% endblock %}
{% block content %}
<h1>Log Out</h1>
<p>Are you sure you want to log out?</p>
<form method="post" action="{% url 'account_logout' %}">
    {% csrf_token %}
    {{ form|crispy }}
    <button class="btn btn-danger" type="submit">Log Out</button>
</form>
{% endblock content %}
```

Refresh the page to view the updated logout template.

```bash
http://127.0.0.1:8000/accounts/login/
```
Then click on the “Log Out” link to complete the process.

## Sign Up
At the top of our website, in the nav bar, click on link for “Sign Up” which has Bootstrap and
django-crispy-forms styling.

An optional customization we can make via django-allauth is to only ask for a password once.
Since we’ll configure password change and reset options later, there’s less of a risk that a user
who types in the password incorrectly will be locked out of their account.

Refresh the page and the form will update itself to remove the additional password line

Now create a new user to confirm everything works. We can call the user testuser1, use
testuser1@email.com as email, and testpass123 as the password. Upon submit it will redirect
you to the homepage.
Remember how we configured email to output to the console? django-allauth automatically
sends an email upon registration which we can view by typing docker-compose logs.


## 📋 Simplifying Sign-Up Process

To simplify the sign-up process by asking for a password only once, add this configuration:

```python
# django_project/settings.py
ACCOUNT_SIGNUP_PASSWORD_ENTER_TWICE = False  # new
```

Create a new user to confirm that everything works correctly.

---

## 📧 Email Confirmation

Since email output is configured to the console, check the logs using:

```bash
docker-compose logs
```

You'll see the email content in the logs, confirming that `django-allauth` is sending registration confirmation emails.

---

## 🎛️ Admin Interface Enhancements

Log in to the Django admin interface to see the changes brought by `django-allauth`. You’ll notice new sections like Accounts and Sites. To make login email-only, update the following configurations:

```python
# django_project/settings.py
ACCOUNT_USERNAME_REQUIRED = False  # new
ACCOUNT_AUTHENTICATION_METHOD = "email"  # new
ACCOUNT_EMAIL_REQUIRED = True  # new
ACCOUNT_UNIQUE_EMAIL = True  # new
```

Test the changes by signing up with a new user.

---

## 🧪 Testing the Changes

Update the tests to align with the new configurations:

```python
# accounts/tests.py
from django.contrib.auth import get_user_model
from django.test import TestCase
from django.urls import reverse, resolve

class SignupPageTests(TestCase):  # new
    username = "newuser"
    email = "newuser@email.com"

    ...
    def test_signup_form(self):
        new_user = get_user_model().objects.create_user(self.username, self.email)
        self.assertEqual(get_user_model().objects.all().count(), 1)
        self.assertEqual(get_user_model().objects.all()[0].username, self.username)
        self.assertEqual(get_user_model().objects.all()[0].email, self.email)
```

Run the tests:

```bash
docker-compose exec web python manage.py test
```

Ensure all tests pass.

---

## 🌐 Social Authentication

To add social authentication, follow detailed tutorials online, such as integrating with GitHub, Google, and facebook. Here’s a basic outline:

1. **Install and Configure Providers**: Add the provider packages to your `requirements.txt` and configure them in your `settings.py`:

```python
# django_project/settings.py
INSTALLED_APPS += [
    ...
    "allauth.socialaccount",
    "allauth.socialaccount.providers.github",
    ...
]

# Add your provider-specific settings, such as client IDs and secrets.
SOCIALACCOUNT_PROVIDERS = {
    'github': {
        'APP': {
            'client_id': '<your-client-id>',
            'secret': '<your-client-secret>',
            'key': ''
        }
    },
}
```

<!--  -->
Sure, here's the enhanced and beautiful version with emojis:

---

## 🌟Social github Authentication in Django with `django-allauth`

### 1. **Register OAuth Applications** 🛠️

To enable social authentication, you need to register your application with each provider (GitHub, Google, Meta) to get the **Client ID** and **Client Secret**. After registration, store these credentials in an environment file (`.env`).

#### **GitHub** 🌐

1. Go to [GitHub Developer Settings](https://github.com/settings/developers).
2. Create a new OAuth app and set the following:
   - **Homepage URL**: `http://127.0.0.1:8000`
   - **Authorization Callback URL**: `http://127.0.0.1:8000/accounts/github/login/callback/`
3. Save the **Client ID** and **Client Secret**.

### 2. **Store Client IDs and Secrets in `.env` File** 📄

In your Django project directory, create a `.env` file and add the following:

```env
GITHUB_CLIENT_ID=your_github_client_id
GITHUB_SECRET=your_github_client_secret
```

### 3. **Install Dependencies** 📦

Make sure `django-allauth` and `python-decouple` (for reading environment variables) are installed. You can add them to your `requirements.txt` or install them directly:

```plaintext
asgiref==3.8.1
crispy-bootstrap5==0.6
django-crispy-forms==1.14.0
Django==5.1
django-allauth==64.1.0
psycopg2-binary==2.9.9
sqlparse==0.5.1
tzdata==2024.1
requests==2.31.0
python-decouple==3.8
requests==2.31.0
python-decouple==3.8
PyJWT==2.7.0  # Updated package
```

### 4. **Rebuild Your Docker Environment** 🐳

Run the following commands to rebuild your Docker containers:

```bash
docker-compose down -v
docker-compose up -d --build
```

### 5. **Configure Django Settings** 🔧

Modify your `settings.py` to read the **Client IDs** and **Client Secrets** from the environment file.

#### Update `django_project/settings.py`:

1. **Import `config` from `decouple`** to read environment variables.

2. **Add `allauth` apps and set up the `SOCIALACCOUNT_PROVIDERS`** using environment variables.

```python
from decouple import config  # Import decouple

# Add 'allauth' apps to INSTALLED_APPS
INSTALLED_APPS = [
    ...
    'django.contrib.sites',
    'allauth',
    'allauth.account',
    'allauth.socialaccount',
    'allauth.socialaccount.providers.github',
    # Other apps...
]

# Social Authentication Providers
SOCIALACCOUNT_PROVIDERS = {
    'github': {
        'APP': {
            'client_id': config('GITHUB_CLIENT_ID'),
            'secret': config('GITHUB_SECRET'),
            'key': ''
        }
    },
}
```

### 6. **Update Templates** 🌐

Modify the login template to include social login buttons. Create a file `templates/account/login.html` if it doesn’t exist.

```html
<!-- templates/account/login.html -->
{% extends "_base.html" %}
{% load crispy_forms_tags %}
{% load socialaccount %} <!-- Load socialaccount template tags -->
{% load static %} <!-- Load static tag for static files -->
{% block title %}Log In{% endblock %}
{% block content %}
<h2>Log In</h2>
<form method="post">
    {% csrf_token %}
    {{ form|crispy }}
    <button class="btn btn-success" type="submit">Log In</button>
</form>

<div class="social-login">
    <h3>Or log in with:</h3>
    <a href="{% provider_login_url 'github' %}" class="btn btn-github">
        <img src="{% static 'github-logo.png' %}" alt="GitHub Logo" class="github-logo">
        Login with GitHub
    </a>
</div>
{% endblock content %}

```
### BASE CSS file:
```css
.btn-github {
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: #24292e;
    color: white;
    padding: 10px 20px;
    border-radius: 5px;
    text-decoration: none;
    font-weight: bold;
    transition: background-color 0.3s ease;
}

.btn-github:hover {
    background-color: #444d56;
}

.github-logo {
    width: 20px;
    height: 20px;
    margin-right: 10px;
}
```
### 8. **Test Social Authentication** 🧪

1. **Run the Django development server**:

   ```bash
   python manage.py runserver
   ```

2. **Access the login page** at `http://127.0.0.1:8000/accounts/login/` and try logging in with GitHub.

> ## For Google Console (OAuth Onsent Screen)
## **Use a Fake Domain for Development:**
   - **Edit the Hosts File**: You can trick your local machine into thinking a non-existent domain points to your localhost by editing your system's hosts file.
   
   #### On Windows:
   - Open `C:\Windows\System32\drivers\etc\hosts` in a text editor with administrative privileges.
   - Add a line like this at the end of the file:
     ```
     127.0.0.1   mycustomdomain.dev
     ```
   - Save the file.
   
   #### On macOS/Linux:
   - Open `/etc/hosts` in a text editor with `sudo` permissions:
     ```bash
     sudo nano /etc/hosts
     ```
   - Add a line like this at the end of the file:
     ```
     127.0.0.1   mycustomdomain.dev
     ```
   - Save the file.
   
   - **Use this Fake Domain**: Now, you can use `mycustomdomain.dev` as your "Authorized domain" in the Google Cloud Console. It will resolve to your localhost when accessed from your local machine.

   - **Update Redirect URIs**: In the OAuth settings, use `http://mycustomdomain.dev:8000/...` for redirect URIs.

###  **Use Localhost with 127.0.0.1**:
   - Instead of using "localhost", try using `127.0.0.1` in your "Authorized domains" and in your OAuth 2.0 Redirect URIs. 
   - **Example**: `127.0.0.1` is recognized by Google and might work for this purpose.

For a production environment, the best solution is to use a real domain name with HTTPS. For development purposes, editing your hosts file to create a fake domain or using `127.0.0.1` may allow you to proceed without needing a publicly accessible URL.


## 📝 Committing Changes with Git

Finally, commit all changes to your Git repository:

```bash
git status
git add .
git commit -m 'Advanced User Registration with Social Authentication'
```

## 🎉 Conclusion

We have successfully enhanced the user registration flow, including the addition of social authentication via GitHub. This makes the application more versatile and ready for modern web development challenges. In the next section.
