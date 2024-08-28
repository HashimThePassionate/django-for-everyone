# 🌟 Email Configuration for Django Bookstore 🌟

> Before we start, first copy these requirements.txt to your project folder.

```shell
asgiref==3.8.1
certifi==2024.7.4
charset-normalizer==3.3.2
crispy-bootstrap5==0.6
Django==5.1
django-allauth==64.1.0
django-crispy-forms==1.14.0
idna==3.8
psycopg2-binary==2.9.9
requests==2.32.3
sqlparse==0.5.1
starkbank-ecdsa==2.2.0
tzdata==2024.1
urllib3==2.2.2
environs[django]==9.5.0
PyJWT==2.7.0
cryptography==41.0.3
```

Now lets build new application in docker container

```shell
docker-compose down -v
docker-compose up -d --build
docker-compose exec web python manage.py makemigrations accounts
docker-compose exec web python manage.py migrate
docker-compose exec web python manage.py createsuperuser
```

In this section, we will fully configure email functionality and add password change and password reset capabilities to our Django project. Currently, emails are not actually sent to users; they are simply outputted to our command line console. We’ll change that by signing up for a third-party email service, obtaining API keys, and updating our `django_project/settings.py` file. Django takes care of the rest! 😎

So far, all of our work—custom user model, pages app, static assets, authentication with allauth, and environment variables—could apply to almost any new project. After this section, we will start building out the Bookstore site itself as opposed to just foundational steps.

## ✉️ Custom Confirmation Emails

Let’s sign up for a new user account to review the current user registration flow, and then we'll customize it. Make sure you are logged out and then navigate to the Sign-Up page. For demonstration, we’ll use the following credentials:

- **Email:** `testuser3@email.com`
- **Password:** `testpass123`

### 📝 Step 1: User Registration

After signing up, you will be redirected to the homepage with a custom greeting, and an email will be sent to you within the command line console. You can check this by viewing the logs with the following command:

```shell
docker-compose logs
```

Here’s a snippet of what you might see:

```shell
Hello from example.com!
| You're receiving this e-mail because user testuser3 ...
```

### 🛠️ Step 2: Customizing the Email Templates

