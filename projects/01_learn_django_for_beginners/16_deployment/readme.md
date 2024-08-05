# Deployment

## Introduction

There is a fundamental tension between the ease of use desired in a local Django development environment and the security and performance necessary in production. Django is designed to make web developers lives easier, and therefore, it defaults to a local configuration when the `startproject` command is first run. We’ve seen this in the use of SQLite as the local file-based database, the built-in `runserver` command that launches a local web server in your web browser, and various default configurations in the `settings.py` file, including `DEBUG` set to `True` and an auto-generated `SECRET_KEY`.

In production, things are different. All the configurations optimized for ease of use in the development environment need to focus instead on security, performance, and scalability. Deploying a Django website to production requires several steps—so many, in fact, that the Django docs even have a [deployment checklist](https://docs.djangoproject.com/en/5.0/howto/deployment/checklist/). It is a very helpful tool, but unfortunately, it is not sufficient. Additional factors include various hosting options, environment variables, database configurations, handling static files, and more.

In this section, we will create a deployment checklist and deploy the Newspaper project using Heroku. The techniques covered will apply to almost any Django website that needs to be readied for production, regardless of the hosting platform.

## Hosting Options

If you ask five Django developers for the best hosting option, you’ll likely receive five different answers. Everyone has a different preference based on their own experience and project needs. Ultimately, though, we can divide hosting options into three main categories:

1. **Dedicated Server**: A physical server sitting in a data center that belongs exclusively to you. Generally, only the largest companies adopt this approach since it requires a lot of technical expertise to configure and maintain.

2. **Virtual Private Server (VPS)**: A server can be divided into multiple virtual machines that use the same hardware, which is much more affordable than a dedicated server. This approach also means you don’t have to worry about maintaining the hardware.

3. **Platform as a Service (PaaS)**: A managed VPS solution that is pre-configured and maintained, making it the fastest option to deploy and scale a website. It typically comes with a managed database as well. The downside is that a developer cannot access the same degree of customization that a VPS or a dedicated server provides. At scale, PaaS can become quite expensive.

The choices here are all about tradeoffs. Many Django developers and small companies are happy using a PaaS to essentially abstract away many of the difficulties inherent in putting code into production. Popular PaaS options include Heroku, Fly, and Render, among many others. For a VPS, Digital Ocean has the cleanest interface for a solo developer or small team, but for enterprise applications, the choice is typically between AWS, Google, or Microsoft.

For our Newspaper website, we will use a PaaS, specifically Heroku, because it is mature, widely used, and has a relatively straightforward deployment process. However, with the exception of creating a Heroku-specific `Procfile` file at the end, the steps outlined in this section will work with any PaaS provider.

## Web Servers and WSGI/ASGI Servers

The local server provided by Django and run via `runserver` handles multiple jobs that must be handled differently in production. First, it acts as a web server, software that sits in front of our Django application to process HTTP requests and responses. It also manages static file requests. Before Platforms-as-a-Service became available, it was up to the web developer to install, configure, and maintain a dedicated web server like [Nginx](https://nginx.org/en/) or [Apache](https://httpd.apache.org/): no small task and requiring a completely different skill set than web development. Fortunately, a Platform-as-a-Service knows we are deploying a website and automatically bundles a web server, generally Nginx, so we don’t have to install or manage it ourselves.

The other role that `runserver` has provided us is acting as an application server to help Django generate dynamic content. When a request comes in, `runserver` powers that request through URLs, views, models, the database, and templates, and then generates an HTTP response. In other words, `runserver` also acts as an application server, not just a web server.

Application servers are colloquially referred to as “WSGI servers” because they use WSGI to connect Python web apps to a server. In the early days of web development, web frameworks didn’t implicitly work well with various web servers without a lot of customization. For Python web frameworks, this led to the creation of the Web Server Gateway Interface (WSGI) in 2003. WSGI is not a server or framework but a set of rules that standardizes how web servers should connect to any Python web app. By abstracting away this headache, it opened the door to newer Python web frameworks–like Django, which was first released in 2005–that could work on any web server and did not have to worry about this step in the process. Common examples of production WSGI servers include Gunicorn, uWSGI, and Daphne.

Traditionally, Python was a synchronous programming language: code executed sequentially, meaning each piece of code had to be completed before another piece of code could begin. As a result, complex tasks might take a while. Starting in 2012 with Python 3.3, asynchronous programming was added to Python via the [asyncio](https://docs.python.org/3/library/asyncio.html) module. While synchronous processing is done sequentially in a specific order, asynchronous processing occurs in parallel. Tasks that are not dependent on others can be offloaded and executed at the same time as the main operation, and the result can then be reported back when complete.

Django has been gradually adding [asynchronous support](https://docs.djangoproject.com/en/5.0/topics/async/) since version 3.0 in 2019. One layer is the introduction of the Asynchronous Server Gateway Interface (ASGI), which, as the name suggests, standardizes how servers should connect to Python web apps that support both synchronous and asynchronous communication. ASGI is intended to be the eventual successor to WSGI.

ASGI and WSGI are both included in new Django projects now. When you run the `startproject` command, Django generates a `wsgi.py` file and an `asgi.py` file in the project-level directory, `django_project`.

Full async support for the entire Django stack is still in the works but comes ever closer with each new major release. Given that this section is for beginners, it is important to recognize asynchronous developments rather than dwell on them. While they are exciting from a technical perspective, they are also challenging to reason about and are most relevant for websites that need “real-time” functionality, such as live notifications, chat applications, real-time data updates, and interactive dashboards.

## Deployment Checklist

It can be overwhelming to see a complete deployment checklist right at the beginning, but it is a helpful guide for this section. Here, then, is the deployment checklist we will cover:

- Configure static files and install WhiteNoise
- Add environment variables with `environs`
- Create a `.env` file and update the `.gitignore` file
- Update `DEBUG`, `ALLOWED_HOSTS`, `SECRET_KEY`, and `CSRF_TRUSTED_ORIGINS`
- Update `DATABASES` to run PostgreSQL in production and install `psycopg`
- Install Gunicorn as a production WSGI server
- Create a `Procfile`
- Update the `requirements.txt` file
- Create a new Heroku project, push the code to it, and start a dyno web process

We could toggle many more production settings, but this list covers the most critical security and performance concerns.

## Static Files

### Local Usage

Static files are the images, JavaScript, and CSS used by a website. We worked with them in section 6 on the Blog project, where we added custom CSS. For local usage, as long as `DEBUG` is set to `True` in `settings.py`, the files are served automatically by the `runserver` command.

Django automatically looks for static files within each app in a folder called `static`, but a common technique is to place all static files in a project-level folder called `static` instead. We’ll do that here. Quit the local server with `Control+c` and create a new `static` directory in the same folder as the `manage.py` file. Add new folders within it for `css`, `js`, and `img` on the command line.

```bash
mkdir static
mkdir static/css
mkdir static/js
mkdir static/img
```

A quirk of Git is that it will not track empty folders. If no files are within a folder, Git ignores it by default. One solution–which we will adopt here–is to add a `.keep` file to the three subfolders with your text editor:

- `static/css/.keep`
- `static/js/.keep`
- `static/img/.keep`

For local usage, only two settings are required for static files: `STATIC_URL`, which is the base URL for serving static files, and `STATICFILES_DIRS`, which defines the additional locations the built-in `staticfiles` app will traverse looking for static files beyond an `app/static` folder.

```python
# django_project/settings.py
STATIC_URL = "static/"
STATICFILES_DIRS =

 [BASE_DIR / "static"] # new
```

### Production Usage

Our local Django server is not designed to host static files in production. A best practice is to bundle all the static files into a single directory and then have the production web server, not the Django server, serve them. Django has a management command, `collectstatic`, for just this purpose: it copies all static files into a single location for deployment. The one configuration required of us is setting `STATIC_ROOT` to define the location of compiled static files. By convention, we will create a new project-level directory called `staticfiles`.

```python
# django_project/settings.py
STATIC_URL = "static/"
STATICFILES_DIRS = [BASE_DIR / "static"]
STATIC_ROOT = BASE_DIR / "staticfiles" # new
```

Now run the command `python manage.py collectstatic` to compile all static files into the `staticfiles` folder.

```bash
python manage.py collectstatic
```

The only static files right now are contained within the built-in admin app, so a new `staticfiles` directory should appear with sections for the admin. When additional static files are added in the future, they will also be compiled in this directory.

```bash
# staticfiles/
└── admin
    ├── css
    ├── img
    └── js
```

We need to use the `{% load static %}` template tag to display static files in the templates. Add it now to the top of the `base.html` file.

```html
<!-- templates/base.html -->
{% load static %}
<!DOCTYPE html>
...
```

If we were deploying with a dedicated server or VPS, it would be up to us to write code for the web server, likely Nginx or Apache, to serve static files. But since we are using the PaaS Heroku, we can leverage the popular [WhiteNoise](http://whitenoise.evans.io/en/stable/) third-party package optimized to serve static files from Django. It allows additional compression and immutable file storage and sets appropriate HTTP caching headers. In short, it makes our deployment process much more straightforward.

Install the latest version of WhiteNoise using pip.

```bash
pipenv  install whitenoise==6.7.0
```

Then, in the `django_project/settings.py` file, make three changes:

1. Add `whitenoise` to the `INSTALLED_APPS` above the built-in `staticfiles` app.
2. Under `MIDDLEWARE`, add a new `WhiteNoiseMiddleware` on the third line.
3. Change `STORAGES` to use WhiteNoise.

```python
# django_project/settings.py
INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "whitenoise.runserver_nostatic", # new
    "django.contrib.staticfiles",
    # 3rd Party
    "crispy_forms",
    "crispy_bootstrap5",
    # Local
    "accounts",
    "pages",
    "articles",
]

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "whitenoise.middleware.WhiteNoiseMiddleware", # new
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]
...
STATIC_URL = "static/"
STATICFILES_DIRS = [BASE_DIR / "static"]
STATIC_ROOT = BASE_DIR / "staticfiles"
STORAGES = {
    "default": {
        "BACKEND": "django.core.files.storage.FileSystemStorage",
    },
    "staticfiles": {
        "BACKEND": "whitenoise.storage.CompressedManifestStaticFilesStorage", # new
    },
}
```

`STORAGES` is a new setting in Django 4.2+ that defines how files are stored. It is implicitly set in `settings.py` but we are changing the `staticfiles` section to use WhiteNoise compression.

Run the `collectstatic` command again. The prompt will warn about overwriting existing files, but that is intentional: we want to compile them using WhiteNoise now. Type `yes` and press Return to continue:

```bash
python manage.py collectstatic
```

That’s it! We have configured our static files to be compiled in one place for production, added the static template tag to our `base.html` template, and installed WhiteNoise to efficiently serve them.

## Middleware

Adding WhiteNoise is the first time we’ve updated the Django middleware, a framework of hooks into Django’s request/response processing. It is a way to add functionality such as authentication, security, sessions, and more. During the HTTP request phase, middleware is applied in the order it is defined in `MIDDLEWARE` top-down. That means `SecurityMiddleware` comes first, then `SessionMiddleware`, and so on.

```python
# django_project/settings.py
MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "whitenoise.middleware.WhiteNoiseMiddleware", # new
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]
```

During the HTTP response phase, after the view is called, middleware are applied in reverse order, from the bottom up, starting with `XFrameOptionsMiddleware`, then `MessageMiddleware`, and so on. The traditional way of describing middleware is like an onion, where each middleware class is a “layer” that wraps the view.

Truly diving into middleware is an advanced topic beyond the scope of this section. It is important, however, to be conceptually aware of how all the pieces in the Django architecture fit together.

## Environment Variables

Real-world Django projects require at least two environments (local and production) but typically have more if multiple testing servers are involved. There are two ways to toggle between different environments in the same project: environment variables and multiple settings files. These days, the most popular approach is to use environment variables, which we will do here. An environment variable is a variable whose value is set outside the current program and can be loaded in at runtime. We can store these variables securely and load them into our Django project as needed.

There are multiple ways to work with environment variables, but for this project, we will use [environs](https://github.com/sloria/environs), a popular third-party package that comes with additional Django-specific features. Use pip to add `environs` and include the double quotes, `""`, to install the helpful Django extension.

**What are Environment Variables?**
- **Environment Variables** are special variables that store important information about your computer system or application. They are like small containers where you can keep specific values, such as passwords, database settings, or API keys, that your program needs to run.
- These variables are **set outside of your program** and can be accessed by your program when it is running.

**Purpose of Environment Variables**
- **Security:** Environment variables help keep sensitive information like passwords and API keys safe. Instead of hard-coding these values directly into your code (which can be risky), you can store them in environment variables.
- **Flexibility:** They make your application more flexible because you can easily switch between different settings (like development, testing, or production) without changing your code. You simply change the environment variables.
- **Configuration:** By using environment variables, you can configure how your application behaves in different environments (like on your local computer or on a live server).

### Real-World Usage in Django Projects

In real-world Django projects, you often need to manage different settings depending on where your project is running. For example:
- **Local Environment:** When you are developing on your own computer.
- **Production Environment:** When your website is live and accessible to users.
- **Testing Environments:** If you have separate servers for testing new features before making them public.

Instead of hard-coding different settings for each environment directly into your code, which can be messy and insecure, you can use environment variables. This way, you can easily toggle between environments by changing the values of these variables.

**Example with `environs` Package:**
- In this project, you'll use a Python package called `environs` to manage environment variables. This package allows you to load and manage environment variables easily in Django, and it even includes some extra features specific to Django projects.
- 
```bash
pipenv install "environs[django]"==11.0.0
```

Then, add three new lines to the top of the `django_project/settings.py` file.

```python
# django_project/settings.py
from environs import Env # new
env = Env() # new
env.read_env() # new
```
#### 2. **`from environs import Env`**
   - This line imports the `Env` class from the `environs` package.
   - `environs` is a third-party package that helps you manage environment variables easily. It provides a simple way to load and access these variables in your Django project.

#### 3. **`env = Env()`**
   - Here, you create an instance of the `Env` class called `env`.
   - This instance will be used to interact with environment variables throughout your Django project.

#### 4. **`env.read_env()`**
   - This line tells the `env` instance to read environment variables from a file (usually a `.env` file) and load them into the project's environment.
   - A `.env` file typically contains key-value pairs like `DEBUG=True` or `DATABASE_URL=postgres://...`, which are then made available to your project through the `env` instance.

Next, create a new file, `.env`, in the root project directory, containing our environment variables. We already know that any file or directory starting with a period will be treated as a hidden file and not displayed by default during a directory listing. The file still exists, though, and needs to be added to the `.gitignore` file to avoid being added to our Git source control.

```text
Pipfile
Pipfile.lock
__pycache__/
db.sqlite3
.env # new!
```

### DEBUG and ALLOWED_HOSTS

The first setting we will configure with environment variables is `DEBUG`. By default, `DEBUG` is set to `True`, which is helpful for local development but a major security issue if deployed into production. For example, if you start up the local server with `python manage.py runserver` and navigate to a page that does not exist, like `http://127.0.0.1:8000/debug`, you will see the following:

This page lists all the URLs tried and apps loaded, a treasure map for any hacker attempting to break into your site. You’ll even see that at the bottom of the error page, it says that Django will display a standard 404 page if `DEBUG=False`. That’s what we want! The first step is to change `DEBUG` to `False` in the `settings.py` file.

```python
# django_project/settings.py
DEBUG = False
```

Refresh the web page `http://127.0.0.1:8000/debug`, and you’ll see an error: the site doesn’t load at all. On the command line, Django has provided us with the explanation via [CommandError](https://docs.djangoproject.com/en/5.0/howto/custom-management-commands/#django.core.management.CommandError), which is raised for serious problems.

```bash
python manage.py runserver
...
CommandError: You must set settings.ALLOWED_HOSTS if DEBUG is False.
```

In this case, Django is telling us that we can’t set `DEBUG` to `False` if we have not set `ALLOWED_HOSTS`. So what is `ALLOWED_HOSTS`? It is a list of strings representing host/domain names that our Django site can serve. By default, `ALLOWED_HOSTS` is set to accept all hosts, which is

 not secure! We must update it to accept local ports (`localhost` and `127.0.0.1`) and `.herokuapp.com` for our Heroku deployment. We can add all three routes to our config.

```python
# django_project/settings.py
ALLOWED_HOSTS = [".herokuapp.com", "localhost", "127.0.0.1"] # new
```

Now that we’ve set `ALLOWED_HOSTS`, try the `runserver` command again.

This is the generic Django 404 page that we want displayed in production. It does not give away any information to a potential hacker.

Manually setting configurations for development and production environments is not ideal. For one thing, it is a major pain and easy to make a mistake. For another, it is insecure if we put production information that should be secret into `settings.py` and perform a Git commit by mistake.

This is where environment variables come to the rescue. To add any environment variable to our project, we first add it to the `.env` file and then update `django_project/settings.py`.

Within the `.env` file, create a new environment variable called `DEBUG` and set its value to `True`.

```text
# .env
DEBUG=True
```

Then in `django_project/settings.py`, change the `DEBUG` setting to read the variable `DEBUG` from the `.env` file.

```python
# django_project/settings.py
DEBUG = env.bool("DEBUG", default=False)
```

The syntax of `env.bool` says to load an environment variable from the `.env` file that is a Boolean, meaning `True` or `False`, with the name `DEBUG`. If an environment variable can’t be found, then the default value, set here to `False`, will be used. It is a best practice to default to production settings since they are more secure, and if something goes wrong in our code, we won’t default to exposing all our secrets.

### SECRET_KEY and CSRF_TRUSTED_ORIGINS

`SECRET_KEY`, a random 50-character string generated each time `startproject` is run. This string provides cryptographic protection throughout our Django project. In the settings file, you’ll see the current value that begins with `django-insecure`. Here is the `django_project/settings.py` value of the `SECRET_KEY` in my project. Yours will be different.

```python
# django_project/settings.py
SECRET_KEY = "django-insecure-3$k(g9eheqqbzr@#&tt)r6%ab-g1=!j@2c^y7*sl6+ltzys05!"
```

And here it is, without the double quotes, in the `.env` file.

```text
# .env
DEBUG=True
SECRET_KEY=django-insecure-3$k(g9eheqqbzr@#&tt)r6%ab-g1=!j@2c^y7*sl6+ltzys05! # new
```

Update `django_project/settings.py` so that `SECRET_KEY` points to this new environment variable. It is a string so the syntax is `env.str`.

```python
# django_project/settings.py
SECRET_KEY = env.str("SECRET_KEY")
```

The `SECRET_KEY` is out of the `settings.py` file and safe now, right? Actually no! Because we made previous Git commits that included the value, it is stored in our Git history no matter what we do. The solution is to create a new `SECRET_KEY` and add it to the `.env` file. One way to generate a new one is by invoking Python’s built-in [secrets](https://docs.python.org/3/library/secrets.html) module by running `python -c 'import secrets; print(secrets.token_urlsafe())'` on the command line.

Copy and paste this new value into the `.env` file.

```text
# .env
DEBUG=True
SECRET_KEY=imDnfLXy-8Y-YozfJmP2Rw_81YA_qx1XKl5FeY0mXyY
```

Now restart the local server with `python manage.py runserver` and refresh your website. It will work with the new `SECRET_KEY` loaded from the `.env` file but not tracked by Git since `.env` is in the `.gitignore` file.

Our Newspaper project requires that we log into the admin on the production website to create, read, update, or delete posts. That means [CSRF_TRUSTED_ORIGINS](https://docs.djangoproject.com/en/5.0/ref/settings/#csrf-trusted-origins) must be correctly configured since it is a list of trusted origins for unsafe HTTP requests like POST. Add it to the bottom of the `settings.py` file and set it to match a production URL on Heroku, `https://*.herokuapp.com`. We will update both `ALLOWED_HOSTS` and `CSRF_TRUSTED_ORIGINS` to match our production URL at the end of the section.

```python
# django_project/settings.py
CSRF_TRUSTED_ORIGINS = ["https://*.herokuapp.com"] # new
```

## DATABASES

We want to use SQLite locally but PostgreSQL in production. Currently, our settings file for `DATABASES` lists only SQLite. The `ENGINE` specifies what type of database to use, and the `NAME` points to its location.

```python
# django_project/settings.py
DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.sqlite3",
    }
}
```

Most PaaS will automatically set a `DATABASE_URL` environment variable inspired by the [Twelve-Factor App](https://12factor.net/) approach that contains all the parameters needed to connect to a database in the format. In raw form, for PostgreSQL, it looks something like this:

```text
postgres://USER:PASSWORD@HOST:PORT/NAME
```

In other words, use `postgres` and here are custom values for `USER`, `PASSWORD`, `HOST`, `PORT/NAME`. While we could manage this manually ourselves, this pattern is so well established in the Django community that a dedicated third-party package, [dj-database-url](https://github.com/jazzband/dj-database-url), exists to manage this for us. Conveniently, `dj-database-url` is already installed since it is one of the helper packages added by `environs[django]`.

This means we can solve all these problems with a single line of code. Here is the brief update to make to `django_project/settings.py` so that our project will try to access a `DATABASE_URL` environment variable.

```python
# django_project/settings.py
DATABASES = {"default": env.dj_db_url("DATABASE_URL")}
```

We will also set a `DATABASE_URL` environment variable in the `.env` file for local development.

```text
# .env
DEBUG=True
SECRET_KEY=imDnfLXy-8Y-YozfJmP2Rw_81YA_qx1XKl5FeY0mXyY
DATABASE_URL=sqlite:///db.sqlite3
```

Let’s review what’s happening here because it can be confusing initially. For local development, our project will try to find a `.env` file with environment variables. It will use them if it finds them, which is why they are the local defaults.

In production, we have included the `.env` file in our `.gitignore` file so Heroku won’t know about them unless we set the environment variables manually. Heroku will automatically create a `DATABASE_URL` environment variable with the configuration for our production database, so that will be used.

We also need to install [Psycopg](https://www.psycopg.org/docs/), a database adapter that lets Python apps like ours talk to PostgreSQL databases. You can install it with pip on Windows, but if you are on macOS, you must install PostgreSQL first via [Homebrew](https://brew.sh/).

```bash
# Windows
python -m pip install "psycopg[binary]"==3.2.1
# macOS
brew install postgresql
python3 -m pip install "psycopg[binary]"==3.2.1
```

We are using the [binary version](https://www.psycopg.org/psycopg3/docs/basic/install.html#binary-installation) because it is the quickest way to start working with Psycopg.

## Gunicorn and Procfile

Since Django’s default development server, `runserver`, is explicitly not designed for production, we must select a production-ready WSGI server to use. [Gunicorn](http://gunicorn.org/) is one of the most popular and easiest-to-configure options. It can handle multiple requests simultaneously while being scalable, stable, reliable, and compatible with production web servers.

Install Gunicorn with pip. Since we are using a PaaS, no additional configuration steps are required.

```bash
python -m pip install gunicorn==22.0.0
```

Heroku relies on a proprietary `Procfile` file that provides instructions on running applications in their stack. In your text editor, create a new file called `Procfile` in the base directory. We only need a single line of configuration for our project, telling Heroku to use Gunicorn as the WSGI server,

 the location of the WSGI config file at `django_project.wsgi`, and finally, the flag `--log-file -` makes any logging messages visible to us.

```text
web: gunicorn django_project.wsgi --log-file -
```

## requirements.txt

We’re almost at the end of implementing the deployment checklist. The last step before deploying to Heroku is to update the `requirements.txt` file. After all, for deployment, we have installed the following new packages: WhiteNoise, Environs, Psycopg, and Gunicorn.

Use the command `pip freeze` and the `>` operator to output our virtual environment information into a `requirements.txt` file.

```bash
pip freeze > requirements.txt
```

The `requirements.txt` file will appear in the root directory containing all our installed packages and their dependencies. My list as of the writing of this section looks as follows:

```text
# requirements.txt
asgiref==3.8.1
black==24.4.2
click==8.1.7
crispy-bootstrap5==2024.2
dj-database-url==2.2.0
dj-email-url==1.0.6
Django==5.0.6
django-cache-url==3.4.5
django-crispy-forms==2.2
environs==11.0.0
gunicorn==22.0.0
marshmallow==3.21.3
mypy-extensions==1.0.0
packaging==24.1
pathspec==0.12.1
platformdirs==4.2.2
psycopg==3.2.1
psycopg-binary==3.2.1
python-dotenv==1.0.1
sqlparse==0.5.0
typing_extensions==4.12.2
whitenoise==6.7.0
```

We can use `git status` to check our changes, add the new files, and commit them. We can also push to GitHub for an online backup of our code changes.

```bash
git status
git add -A
git commit -m "New updates for Heroku deployment"
git push -u origin main
```

## Heroku Setup

### Heroku Pricing

Before 2022, Heroku had a generous free tier, but unfortunately, that is not the case anymore. It costs a company real money to spin up virtual servers on your behalf, and as a result, few hosting companies offer a free tier anymore.

[Heroku pricing](https://www.heroku.com/pricing) involves multiple tiers of features and bills per hour with a maximum monthly limit. The deployment setup we will implement here costs $12/month if left on all the time, but if you are cost-conscious and deploying for purely educational purposes, there is no reason to leave your website “live” all the time. You can deploy the site, share it, and then take it down after a few days and the total cost should only be $1-$2.

### Account Setup

Sign up for a Heroku account on their website. Fill in the registration form and await an email with a link to confirm your account. This will take you to the password setup page. Once configured, you will be directed to the dashboard section of the site. Heroku now requires enrolling in multi-factor authentication (MFA), which can be done with SalesForce or a tool like Google Authenticator. Heroku now requires adding a credit card for account verification and payment.

### Install Heroku CLI

Once you are signed up, it is time to install Heroku’s Command Line Interface (CLI) so we can deploy from the command line. Currently, we are operating within a local virtual environment for the Newspaper project. We want to install Heroku globally so it is available for all projects. An easy way to do this is by opening a new command line tab–`Control+t` on Windows or `Command+t` on a Mac–that is not currently operating in a virtual environment. Anything installed here will be global.

On Windows, see the [Heroku CLI page](https://devcenter.heroku.com/articles/heroku-cli#download-and-install) to install the 32-bit or 64-bit version correctly. On a Mac, the package manager [Homebrew](https://brew.sh/) is used for installation. If not already on your machine, install Homebrew by copying and pasting the long command on the Homebrew website into your command line and hitting Return. It will look something like this:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Next, install the Heroku CLI by copying and pasting the following into your command line and hitting Return.

```bash
brew tap heroku/brew && brew install heroku
```

Once installation is complete, you can close the new command line tab and return to the initial tab with the newspaper virtual environment active.

### Heroku Login

Type the command `heroku login` and press enter. Then press any key to open up a browser window, where you can log in with your email, password, and two-factor authentication you just set.

```bash
> heroku login
heroku: Press any key to open up the browser to login or q to exit:
Opening browser to https://cli-auth.heroku.com/auth/cli/browser/....
```

Once you are logged in, we are ready to go!

## Deploy with Heroku

There are two ways to interact with Heroku: via its CLI (Command Line Interface) or the website. The CLI is much faster, which we will use here, but the website’s more visual nature is helpful if you are new to Heroku.

### Step 1: Create a Heroku App

Create a new Heroku app from the command line with `heroku create`. Heroku will create a random name for our app, in my case, `fathomless-hamlet-26076`. Your name will be different.

```bash
heroku create
Creating app... done,  afternoon-wave-82807
https://afternoon-wave-82807-b672795cd97e.herokuapp.com/
https://git.heroku.com/afternoon-wave-82807.git
```

The `heroku create` command also creates a dedicated Git remote named `heroku` for our app. To see this, type `git remote -v`.

```bash
git remote -v
heroku https://git.heroku.com/afternoon-wave-82807.git (fetch)
heroku https://git.heroku.com/afternoon-wave-82807.git (push)
```

### Step 2: Create a PostgreSQL Database

The next step is creating a PostgreSQL database on Heroku. There are various Postgres tiers available for different use cases. The five plan tiers are Essential, Standard, Premium, Private, and Shield. The more you pay, the less downtime is tolerated. For our use case, the lowest tier, Essential, is more than adequate. Run the following command to create a new Essential Postgres database for our project.

```bash
heroku addons:create heroku-postgresql:essential-0
Creating heroku-postgresql:essential-0 on  afternoon-wave-82807...
~$0.007/hour (max $5/month)
Database should be available soon
postgresql-sinuous-77120 is being created in the background. The app will restart when complete...
Use heroku addons:info postgresql-sinuous-77120 to check creation progress
Use heroku addons:docs heroku-postgresql to view documentation
```

The database might require a moment to provision, in which case you can wait a few minutes and then run the command to “check creation progress.” Make sure the database name matches your project.

```bash
heroku addons:info postgresql-sinuous-77120
=== postgresql-sinuous-77120
Attachments: afternoon-wave-82807::DATABASE
Installed at: Tue Jul 02 2024 10:57:17 GMT-0400 (Eastern Daylight Time)
Max Price: $5/month
Owning app: afternoon-wave-82807
Plan: heroku-postgresql:essential-0
Price: ~$0.007/hour
State: created
```

If you run `heroku config`, it will show all configuration variables set on Heroku. At the moment, that is just a `DATABASE_URL` with the information to connect to the production Postgres database.

```bash
heroku config
=== afternoon-wave-82807 Config Vars
DATABASE_URL: postgres://u1k...us-east-1.rds.amazonaws.com:5432/d11ac0v0inabta
```

Select your project on the Heroku website dashboard and click “Settings” in the navigation bar. Under “Config Vars,” you can see that the `DATABASE_URL` has been set.

![Heroku Dashboard Configs](https://raw.githubusercontent.com/HashimThePassionate/ultimate-mysql-bootcamp/main/images/heroku-config.png)

### Step 3: Set Environment Variables

There are two other items in our local `.env` file, `DEBUG` and `SECRET_KEY`. We need to manually set both on Heroku, either in the web interface or the command line. First up is `DEBUG`, which should be `False`.

```bash
heroku config:set DEBUG=False
Setting DEBUG and restarting  afternoon-wave-82807... done, v6


DEBUG: False
```

Next is the `SECRET_KEY`. Make sure to wrap it in quotations, `""`, if you do so via the command line.

```bash
heroku config:set SECRET_KEY="SECRET_KEY=imDnfLXy-8Y-YozfJmP2Rw_81YA_qx1XKl5FeY0mXyY"
Setting SECRET_KEY and restarting  afternoon-wave-82807... done, v7
SECRET_KEY: SECRET_KEY=imDnfLXy-8Y-YozfJmP2Rw_81YA_qx1XKl5FeY0mXyY
```

It’s a good idea to double-check that the production environment variables are properly set. From the command line, that means using the `heroku config` command.

```bash
heroku config
=== afternoon-wave-82807 Config Vars
DATABASE_URL: postgres://u1k...us-east-1.rds.amazonaws.com:5432/d11ac0v0inabta
DEBUG: False
SECRET_KEY: SECRET_KEY=imDnfLXy-8Y-YozfJmP2Rw_81YA_qx1XKl5FeY0mXyY
```

You can also look at the web dashboard:

![Heroku Dashboard Updated Configs](https://raw.githubusercontent.com/HashimThePassionate/ultimate-mysql-bootcamp/main/images/heroku-config-updated.png)

### Step 4: Push Code to Heroku

Now it is time to push our code up to Heroku with the command, `git push heroku main`. If we had just typed `git push origin main`, the code would have been pushed to GitHub, not Heroku. Adding `heroku` to the command sends the code to Heroku.

```bash
git push heroku main
Enumerating objects: 339, done.
Counting objects: 100% (339/339), done.
Delta compression using up to 10 threads
Compressing objects: 100% (333/333), done.
Writing objects: 100% (339/339), 798.15 KiB | 14.25 MiB/s, done.
Total 339 (delta 39), reused 0 (delta 0), pack-reused 0 (from 0)
remote: Resolving deltas: 100% (39/39), done.
remote: Updated 569 paths from 2ebafa9
remote: Compressing source files... done.
remote: Building source:
remote:
remote: -----> Building on the Heroku-22 stack
...
remote: https://afternoon-wave-82807-b672795cd97e.herokuapp.com/
deployed to Heroku
remote:
remote: Verifying deploy... done.
To https://git.heroku.com/afternoon-wave-82807.git
* [new branch] main -> main
```

This command generates a lot of output from Heroku and might take a while the first time. We are pushing the code to Heroku, and it is rebuilding a production version of our Django project on its servers. You’ll see that it installs each item from our `requirements.txt` file, among other actions.

### Step 5: Start a Dyno

The last step is starting a Dyno, Heroku’s term for our app’s lightweight container. We need at least one to be running to make our website live. If we start to see a spike in traffic, we could add more dynos to our project, and Heroku will handle all the infrastructure. For a small project like this, I recommend the Basic Dyno, which is $0.01 per hour with a maximum of $7 per month.

We will spin up one dyno using the Heroku CLI, but dynos can also be managed via the web interface. The general syntax for the CLI is to start with `heroku`, `ps` is a command that prefixes many commands affecting dynos, `ps:scale` is used to increase the number of dynos running a process. Therefore, the command below tells Heroku to run one dyno for our website.

```bash
heroku ps:scale web=1
Scaling dynos... done, now running web at 1:Basic
```

The total cost for our project–if we let it run all the time–is $12 per month: $5/month for the Postgres database and $7/month for the Dyno. Heroku bills per hour so you can always deploy the website and take it down after a few days, which should cost only cents.

### Step 6: Open the Deployed App

We’re done! The last step is to confirm our app is live and online. If you use the command `heroku open`, your web browser will open a new tab with the URL of your app:

```bash
heroku open
```

![Production Homepage](https://raw.githubusercontent.com/HashimThePassionate/ultimate-mysql-bootcamp/main/images/prod-home.png)

The Newspaper website is live, but you’ll quickly see some problems if you try it out. For one thing, there are no articles or comments! That’s because we still need to configure the production PostgreSQL database running on Heroku. Let’s do that now.

### Step 7: Migrate the Database

To run Django commands on Heroku instead of locally, we use the prefix `heroku run`. So to migrate our database with initial settings, we run the following command:

```bash
heroku run python manage.py migrate
Running python manage.py migrate on  afternoon-wave-82807... up, run.2790 (Basic)
Operations to perform:
Apply all migrations: accounts, admin, articles, auth, contenttypes, sessions
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
Applying articles.0001_initial... OK
Applying articles.0002_comment... OK
Applying sessions.0001_initial... OK
```

### Step 8: Create a Superuser

Now, create a superuser account to access the admin.

```bash
heroku run python manage.py createsuperuser
Running python manage.py createsuperuser on  afternoon-wave-82807... up, run.7422 (Basic)
Username: wsv
Email address: will@learndjango.com
Password:
Password (again):
Superuser created successfully.
```

Navigate to the admin section of your deployed website, log in with your superuser credentials, and add some articles and comments.

![Production Admin Dashboard](https://raw.githubusercontent.com/HashimThePassionate/ultimate-mysql-bootcamp/main/images/prod-admin.png)

They will then be displayed on the live website. You can also create user accounts and confirm that the user authentication flow works correctly by resetting your password.

### Updating the Production Website

For future updates to the production website, the pattern is as follows:

- Make local code changes and save them with Git.
- Use `git push origin main` to deploy them to GitHub.
- Use `git push heroku main` to push the code to Heroku.

### Removing the Hosted Website

If you want to remove a hosted website, log into your [Heroku dashboard](https://dashboard.heroku.com/apps) and click on the app name. Click on the Settings link in the navigation bar at the top, then scroll down to the bottom of the page under Delete App and click the “Delete App…” button. You will be asked to type in your full app name one more time to confirm that you want to permanently delete it.

![Heroku Delete App](https://raw.githubusercontent.com/HashimThePassionate/ultimate-mysql-bootcamp/main/images/heroku-delete.png)

Another tip is that you can type `Ctrl + d` to exit the Heroku CLI at any time.

## Additional Security Steps

There is an almost infinite list of additional security procedures to secure a production website. Our production checklist covers the basics, but there are more if you want to take the additional steps.

First, update `ALLOWED_HOSTS` and `CSRF_TRUSTED_ORIGINS` to use the exact production URL for your project.

Next, you would run Django’s management command, which runs several [automated checks](https://docs.djangoproject.com/en/5.0/howto/deployment/checklist/#run-manage-py-check-deploy) around deployment. To run that command you would prefix `heroku run` so it would be `heroku run python manage.py check --deploy`. You now know how to reference the Django docs and update your local and production environment variables to make them pass.



## Conclusion

We just covered a lot of new material, so you will likely feel overwhelmed. That’s normal. There are many steps involved in configuring a website for proper deployment, and the good news is that this same list of production settings will hold true for almost every Django project. Don’t worry about memorizing all the steps; use the deployment checklist!

The other big stumbling block for newcomers is becoming comfortable with the difference between local and production environments. You will likely forget to push code changes into production and spend minutes or hours wondering why the change isn’t live on your site. Or even worse, you’ll change your local SQLite database and expect them to magically appear in the production PostgreSQL database. It’s part of the learning process, but Django makes it much smoother than it otherwise would be. You know enough to confidently deploy any Django project online with a PaaS.