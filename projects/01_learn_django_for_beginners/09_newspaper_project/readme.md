# Newspaper Project

This section and the remaining portion of the project will focus on building a production-ready Newspaper website. The project choice is an homage to Django’s roots as a newspaper CRM. It provides the opportunity to introduce even more features, including advanced user authentication and styling, complex data models, permissions, deployment, and more.

## Initial Set Up

The first step is to create a new Django project from the command line. We need to do our familiar steps of creating and navigating to a new directory called `news` and installing and activating a new virtual environment with `pipenv`.

### Shell Commands

```sh
# Windows
cd onedrive\desktop\code
mkdir news
cd news
pipenv shell

```

Next, install Django and Black, create a new Django project called `django_project`, and make a new app called `accounts`.

```sh
pipenv install django==5.0.7
django-admin startproject django_project .
python manage.py startapp accounts
```

Note that we did not run `migrate` to configure our database. Given how tightly connected the user model is to the rest of Django, it’s important to wait until after we’ve created our new custom user model before doing so.

In your web browser, navigate to `http://127.0.0.1:8000`, and the familiar Django welcome screen will be visible.

## Git

The start of a new project is an excellent time to initialize Git and create a repo on GitHub. We’ve done this several times before, so we can use the same commands to initialize a new local Git repo and check its status.

```sh
git init
git status
```

The `Pipfile` , `Pipfile.lock` directory, the `__pycache__` directory, and the `SQLite` database should not be included in Git, so create a project-level `.gitignore` file in your text editor.

### .gitignore

```plaintext
Pipfile
Pipfile.lock
db.sqlite3
__pycache__
```

Run `git status` again to confirm the `Pipfile` or `Pipfile.lock`directory and `SQLite` database are not included. Then, add the rest of our work along with a commit message.

```sh
git status
git add .
git commit -m "initial commit"
```