To customize this email, we first need to find the existing templates. Navigate over to the [`django-allauth`](https://github.com/pennersr/django-allauth) source code on GitHub and perform a search using a portion of the generated text. For example, searching for "You’re receiving this e-mail" leads us to the `email_confirmation_message.txt` file located within `django-allauth/allauth/templates/account/email`.

If you look at this directory’s content, there is also a subject line file, `email_confirmation_subject.txt`, which we will also change.

#### 🚀 Step 2.1: Overriding Templates

To customize these files, we’ll override them by recreating the same structure of `django-allauth` in our project. That means creating an email directory within the `templates/account` directory.

Run the following command:

```shell
mkdir -p templates/account/email
```

And then in your text editor, create the following two files:

- `templates/account/email/email_confirmation_subject.txt`
- `templates/account/email/email_confirmation_message.txt`

#### ✍️ Step 2.2: Updating the Subject Line

Let’s start with the subject line since it’s the shorter of the two. Here is the default text from `django-allauth`:

```django
{% load i18n %}
{% autoescape off %}
{% blocktrans %}Please Confirm Your E-mail Address{% endblocktrans %}
{% endautoescape %}
```
The first line, {% load i18n %}, is to support Django’s [`internationalization`](https://docs.djangoproject.com/en/5.1/topics/i18n/) functionality which supports multiple languages. Then comes the Django template tag for [`autoescape`](https://docs.djangoproject.com/en/5.1/ref/templates/builtins/#autoescape). By default it is “on” and protects against security issues like cross site scripting. But since we can trust the content of the text here, it is turned off.

Finally, we come to our text itself which is wrapped in [`blocktrans`](https://docs.djangoproject.com/en/5.1/topics/i18n/translation/#std:templatetag-blocktrans) template tags to support translations. Let’s change the text from “E-mail Address” to “Sign Up” to demonstrate that we can.

Autoescape in Django is a feature that automatically escapes HTML content to protect against XSS (Cross-Site Scripting) attacks. When autoescape is enabled, Django converts special characters in variables (like `&`, `<`, `>`, etc.) to their HTML-safe equivalents when displaying them in HTML. This helps prevent harmful scripts from running on your website.

🌟 **Autoescape** 🌟

🤔 **What is it?**  
A Django feature that automatically makes your website **secure**.

🔐 **How does it work?**  
When you display content in HTML, it escapes special characters to ensure that no **harmful scripts** can run.

💻 **Example**:  
If your variable contains `<script>alert('Hello')</script>`, Django will convert it to `&lt;script&gt;alert('Hello')&lt;/script&gt;` to prevent the script from running.

⚙️ **Why is it useful?**  
This protects your website from XSS attacks, keeping your content **safe**.

By default, autoescape is enabled, but you can disable it with `{% autoescape off %}{{ variable }}{% endautoescape %}` if you are certain that your content is safe.

🌍 **Bottom line:** Autoescape automatically secures your Django application. 🛡️

This subject line can be customized to say something more specific. For example, let’s change it from "E-mail Address" to "Sign Up":
```django
{% load i18n %}
{% autoescape off %}
{% blocktrans %}Confirm Your Sign Up{% endblocktrans %}
{% endautoescape %}
```

#### 💬 Step 2.3: Updating the Email Confirmation Message

Now, let's update the email confirmation message itself. Here is the current [`default`](https://github.com/pennersr/django-allauth/blob/353386216b79f16709e97bb487c0bbbba2bc0c71/allauth/templates/account/email/email_confirmation_message.txt): 

```django
{% extends "account/email/base_message.txt" %}
{% load account %}
{% load i18n %}
{% block content %}{% autoescape off %}{% user_display user as user_display %}\
{% blocktrans with site_name=current_site.name site_domain=current_site.domain %}\
You're receiving this e-mail because user {{ user_display }} has given your\
e-mail address to register an account on {{ site_domain }}.
To confirm this is correct, go to {{ activate_url }}\
{% endblocktrans %}{% endautoescape %}{% endblock %}
```
> **Note that backslashes \ are included for formatting but are not necessary in the raw code. In
other words, you can remove them from the code below–and other code examples–as needed.**

You probably noticed that the default email sent referred to our site as example.com which is displayed here as {{ site_name }}. Where does that come from? The answer is the sites section of the Django admin, which is used by django-allauth. So head to the admin at
http://127.0.0.1:8000/admin/ and click on the Sites link on the homepage.

This template pulls the site name and domain from the Django admin's Sites section, which `django-allauth` uses. To update this information:

1. Navigate to the admin at `http://127.0.0.1:8000/admin/`.
2. Click on the "Sites" link.
3. Update the  Domain name and "Display Name" fields to reflect your site, such as `djangobookstore.com` for the domain name and `Django Bookstore` for the display name.

There is a “Domain Name” and a “Display Name” here. Click on example.com under “Domain Name” so we can edit it. The [`"Domain Name"`](https://docs.djangoproject.com/en/5.1/ref/contrib/sites/#django.contrib.sites.models.Site.name)  is the full domain name for a site, for example it might be djangobookstore.com, while the [`Display Name `](https://docs.djangoproject.com/en/5.1/ref/contrib/sites/#django.contrib.sites.models.Site.name) is a human-readable name for the site such as Django Bookstore.

After making these updates, click the `“Save”` button.

Ok, back to our email. Let’s customize it a bit. On the first line we can see that this email actually extends another template–base_message.txt–that contains the initial greeting of “Hello from…”. To update that we’d just need to add a base_message.txt file to the email folder. Since this is just
for demonstration purposes, trying changing “You’re” to “You are” to prove that we can customize the text

#### 📝 Step 2.4: Customizing the Email Content

To customize the greeting or any part of the message, update the `email_confirmation_message.txt` file. For demonstration, let's change "You’re" to "You are":

```django
{% extends "account/email/base_message.txt" %}
{% load account %}
{% load i18n %}
{% block content %}{% autoescape off %}{% user_display user as user_display %}\
{% blocktrans with site_name=current_site.name site_domain=current_site.domain %}\
You are receiving this e-mail because user {{ user_display }} has given your\
e-mail address to register an account on {{ site_domain }}.
To confirm this is correct, go to {{ activate_url }}\
{% endblocktrans %}{% endautoescape %}{% endblock %}
```

One final item to change. Did you notice the email was from webmaster@localhost?  That’s a default setting we can also update via [`DEFAULT_FROM_EMAIL`](https://docs.djangoproject.com/en/5.1/ref/settings/#default-from-email). Let’s do that now by adding the following line at the bottom of the django_project/settings.py file


#### 📧 Step 2.5: Updating the Default Email Sender

Finally, let’s update the default email sender from `webmaster@localhost`. This can be changed by adding the following line at the bottom of the `django_project/settings.py` file:

```python
# django_project/settings.py
DEFAULT_FROM_EMAIL = "warriorecosystem346@gmail.com" # new
```

### 🛠️ Step 3: Test the Changes

Make sure you are logged out of the site, then go to the Sign-Up page again to create a new user. Use the following credentials for convenience:

- **Email:** `warriorecosystem346@gmail.com`
- **Password:** Your choice.

After signing up, check the command line logs with:

```shell
docker-compose logs
```

You should see something like this:

```shell
web_1 | Subject: Django Bookstore] Confirm Your Sign Up
web_1 | From: warriorecosystem346@gmail.com
web_1 | To: warriorecosystem346@gmail.com
web_1 | Hello from Django Bookstore!
web_1 | You are receiving this e-mail because user testuser4 has given your \
e-mail address to register an account on djangobookstore.com.
```
## 🌐 Email Confirmation Page Update

Click on the unique URL link in the email, which redirects to the email confirm page. The default page is not very attractive, so let’s update it to match the look of the rest of our site.

Not very attractive. Let’s update it to match the look of the rest of our site. Searching again in the django-allauth [source code on Github](https://github.com/pennersr/django-allauth) reveals the name and location of this file is templates/account/email_confirm.html. So let’s create our own template file with the same name and then update it to extend _base.html and use Bootstrap for the button.

The template is located at `templates/account/email_confirm.html` in `django-allauth`. We can create our own template file with the same name and update it to extend `_base.html` and use Bootstrap for styling.
Here’s an example:

```html
<!-- templates/account/email_confirm.html -->
{% extends "_base.html" %}
{% load i18n %}
{% load account %}
{% block head_title %}{% trans "Confirm E-mail Address" %}{% endblock %}
{% block content %}
<h1>{% trans "Confirm E-mail Address" %}</h1>
{% if confirmation %}
{% user_display confirmation.email_address.user as user_display %}
<p>{% blocktrans with confirmation.email_address.email as email %}Please confirm
that <a href="mailto:{{ email }}">{{ email }}</a> is an e-mail address for user
{{ user_display }}.{% endblocktrans %}</p>
<form method="post" action="{% url 'account_confirm_email' confirmation.key %}">
{% csrf_token %}
<button class="btn btn-primary" type="submit">{% trans 'Confirm' %}</button>
</form>
{% else %}
{% url 'account_email' as email_url %}
<p>{% blocktrans %}This e-mail confirmation link expired or is invalid. Please
<a href="{{ email_url }}">issue a new e-mail confirmation request</a>.\
{% endblocktrans %}</p>
{% endif %}
{% endblock %}
```
Sure! Let's break it down with some fun emojis to make it more engaging! 😊

### 📧 Email Confirmation Template

This template is designed to handle the **confirmation of a user's email address** in your Django app using `allauth`. It extends from a base HTML template and includes key features to ensure a smooth experience for the user. Let's dive into it!

#### 🖼️ Page Title
The title of the page is set to **"Confirm E-mail Address"** to clearly indicate what the page is about.

#### 📜 Content Section
- **✅ Valid Confirmation:**
  - If the confirmation link is valid, the page will display a message asking the user to **confirm their email address**. 
  - The email address is clickable (🔗), so the user can easily send an email if needed.
  - A **confirmation button** (✔️) is provided, and the user just needs to click it to confirm their email address.

- **⚠️ Expired or Invalid Link:**
  - If the confirmation link has **expired** or is **invalid**, the user is informed about it.
  - The page also offers a helpful link to **request a new confirmation email** (🔄), so the user can try again.

#### 🌐 Internationalization (i18n)
The template uses `{% trans %}` and `{% blocktrans %}` tags to support **multiple languages** 🌍, ensuring that users from different regions can understand the content.

#### 🔒 Security
The form includes a `{% csrf_token %}` tag to protect against **CSRF attacks** (🔐), making sure the form submission is secure.

This template makes the email confirmation process **easy** 🛠️ and **user-friendly** 👥, while also handling expired or invalid links gracefully.

### 🔄 Refresh the Page

After making the changes, refresh the email confirmation page to see the update.

Certainly! Let's replace the example SMTP configuration with a detailed explanation of how to configure your Django project to use Mailtrap for sending emails:

---

### 📝 Step 1: User Registration

After signing up, you will be redirected to the homepage with a custom greeting, and an email will be sent to you. This email will confirm your registration. Initially, this email will be printed on the command line, but after setting up Gmail SMTP, it will be sent to your actual email.

### 🚀 Step 2: Configuring Gmail SMTP

To send emails using Gmail, follow these steps:

#### 🔐 Step 2.1: Enable Two-Step Verification

Before you can send emails using Gmail’s SMTP server, you must enable two-step verification on your Gmail account.

1. **Sign in to your Gmail account.**
2. **Navigate to your Google Account settings** by clicking on your profile picture and selecting "Manage your Google Account."
3. **Click on "Security"** in the left-hand menu.
4. **Scroll down to "Signing in to Google"** and click on "2-Step Verification."
5. **Follow the prompts to enable two-step verification** on your account.

#### 🗝️ Step 2.2: Generate an App Password

Once two-step verification is enabled, you need to generate an app password for your Django project:

1. **Go back to the "Security" section** of your Google Account settings.
2. **Under "Signing in to Google," click on "App Passwords."** 
> if app password not found, then search app password on search bar
3. **Select "Other (Custom name)"** from the dropdown and enter a name, such as "Django Email."
4. **Click "Generate."**
5. **Copy the generated app password** (it will be a 16-character code) and store it securely.

#### 🛠️ Step 2.3: Update `settings.py` with SMTP Configuration

Now, update your Django project’s `settings.py` file to use Gmail’s SMTP server:

```python
# django_project/settings.py
import os
from environs import Env

env = Env()
env.read_env()

EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"  # Use the SMTP backend to send emails
EMAIL_HOST = "smtp.gmail.com"  # Gmail's SMTP server
EMAIL_PORT = 587  # Port for sending emails over TLS
EMAIL_HOST_USER = env("EMAIL_HOST_USER")  # Your Gmail email address
EMAIL_HOST_PASSWORD = env("EMAIL_HOST_PASSWORD")  # The app password generated in the previous step
EMAIL_USE_TLS = True  # Enable TLS encryption
DEFAULT_FROM_EMAIL = env("DEFAULT_FROM_EMAIL")  # Default sender email address
```

#### 💾 Step 2.4: Set Environment Variables

To keep your credentials secure, store them in environment variables. Update your `.env` file with the following values:

```bash
# .env file
EMAIL_HOST_USER=your_email@gmail.com
EMAIL_HOST_PASSWORD=your_generated_app_password
DEFAULT_FROM_EMAIL=your_email@gmail.com
```

This ensures that sensitive information like your Gmail email address and app password is not hardcoded in your project files.

## 🔑 Password Reset and Password Change

Django and `django-allauth` also provide support for resetting a forgotten password and changing your existing password if already logged in. You can find the corresponding templates and email messages in the `django-allauth` source code.

- **Password Reset URL:** `http://127.0.0.1:8000/accounts/password/reset/`
- **Password Change URL:** `http://127.0.0.1:8000/accounts/password/change/`

### 📧 Step 3.0: Password Reset and Change Pages

Let's also customize the password reset and change pages to match your site's design.

#### 🚀 Step 3.1: Password Reset Page

Create a custom `password_reset.html`:

```html
{% extends "_base.html" %}
{% load crispy_forms_tags %}
{% block title %}Password Reset{% endblock %}
{% block content %}
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header text-center">
                    <h2>Password Reset</h2>
                </div>
                <div class="card-body">
                    {% if form %}
                        <p class="text-muted">
                            Forgot your password? Enter your email address below, and we'll send you an email allowing you to reset it.
                        </p>
                        <form method="post">
                            {% csrf_token %}
                            <div class="mb-3">
                                {{ form.email|as_crispy_field }}
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Reset My Password</button>
                        </form>
                    {% else %}
                        <p class="text-success">
                            An email has been sent to your inbox with instructions to reset your password.
                        </p>
                    {% endif %}
                    <p class="mt-3">
                        <a href="{% url 'account_login' %}" class="btn btn-link">Back to login</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
{% endblock %}
```

#### 🚀 Step 3.2: Password Change Page

And finally, create a custom `password_change.html`:

```html
{% extends "_base.html" %} {% load crispy_forms_tags %} {% block content %}
<div class="container mt-5">
  <div class="row justify-content-center">
    <div class="col-md-6">
      <div class="card">
        <div class="card-header text-center">
          <h2>Change Password</h2>
        </div>
        <div class="card-body">
          <form method="post">
            {% csrf_token %} {{ form|crispy }}
            <div class="text-center">
              <button type="submit" class="btn btn-primary">
                Change Password
              </button>
            </div>
          </form>
          <div class="text-center mt-3">
            <a href="{% url 'account_reset_password' %}">Forgot Password?</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
{% endblock %}
```

Here's a step-by-step guide with beautiful emojis to ensure users cannot log in or be redirected to the home page before confirming their email using Django Allauth. We'll use settings, adapters, and custom messages to guide users properly. Let's make this process clear and visually appealing!

### 🌟 Step 4.1: Update Django Allauth Settings

First, update your Django settings file (`settings.py`) to enforce email confirmation before login. Add or update these settings:

```python
# settings.py
# 🔒 Require email confirmation before allowing login
ACCOUNT_EMAIL_VERIFICATION = "mandatory"  # 🚫 Users must verify their email before logging in.
ACCOUNT_EMAIL_CONFIRMATION_EXPIRE_DAYS = 3  # 🕒 Email confirmation link expires in 3 days.
ACCOUNT_LOGIN_ON_EMAIL_CONFIRMATION = False  # 🔄 Prevent automatic login after email confirmation.
ACCOUNT_EMAIL_CONFIRMATION_AUTHENTICATED_REDIRECT_URL = 'account_login'  # ↩️ Redirect to login after confirmation.
ACCOUNT_LOGIN_ON_PASSWORD_RESET = False  # 🚫 Prevent automatic login after password reset.
```

### 🌟 Step 4.2: Modify Signup Flow to Prevent Redirect Without Confirmation

Ensure the signup view does not redirect users to the home page without confirming their email. The setting `ACCOUNT_EMAIL_VERIFICATION = "mandatory"` ensures unverified email addresses cannot be used to log in. 

### 🌟 Step 4.3: Customize Redirects in Allauth Views

By default, Django Allauth might redirect users to the home page after signup. To prevent this, update the Allauth adapter to redirect users to an informative page that instructs them to confirm their email.

1. 📁 **Create a new file**, e.g., `adapters.py` in your accounts app (or wherever you handle Allauth settings).

2. ✏️ **Add the following code** to create a custom adapter:

   ```python
   # adapters.py
   from allauth.account.adapter import DefaultAccountAdapter
   from django.urls import reverse

   class NoRedirectLoginAdapter(DefaultAccountAdapter):
       def get_login_redirect_url(self, request):
           # 🚦 Redirect to login page or a custom "please confirm your email" page
           return reverse('account_login')  # ➡️ Redirect to login page
   ```

3. ⚙️ **Register this adapter** in your settings:

   ```python
   # settings.py
   ACCOUNT_ADAPTER = 'yourapp.adapters.NoRedirectLoginAdapter'  # 📂 Replace 'yourapp' with your app name
   ```

### 🌟 Step 4.5: Add Confirmation Message to Login Page

To inform users that they need to confirm their email, you can add a message on the login page that checks if the email is confirmed. This step provides a better user experience and ensures they know why their login attempt failed.

### 🌟 Step 5: Test the Flow

1. 📝 **Sign up** with a new email address.
2. 📧 **Do not confirm** the email immediately.
3. 🚫 Attempt to log in—Django should prevent the login and inform the user to confirm the email first.


## 💾 Git Commit and Push
To save these changes, commit the updates to your Git repository:

```shell
git status
git add .
git commit -m 'Proper Email Configurations'
git push origin main
```

If you encounter any issues, compare your code against the official source code on [GitHub](https://github.com).

## 🎉 Conclusion

Configuring email properly is a one-time challenge but an essential part of any production website. This concludes the foundational sections for our Django Bookstore project. In the next section, we’ll finally start building out the Bookstore itself!

