# Password Change and Reset

In this section, we will complete the authorization flow of our Newspaper app by adding password change and password reset functionality. We’ll implement Django’s built-in views and URLs for password changes and resets before customizing them with our own Bootstrap-powered templates.

## Password Change

Many websites allow users to change their passwords, and Django provides a default implementation that already works at this stage. To try it out, log in and navigate to the “Password change” page at `http://127.0.0.1:8000/accounts/password_change/`.

After entering your old password and a new one, click the “Change My Password” button, and you will be redirected to the “Password change successful” page.

### Customizing Password Change

Let’s customize these two password change pages to match the look and feel of our Newspaper site. Since Django already provides the views and URLs, we only need to change the templates. However, we must use the names `password_change_form.html` and `password_change_done.html`. 

In your text editor, create two new template files in the `registration` directory:

- `templates/registration/password_change_form.html`
- `templates/registration/password_change_done.html`

Update `password_change_form.html` with the following code:

### Code

```html
<!-- templates/registration/password_change_form.html -->
{% extends "base.html" %}
{% load crispy_forms_tags %}
{% block title %}Password Change{% endblock title %}
{% block content %}
<h1>Password change</h1>
<p>Please enter your old password, for security's sake, and then enter
your new password twice so we can verify you typed it in correctly.</p>
<form method="POST">{% csrf_token %}
    {{ form|crispy }}
    <input class="btn btn-success" type="submit" value="Change my password">
</form>
{% endblock content %}
```

Load the page at `http://127.0.0.1:8000/accounts/password_change/` to see our changes.

Next, update `password_change_done.html`:

### Code

```html
<!-- templates/registration/password_change_done.html -->
{% extends "base.html" %}
{% block title %}Password Change Successful{% endblock title %}
{% block content %}
<h1>Password change successful</h1>
<p>Your password was changed.</p>
{% endblock content %}
```

You can view this page at: `http://127.0.0.1:8000/accounts/password_change/done/`.

## Password Reset

Password reset handles the typical case of users forgetting their passwords. Django already provides a default implementation that we will use, and then we will customize the templates to match the look and feel of the rest of our site.

### Email Configuration

The only configuration required is telling Django how to send emails. For testing purposes, we can rely on Django’s console backend setting, which outputs the email text to our command-line console.

Add the following one-line change at the bottom of the `django_project/settings.py` file:

### Code

```python
# django_project/settings.py

EMAIL_BACKEND = "django.core.mail.backends.console.EmailBackend" # new
```

### Testing the Password Reset

Navigate to `http://127.0.0.1:8000/accounts/password_reset/` to view the default password reset page. Make sure the email address you enter matches one of your existing user accounts. 

Upon submission, you’ll be redirected to the password reset done page at `http://127.0.0.1:8000/accounts/password_reset/done/`.

This page says to check your email. Since we’ve told Django to send emails to the command line console, the email text will now be there. The email text includes a secure token that Django randomly generates for us and can be used only once. 

Find the link provided in the email output and enter it into your web browser. You’ll be redirected to the “Password reset confirmation” page. After entering a new password and clicking the “Change my password” button, you will be redirected to the “Password reset complete” page.

### Custom Templates

As with the password change pages, we can create new templates to customize the look and feel of the entire password reset flow. If you noticed, four separate templates are used. Create these new files now in your `templates/registration/` directory.

- `templates/registration/password_reset_form.html`
- `templates/registration/password_reset_done.html`
- `templates/registration/password_reset_confirm.html`
- `templates/registration/password_reset_complete.html`

Start with the password reset form, which is `password_reset_form.html`:

### Code

```html
<!-- templates/registration/password_reset_form.html -->
{% extends "base.html" %}
{% load crispy_forms_tags %}
{% block title %}Forgot Your Password?{% endblock title %}
{% block content %}
<h1>Forgot your password?</h1>
<p>Enter your email address below, and we'll email instructions
for setting a new one.</p>
<form method="POST">{% csrf_token %}
    {{ form|crispy }}
    <input class="btn btn-success" type="submit" value="Send me instructions!">
</form>
{% endblock content %}
```

Start up the server again with `python manage.py runserver` and navigate to: `http://127.0.0.1:8000/accounts/password_reset/`.

Refresh the page, and you will see our new page.

Now we can update the other three pages.

**password_reset_done.html:**

### Code

```html
<!-- templates/registration/password_reset_done.html -->
{% extends "base.html" %}
{% block title %}Email Sent{% endblock title %}
{% block content %}
<h1>Check your inbox.</h1>
<p>We've emailed you instructions for setting your password.
You should receive the email shortly!</p>
{% endblock content %}
```

Confirm the changes by going to `http://127.0.0.1:8000/accounts/password_reset/done/`.

**password_reset_confirm.html:**

### Code

```html
<!-- templates/registration/password_reset_confirm.html -->
{% extends "base.html" %}
{% load crispy_forms_tags %}
{% block title %}Enter new password{% endblock title %}
{% block content %}
<h1>Set a new password!</h1>
<form method="POST">{% csrf_token %}
    {{ form|crispy }}
    <input class="btn btn-success" type="submit" value="Change my password">
</form>
{% endblock content %}
```

In the command line, grab the URL link from the custom email previously outputted to the console, and you’ll see the updated page.

**password_reset_complete.html:**

### Code

```html
<!-- templates/registration/password_reset_complete.html -->
{% extends "base.html" %}
{% block title %}Password reset complete{% endblock title %}
{% block content %}
<h1>Password reset complete</h1>
<p>Your new password has been set.</p>
<p>You can log in now on the
<a href="{% url 'login' %}">Log In page</a>.</p>
{% endblock content %}
```

You can view it at `http://127.0.0.1:8000/accounts/reset/done/`.

### Try It Out

Let’s confirm everything is working by resetting the password for the testuser2 account. Log out of your current account and head to the login page–the logical location for a “Forgot your password?” link that sends a user into the password reset section.

First, add the password reset link to the existing login page:

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
<!-- new code here -->
<p><a href="{% url 'password_reset' %}">Forgot your password?</a></p>
<!-- end new code -->
{% endblock content %}
```

Refresh the login webpage to confirm the new “Forgot your password?” link is there. Click on the link to bring up the password reset template and complete the flow using the email for `testuser2@email.com`. Set a new password and use it to log in to the `testuser2` account. Everything should work as expected.

## Git

Another chunk of work has been completed. Use Git to save our work before continuing.

### Shell Commands

```sh
(.venv) $ git status -
(.venv) $ git add .
(.venv) $ git commit -m "password change and reset"
(.venv) $ git push origin main
```

## Conclusion

In the next section, we will build out our actual Newspaper app that displays articles.