Create a [`new repo`](https://github.com/new) on GitHub and provide a name. I’ve chosen `news`; my username is `hashimthepassionate`. Make sure to use your repo name and username using the command below.

```sh
git remote add origin https://github.com/hashimthepassionate/news.git
git branch -M main
git push -u origin main
```

All done!

## User Profile vs Custom User Model

Django’s built-in [User model](https://docs.djangoproject.com/en/5.0/ref/contrib/auth/#django.contrib.auth.models.User) allows us to start working with users right away, as we just did with our Blog app in the previous sections. However, most large projects need a way to add information related to users, such as age or any number of additional fields. There are two popular approaches.

The first is called the “User Profile” approach and [extends the existing User model](https://docs.djangoproject.com/en/5.0/topics/auth/customizing/#extending-the-existing-user-model) by creating a [`OneToOneField`](https://docs.djangoproject.com/en/5.0/ref/models/fields/#django.db.models.OneToOneField) to a separate model containing fields with additional information. The idea is to keep authentication reserved for User and not bundled with non-authentication-related user information.

The second approach is to create a custom user model that extends User but allows for additional user information to be added. The [Django documentation](https://docs.djangoproject.com/en/5.0/topics/auth/customizing/#using-a-custom-user-model-when-starting-a-project) recommends using a custom user model when starting a new project as it makes later customization far easier than using the default User model. A custom user model can be created using `AbstractUser`, which behaves identically to the default User model but allows for customization.

It is possible to implement a hybrid approach combining a custom user model and a user profile model. But for this project, we will stick to a basic custom user model using `AbstractUser`.

## AbstractUser

We can create a custom user model in four steps:
- Update `django_project/settings.py`
- Add a new `CustomUser` model
- Add new forms for `UserCreationForm` and `UserChangeForm`
- Update `accounts/admin.py`

### Update Settings

In `django_project/settings.py`, we’ll add the accounts app to our `INSTALLED_APPS`. Then at the bottom of the file, use the  [`AUTH_USER_MODEL`](https://docs.djangoproject.com/en/5.0/ref/settings/#std-setting-AUTH_USER_MODEL) config to tell Django to use our new custom user model instead of the built-in User model. We’ll call our custom user model `CustomUser`. Since it will exist within our accounts app, we should refer to it as `accounts.CustomUser`.

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "accounts", # new
]
...
AUTH_USER_MODEL = "accounts.CustomUser" # new
```

### Create the CustomUser Model

Next, update `accounts/models.py` with a new User model called `CustomUser`, which extends the existing `AbstractUser`. We will also include a custom field for age here.

```python
# accounts/models.py
from django.contrib.auth.models import AbstractUser
from django.db import models

class CustomUser(AbstractUser):
    age = models.PositiveIntegerField(null=True, blank=True)
```

If you read the [documentation on custom user models](https://docs.djangoproject.com/en/5.0/topics/auth/customizing/#specifying-a-custom-user-model), you will see that it recommends using `AbstractBaseUser`, not `AbstractUser`, which complicates things for beginners. Working with Django is far simpler and remains customizable if we use `AbstractUser` instead.

So why use `AbstractBaseUser` at all? If you want a fine level of control and customization, `AbstractBaseUser` can be justified. But it requires rewriting a core part of Django. If we want a custom user model that can be updated with additional fields, the better choice is `AbstractUser`, which subclasses `AbstractBaseUser`. In other words, we write much less code and have less opportunity to mess things up. It’s the better choice unless you really know what you’re doing with Django!

Note that we use both `null` and `blank` with our age field. These two terms are easy to confuse but quite distinct:
- `null` is database-related. When a field has `null=True`, it can store a database entry as NULL, meaning no value.
- `blank` is validation-related. If `blank=True`, then a form will allow an empty value, whereas if `blank=False`, then a value is required.

In practice,[`null`](https://docs.djangoproject.com/en/5.0/ref/models/fields/#null) and [`blank`](https://docs.djangoproject.com/en/5.0/ref/models/fields/#blank) are commonly used together in this fashion so that a form allows an empty value, and the database stores that value as NULL.

A common mistake is that the field type dictates how to use these values. Whenever you have a string-based field like `CharField` or `TextField`, setting both `null` and `blank` as we’ve done will result in two possible values for “no data” in the database, which is a bad idea. Instead, the Django convention is to use the empty string `""`, not NULL.

### Forms

If we step back briefly, how would we typically interact with our new `CustomUser` model? One case is when a user signs up for a new account on our website. The other is within the admin app, which allows us, as superusers, to modify existing users. So we’ll need to update the two built-in forms for this functionality: [`UserCreationForm`](https://docs.djangoproject.com/en/5.0/topics/auth/default/#django.contrib.auth.forms.UserCreationForm)  and [`UserChangeForm`](https://docs.djangoproject.com/en/5.0/topics/auth/default/#django.contrib.auth.forms.UserChangeForm).

Create a new file called `accounts/forms.py` and update it with the following code to extend the existing `UserCreationForm` and `UserChangeForm` forms.

```python
# accounts/forms.py
from django.contrib.auth.forms import UserCreationForm, UserChangeForm
from .models import CustomUser

class CustomUserCreationForm(UserCreationForm):
    class Meta:
        model = CustomUser
        fields = UserCreationForm.Meta.fields + ("age",)

class CustomUserChangeForm(UserChangeForm):
    class Meta:
        model = CustomUser
        fields = UserChangeForm.Meta.fields
```

For both new forms, we are using the [`Meta`](https://docs.djangoproject.com/en/5.0/topics/forms/modelforms/#overriding-the-default-fields) class to override the default fields by setting the model to our `CustomUser` and using the default fields via `Meta.fields` which includes all default fields. To add our custom age field, we simply tack it on at the end, and it will display automatically on our future signup page. Pretty slick, no?

The concept of fields on a form can be confusing at first, so let’s take a moment to explore it further. Our `CustomUser` model contains all the fields of the default User model and our additional age field, which we set.

But what are these default fields? It turns out there are [many](https://docs.djangoproject.com/en/5.0/ref/contrib/auth/#django.contrib.auth.models.User) including username, first_name, last_name, email, password, groups, and more. Yet when a user signs up for a new account on Django, the default form only asks for a username, email, and password, which tells us that the default setting for fields on `UserCreationForm` is just username, email, and password even though many more fields are available.

Understanding how forms and models interact in Django takes time and repetition. Don’t be discouraged if you are slightly confused right

 now! In the next section, we will create our signup, login, and logout pages to tie together our `CustomUser` model and forms more clearly.

### Update Admin

The final step is to update our `admin.py` file since the admin is tightly coupled to the default User model. We will extend the existing [`UserAdmin`](https://docs.djangoproject.com/en/5.0/topics/auth/customizing/#extending-the-existing-user-model) class to use our new `CustomUser` model. To control which fields are listed, we use [`list_display`](https://docs.djangoproject.com/en/5.0/ref/contrib/admin/#django.contrib.admin.ModelAdmin.list_display). But to edit new custom fields, like age, we must add [`fieldsets`](https://docs.djangoproject.com/en/5.0/ref/contrib/admin/#django.contrib.admin.ModelAdmin.fieldsets). And to include a new custom field in the section for creating a new user we rely on `add_fieldsets`.

Here is what the complete code looks like:

```python
# accounts/admin.py
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .forms import CustomUserCreationForm, CustomUserChangeForm
from .models import CustomUser

class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = [
        "email",
        "username",
        "age",
        "is_staff",
    ]
    fieldsets = UserAdmin.fieldsets + ((None, {"fields": ("age",)}),)
    add_fieldsets = UserAdmin.add_fieldsets + ((None, {"fields": ("age",)}),)

admin.site.register(CustomUser, CustomUserAdmin)
```

There are many ways to customize the user admin, and some developers like to add additional options such as `list_filter`, `search_fields`, and `ordering`.

But for this project, we are now done. Type `Control+c` to stop the local server and go ahead and run `makemigrations` and `migrate` for the first time to create a new database that uses the custom user model.

```sh
python manage.py makemigrations accounts

Migrations for 'accounts':
  accounts/migrations/0001_initial.py
    - Create model CustomUser

python manage.py migrate

Operations to perform:
  Apply all migrations: accounts, admin, auth, contenttypes, sessions
Running migrations:
  Applying contenttypes.0001_initial... OK
  Applying contenttypes.0002_remove_content_type_name... OK
  Applying auth.0001_initial... OK
  Applying auth.0002_alter_permission_name_max_length... OK
  Applying auth.0003_alter_user_email_max_length... OK
  Applying auth.0004_alter_user_username_opts... OK
  Applying auth.0005_alter_user_last_login_null... OK
  Applying auth.0006_require_contenttypes_0002... OK
  Applying auth.0007_alter_validators_add_error_messages... OK
  Applying auth.0008_alter_user_username_max_length... OK
  Applying auth.0009_alter_user_last_name_max_length... OK
  Applying auth.0010_alter_group_name_max_length... OK
  Applying auth.0011_update_proxy_permissions... OK
  Applying auth.0012_alter_user_first_name_max_length... OK
  Applying accounts.0001_initial... OK
  Applying admin.0001_initial... OK
  Applying admin.0002_logentry_remove_auto_add... OK
  Applying admin.0003_logentry_add_action_flag_choices... OK
  Applying sessions.0001_initial... OK
```

### Superuser

Let’s create a superuser account to confirm everything is working as expected. On the command line, type the following command and go through the prompts.

```sh
python manage.py createsuperuser
```

Make sure your superuser email account is one that actually works. We will use it later on to verify email integration. But the fact that this flow here works is the first proof our custom user model is set up correctly. Let’s view things in the admin, too, to be extra sure. Start up the web server.

```sh
python manage.py runserver
```

Then navigate to the admin at `http://127.0.0.1:8000/admin` and log in. If you click on the link for “Users” you should see your superuser account and the default fields: Email Address, Username, Age, and Staff Status. These were set in `list_display` in our `admin.py` file.

The age field is empty because we have yet to set it. However, you can set your age now because we set the `fieldsets` section. Click on the highlighted link for your superuser’s email address to bring up the edit user interface. If you scroll to the bottom, you will see that we added the age field. Go ahead and enter your age. Then click on “Save.”

It will redirect back to the main Users page listing our superuser. Note that the age field is now updated.

## Tests

It is a good idea to add tests every time we make code changes that alter core functionality. While all our manual actions trying out the custom user worked just now, we may break something in the future. Adding tests for new code and regularly running the entire test suite helps spot errors early.

At a high level, we want to ensure that both a regular user and a superuser can be created and have the proper field permissions. Suppose you look at the official documentation on `models.User`, which our custom user model inherits from. In that case, it comes with several built-in fields: username, first_name, last_name, email, password, groups, user_permissions, is_staff, is_active, is_superuser, last_login, and date_joined. It is also possible to add any number of custom fields, as we have seen by adding the age field.

Being “staff” means a user can access the admin site and view models for which they are given permission; a “superuser” has full access to the admin and all its models. A regular user should have `is_active` set to `True`, `is_staff` set to `False`, and `is_superuser` to `False`. A superuser should have everything set to `True`.

Here is one way to add tests to our custom user model:

```python
# accounts/tests.py
from django.contrib.auth import get_user_model
from django.test import TestCase

class UsersManagersTests(TestCase):
    def test_create_user(self):
        User = get_user_model()
        user = User.objects.create_user(
            username="testuser",
            email="testuser@example.com",
            password="testpass1234",
        )
        self.assertEqual(user.username, "testuser")
        self.assertEqual(user.email, "testuser@example.com")
        self.assertTrue(user.is_active)
        self.assertFalse(user.is_staff)
        self.assertFalse(user.is_superuser)

    def test_create_superuser(self):
        User = get_user_model()
        admin_user = User.objects.create_superuser(
            username="testsuperuser",
            email="testsuperuser@example.com",
            password="testpass1234",
        )
        self.assertEqual(admin_user.username, "testsuperuser")
        self.assertEqual(admin_user.email, "testsuperuser@example.com")
        self.assertTrue(admin_user.is_active)
        self.assertTrue(admin_user.is_staff)
        self.assertTrue(admin_user.is_superuser)
```

At the top, we import [`get_user_model()`](https://docs.djangoproject.com/en/5.0/topics/auth/customizing/#django.contrib.auth.get_user_model), so we can test our user registration. We also import `TestCase` since these tests touch the database.

Our class of tests is called `UsersManagersTests` and extends `TestCase`. The first unit test, `test_create_user`, checks that a regular user displays expected behavior. The second unit test, `test_create_superuser`, does the same, albeit for a superuser account.

Now run the tests; they should pass without any issues.

```sh
python manage.py test

Found 2 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
..
----------------------------------------------------------------------
Ran 2 tests in 0.114s

OK
Destroying test database for alias 'default'...
```

## Git

We’ve completed a bunch of new work, so it’s time to add a Git commit.

```sh
git status
git add -A
git commit -m "custom user model"
```
## .gitignore

```plaintext
Pipfile
Pipfile.lock
db.sqlite3
__pycache__
```

## Conclusion

We started our new project by adding a custom user model and an age field. We also explored how to add tests whenever core Django functionality is changed and can now focus on building the rest of our Newspaper website. In the next section, we will implement advanced authentication and registration by customizing the signup, login, and logout pages.
