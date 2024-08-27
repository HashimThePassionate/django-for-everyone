# 🌟 Email Configuration for Django Bookstore 🌟

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
``Run`` 
```python
docker-compose exec web pip freeze > requirements.txt
```
``output``
```
asgiref==3.8.1
certifi==2024.7.4
charset-normalizer==3.3.2
crispy-bootstrap5==0.6
Django==5.1
django-allauth==64.1.0
django-anymail==11.1
django-crispy-forms==1.14.0
idna==3.8
psycopg2-binary==2.9.9
python-http-client==3.3.7
requests==2.32.3
sendgrid==6.11.0
sqlparse==0.5.1
starkbank-ecdsa==2.2.0
tzdata==2024.1
urllib3==2.2.2
environs[django]==9.5.0
PyJWT==2.7.0
cryptography==41.0.3
```

### 🌟 Example SMTP Configuration

### 💡 Detailed SMTP Configuration with Explanation

Now, let's look at a specific example of configuring an SMTP server using Mailtrap, which is commonly used for testing email functionality:

```python
# django_project/settings.py
EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"  # This setting tells Django to use the SMTP backend for sending emails.
EMAIL_HOST = "sandbox.smtp.mailtrap.io"  # The SMTP server address provided by Mailtrap.
EMAIL_PORT = 2525  # The port used to connect to the SMTP server. 2525 is often used by Mailtrap for unencrypted connections.
EMAIL_HOST_USER = env("MAILTRAP_USERNAME")  # The username for authenticating with the SMTP server, stored securely in an environment variable.
EMAIL_HOST_PASSWORD = env("MAILTRAP_PASSWORD")  # The password for authenticating with the SMTP server, also stored securely.
EMAIL_USE_TLS = True  # This setting enables TLS (Transport Layer Security) for encrypting the email transmission, enhancing security.
DEFAULT_FROM_EMAIL = 'warriorecosystem346@gmail.com'  # This is the email address that will appear in the "From" field when sending emails.
```

**Explanation:**

- **`EMAIL_BACKEND`**: This is set to `django.core.mail.backends.smtp.EmailBackend`, which tells Django to send emails using an SMTP server.
- **`EMAIL_HOST`**: The address of the SMTP server provided by your email service. Here, we use Mailtrap's sandbox server for testing purposes.
- **`EMAIL_PORT`**: The port number to use for the SMTP connection. Mailtrap typically uses port 2525 for unencrypted connections.
- **`EMAIL_HOST_USER` and `EMAIL_HOST_PASSWORD`**: These are the credentials for logging in to the SMTP server. They should be stored securely in environment variables.
- **`EMAIL_USE_TLS`**: This ensures that the connection to the SMTP server is encrypted, which is essential for protecting the transmission of sensitive information.
- **`DEFAULT_FROM_EMAIL`**: This is the default "From" address that will be used when sending emails from your Django application.


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

## 🌍 Configuring the Email Service with Mailtrap

The emails we have configured so far are generally referred to as “Transactional Emails” because they occur based on user actions. To configure Mailtrap as your SMTP server for sending these emails, follow these steps:

1. **Sign Up for Mailtrap:**  
   First, create an account on [Mailtrap](https://mailtrap.io/). Mailtrap provides a safe testing environment for sending and receiving emails, ensuring that your emails don’t actually reach real users while you are still developing.

2. **Update `settings.py`:**  
   Set the `EMAIL_BACKEND` to use SMTP.

```python
# django_project/settings.py
EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"  # new
```

3. **Set Environment Variables:**  
   Mailtrap provides you with SMTP credentials that you'll need to configure in your Django project. After logging in to Mailtrap, follow these steps to get the credentials and set up your environment variables:

   - Go to your Mailtrap inbox.
   - Click on "SMTP Settings."
   - Copy the provided credentials, which typically include the SMTP server, port, username, and password.

Here’s how your environment variables might look:

```bash
export EMAIL_HOST=sandbox.smtp.mailtrap.io
export EMAIL_PORT=2525
export EMAIL_HOST_USER=your_mailtrap_username
export EMAIL_HOST_PASSWORD=your_mailtrap_password
export EMAIL_USE_TLS=True
```

4. **Configure Django with Mailtrap:**  
   Now, add these environment variables to your `.env` file to keep them secure. Then, update your `settings.py` to use these values:

```python
# django_project/settings.py
import os
from environs import Env

env = Env()
env.read_env()

EMAIL_BACKEND = "django.core.mail.backends.smtp.EmailBackend"  # Use the SMTP backend to send emails
EMAIL_HOST = env("EMAIL_HOST")  # Mailtrap SMTP server address
EMAIL_PORT = env.int("EMAIL_PORT")  # Mailtrap port number
EMAIL_HOST_USER = env("EMAIL_HOST_USER")  # Mailtrap username
EMAIL_HOST_PASSWORD = env("EMAIL_HOST_PASSWORD")  # Mailtrap password
EMAIL_USE_TLS = env.bool("EMAIL_USE_TLS", default=True)  # Enable TLS encryption
DEFAULT_FROM_EMAIL = 'your_email@example.com'  # Default sender email address
```

### 💡 Detailed Explanation of the Configuration

- **`EMAIL_BACKEND`**: This tells Django to use the SMTP backend for sending emails.
- **`EMAIL_HOST`**: The SMTP server address provided by Mailtrap, which is typically `sandbox.smtp.mailtrap.io`.
- **`EMAIL_PORT`**: The port used to connect to Mailtrap’s SMTP server. Port `2525` is commonly used for unencrypted connections, though Mailtrap also supports port `587` for TLS.
- **`EMAIL_HOST_USER` and `EMAIL_HOST_PASSWORD`**: These are your Mailtrap credentials (username and password), which you should keep secure by storing them in environment variables.
- **`EMAIL_USE_TLS`**: This ensures that the connection to the SMTP server is encrypted using TLS (Transport Layer Security), which is essential for protecting sensitive information during transmission.
- **`DEFAULT_FROM_EMAIL`**: The default "From" address that will appear when your Django application sends emails. You can set this to any email address you'd like to use as the sender.

### 🌟 Why Use Mailtrap?

Mailtrap is an excellent choice for testing email functionality during development. It allows you to send emails from your application without actually sending them to real users. Instead, the emails are captured in a virtual inbox within Mailtrap, where you can inspect them and ensure that your email logic is working correctly.

- **Safe Testing Environment:** Mailtrap ensures that no test emails reach actual users, preventing potential confusion or spam.
- **Easy to Use:** With simple setup steps and an intuitive interface, Mailtrap makes it easy to configure and monitor your email-sending logic.
- **Detailed Inspection:** You can view the content, headers, and delivery status of each email, making it easier to debug and refine your email features.

## 🔑 Password Reset and Password Change

Django and `django-allauth` also provide support for resetting a forgotten password and changing your existing password if already logged in. You can find the corresponding templates and email messages in the `django-allauth` source code.

- **Password Reset URL:** `http://127.0.0.1:8000/accounts/password/reset/`
- **Password Change URL:** `http://127.0.0.1:8000/accounts/password/change/`



## 💾 Git Commit and Push

To save these changes, commit the updates to your Git repository:

```shell
git status
git add .
git commit -m 'email configuration'
git push origin main
```

If you encounter any issues, compare your code against the official source code on [GitHub](https://github.com).

## 🎉 Conclusion

Configuring email properly is a one-time challenge but an essential part of any production website. This concludes the foundational sections for our Django Bookstore project. In the next section, we’ll finally start building out the Bookstore itself!

