# Blog Website

In this section, we will begin building a Blog application that allows users to read, create, edit, and delete posts. This functionality, CRUD (Create-Read-Update-Delete), is the dominant pattern for most websites. If you think about Facebook, Instagram, or Reddit, all you do is read posts and sometimes create, edit, or delete them. That’s what we’ll implement here with a blog app with a homepage listing all posts and an individual page for each post. We’ll also introduce CSS for styling, learn about static files, and write more advanced tests to ensure everything works as expected.

## Initial Setup

The setup for this project is similar to past examples in this section:

- Make a new directory for our code called `blog`
- Install Django in a new virtual environment using pipenv
- Create a new Django project called `django_project`
- Create a new app `blog`
- Perform a migration to set up the database
- Update `django_project/settings.py`

### Commands

Let's implement them now in a new command line terminal. Start with the new directory, add a new virtual environment, and activate it.

**Windows:**

```sh
cd onedrive\desktop\code
mkdir blog
cd blog
python -m pipenv install django~=5.0.0
pipenv shell
```

**macOS:**

```sh
cd ~/desktop/code
mkdir blog
cd blog
python3 -m pipenv install django~=5.0.0
pipenv shell
```

Then, install Django and Black, create a new project called `django_project`, create a new app called `blog`, and migrate the initial database.

```sh
pipenv install black
django-admin startproject django_project .
python manage.py startapp blog
python manage.py migrate
```

### Updating `settings.py`

To ensure Django knows about our new app, open your text editor and add the new app to `INSTALLED_APPS` in the `django_project/settings.py` file:

```python
# django_project/settings.py

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'blog',  # new
]
```

Spin up the local server using the `runserver` command.

```sh
python manage.py runserver
```

You should see the friendly Django welcome page if you navigate to `http://127.0.0.1:8000/` in your web browser.

The initial installation is complete! Next, we’ll learn more about databases and Django’s ORM, then create our database models for a blog application.

## Blog Post Models

Before we write the code for our Django model, let’s take a moment to visualize how we want the information in our database to be structured. In our previous example, the Message Board app, we only had a single field for content. Here, we want a database table called `Post` with three fields: Title, Author, and Body. The actual database table with columns and rows should look like this:

### Post Database Table

| TITLE          | AUTHOR | BODY                                       |
|----------------|--------|--------------------------------------------|
| Hello, World!  | Hashim | My first blog post. Woohoo!                |
| Goals Today    | Hashim | Learn Django and build a blog application. |
| 3rd Post       | Hashim | This is my 3rd entry.                      |

Remember that the `models.py` file is the single, definitive source of information about our data, containing the necessary fields and behaviors of the stored data. We can write Python in a `models.py` file, and the Django ORM will translate it into SQL. Write the following code in the `blog/models.py` file.

```python
# blog/models.py

from django.db import models

class Post(models.Model):
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=200)
    body = models.TextField()

    def __str__(self):
        return self.title
```

At the top of the file, we import the `models` module and then create a class, `Post`, that extends it. The `Post` class has three fields (think of them as columns) for title, author, and body. Each field must have an appropriate [field type](https://docs.djangoproject.com/en/5.0/ref/models/fields/#field-types). The first two use `CharField`, meaning a Character Field with a maximum character length of 200, while the third uses `TextField`, intended for a large amount of text.

Adding the `__str__` method is technically optional, but as we saw in the last section, it is a best practice to ensure a human-readable version of our model object in the Django admin. In this case, it will display the title field of any blog post.

Now that our new database model exists, we need to create a new migration file and migrate the change to apply it to our database. Stop the server with Control+c. You can complete this two-step process with the commands below:

```sh
python manage.py makemigrations blog
python manage.py migrate
```

The database is now configured, and a new migrations directory containing our changes exists within the blog app directory.

If you want to see what type of migration ORM send to database engine, use this command with the version of migration file, in our case this is our first migration so we can use `0001` with app name. you can specify according to your migrations file version.

```sh
python manage.py sqlmigrate blog 0001
```

`Output`
```sh
BEGIN;
--
-- Create model Post
--
CREATE TABLE "blog_post" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "title" varchar(200) NOT NULL, "author" varchar(200) NOT NULL, "body" text NOT NULL);
COMMIT;
```


## Primary Keys and Foreign Keys

We could hop over to the Django admin and add data to our blog post model. However, two more important concepts—primary and foreign keys—must be covered before building the rest of the Blog app.

Because relational databases have relationships between tables, there needs to be an easy way for them to communicate. The solution is adding a column–known as a primary key that contains unique values. When there is a relationship between two tables, the primary key is the link, maintaining a consistent relationship. If we look back at our simple Post schema, it should, therefore, include another field for “Primary Key”:

### Post Schema

| primary_key | title         | author | body                                       |
|-------------|---------------|--------|--------------------------------------------|
| 1           | Hello, World! | Hashim | My first blog post. Woohoo!                |
| 2           | Goals Today   | Hashim | Learn Django and build a blog application. |
| 3           | 3rd Post      | Hashim | This is my 3rd entry.                      |

Primary keys are a standard part of relational database design. As a result, Django automatically adds an auto-incrementing primary key to our database models. Its value starts at 1 and increases sequentially to 2, 3, and so on. The naming convention is `id`, meaning that for a Post model, the primary key column is named `id`.

As a result, under the hood, our existing Post database table has four columns/fields.

### Post Database Table

| ID        | TITLE         | AUTHOR | BODY                                        |
|-----------|---------------|--------|---------------------------------------------|
| 1         | Hello, World! | Hashim | My first blog post. Woohoo!                 |
| 2         | Goals Today   | Hashim | Learn Django and build a blog application.  |
| 3         | 3rd Post      | Hashim | This is my 3rd entry.                       |

Now that we know about primary keys, it’s time to see how they are used to link tables. With more than one table, each will contain a column of primary keys starting with 1 and increasing sequentially, just like in our Post model example. In our blog model, consider that we have a field for author, but in the actual Blog app, we want users to be able to log in and create blog posts. That means we’ll need a second table for users to link to our existing table for blog posts. Fortunately, authentication is a common–and challenging to implement well–feature on websites that Django has an entire built-in [authentication system](https://docs.djangoproject.com/en/5.0/ref/contrib/auth/) that we can use. In a later section, we will use it to add signup, login, logout, password reset, and other functionality. But for now, we can use the Django [auth user model](https://docs.djangoproject.com/en/5.0/ref/contrib/auth/#fields), which comes with various fields. If we visualized the schema of our Post and User models now, it would look like this:

### Post and User Schema

| Post     | User         |
|----------|------------------|
| id       | id               |
| title    | username         |
| author   | first_name       |
| body     | last_name        |
|          | email            |
|          | password         |
|          | groups           |
|          | user_permissions |
|          | is_staff         |
|          | is_active        |
|          | is_superuser     |
|          | last_login       |
|          | date_joined      |

How do we link these two tables together so they have a relationship? We want the author field in Post to link to the User model so that each post has an author corresponding to a user. We can do this by linking the User model primary key, `id`, to the `Post.author` field. A link like this is known as a foreign key relationship. Foreign keys in one table always correspond to the primary keys of a different table. So, establishing a foreign key relationship for authors and users in our blog app means that the author fields of the Post model will have the primary key of the corresponding user in the User model who authored that specific post. In our example, `hashim`, whose primary key in the User model is 1, authored all three of the posts, so that same primary key, 1, is listed as the foreign key in the Author column for each of the three posts in our Post model.

Here is how it looks in the code. We only need to change the author field in our Post model.

```python
# blog/models.py
from django.db import models

class Post(models.Model):
    title = models.CharField(max_length=200)
    author = models.ForeignKey(
        "auth.User",
        on_delete=models.CASCADE,
    )  # new
    body = models.TextField()

    def __str__(self):
        return self.title
```

The [`ForeignKey`](https://docs.djangoproject.com/en/5.0/ref/models/fields/#django.db.models.ForeignKey) field defaults to a many-to-one relationship, meaning one user can be the author of many different blog posts but not the other way around.

It is worth mentioning that there are three types of foreign relationships: many-to-one, many-to-many, and one-to-one. A many-to-one relationship, as we have in our Post model, is the most common occurrence. A many-to-many relationship would exist if there were a database tracking authors and books: each author can write multiple books, and each book can have multiple authors. A one-to-one relationship would exist in a database tracking people and passports: only one person can have one passport.

Note that when an object referenced by a `ForeignKey` is deleted, an additional `on_delete` argument must be set. Understanding `on_delete` fully is an advanced topic, but choosing `CASCADE` is typically safe, as we do here.

Since we have updated our database models again, we should create a new migrations file and then migrate the database to apply it.

```sh
python manage.py makemigrations blog
python manage.py migrate
```

A second migrations file will now appear in the `blog/migrations` directory that documents this change.

## Admin

We need a way to access our data: enter the Django admin! First, create a superuser account by typing the command below and following the prompts to set up an email and password. Note that typing your password will not appear on the screen for security reasons.

```sh
python manage.py createsuperuser
```

Example:

```sh
Username (leave blank to use 'muhammadhashim'): hashim
Email: xyz@gmail.com
Password:
Password (again):
Superuser created successfully.
```

Now rerun the Django server with the command `python manage.py runserver` and navigate to the admin at `127.0.0.1:8000/admin/`. Log in with your new superuser account.

Oops! Where’s our new Post model? We forgot to update `blog/admin.py`, so let’s do that now.

```python
# blog/admin.py

from django.contrib import admin
from .models import Post

admin.site.register(Post)
```

If you refresh the page, you’ll see the update.

### Admin Homepage

Let’s add two blog posts so we have some sample data. Click the + Add button next to Posts to create a new entry. Make sure to add an “author” to each post, too, since all model fields are required by default.

You will see an error if you try to enter a post without an author. To change this, we could add field options to our model to make a given field optional or default to a specified value.

Although our model has three fields, the Django admin defaults to displaying whatever is in the `__str__` method in the list view. In our case, that is the title field. However, it is quite straightforward to customize the admin further to display all three fields.

To do this, we can extend `ModelAdmin` by creating a new class, `PostAdmin`. Within it, we can set `list_display` to control what is shown on the admin change list page. We also must register both the model, `Post`, and the extended `ModelAdmin` class we’ve created, `PostAdmin`, at the bottom of the file.

```python
# blog/admin.py

from django.contrib import admin
from .models import Post

class PostAdmin(admin.ModelAdmin):  # new
    list_display = (
        "title",
        "author",
        "body",
    )

admin.site.register(Post, PostAdmin)  # new
```

All three model fields will be visible if you refresh the admin change list page.

Now that our database model is complete, we must create the necessary view, URL, and template to display the information in our web application.

## Views

Our view needs to list all available blog posts. We can write it as a function-based view; the code is identical to what we used in the last section for our Message Board. In web development, we are often performing similar tasks over and over again. This is what led to the development of generic class-based views!

```python
# blog/views.py

from django.shortcuts import render
from .models import Post

def post_list(request):
    posts = Post.objects.all()
    return render(request, 'home.html', {'posts': posts})
```

As a brief recap, we import the `render()` shortcut function and the `Post` model at the top of the file. Then we create a function, `post_list`. The first parameter is named `request` by convention and represents an instance of the `HttpRequest` object that triggered the view. Then, we set a variable, `posts`, equal to a `QuerySet` containing all `Post` objects in the database using the default model manager name of `objects` and the built-in `all()` method. Finally, we use `render` to return the request object, specify the template, and add a context dictionary named `posts` equal to the variable `posts` containing all Blog posts.

## URLs

We want to display our blog posts on the homepage, so we’ll first configure our app-level `blog/urls.py` file and then our project-level `django_project/urls.py` file to achieve this. In your text editor, create a new file called `urls.py` within the blog app and update it with the code below.

```python
# blog/urls.py

from django.urls import path
from .views import post_list

urlpatterns = [
    path("", post_list, name="home"),
]
```

At the top, we import the `path` module and our view, `post_list`. Then we set a single route at the empty string, "", which matches the route URL of our website. We pass in the view, `post_list`, as the second argument and then add an optional “home” name that will come in handy shortly in our template.

We also should update our `django_project/urls.py` file so that it knows to forward all requests directly to the blog app.

```python
# django_project/urls.py

from django.contrib import admin
from django.urls import path, include  # new

urlpatterns = [
    path("admin/", admin.site.urls),
    path("", include("blog.urls")),  # new
]
```

We’ve added `include` on the second line and a URL pattern using an empty string regular expression, "", indicating that URL requests should be redirected as is to blog’s URLs for further instructions.

## Templates

With our URLs and views now complete, we’re only missing the third piece of the puzzle: templates. Let’s use template inheritance to avoid repeating code, starting with a `base.html` file and a `home.html` file that inherits from it. Later, when we add templates for creating and editing blog posts, they can also be inherited from `base.html`.

Start by adding our new `templates` directory.

```sh
mkdir templates
```

Create two new templates in your text editor: `templates/base.html` and `templates/home.html`. Then update `django_project/settings.py` so Django knows to look there for our templates.

```python
# django_project/settings.py

TEMPLATES = [
    {
        ...
        "DIRS": [BASE_DIR / "templates"],  # new
        ...
    },
]
```

And update the `base.html` template as follows.

```html
<!-- templates/base.html -->
{% load static %}
<html>
<head>
    <title>Django blog</title>
    <link rel="stylesheet" href="{% static 'css/style.css' %}">
</head>
<body>
    <header>
        <h1><a href="{% url 'home' %}">Django blog</a></h1>
    </header>
    <div>
        {% block content %}
        {% endblock content %}
    </div>
</body>
</html>
```

The link to `url 'home'` means that we expect a URL with the name “home” to power our homepage. The code between `{% block content %}` and `{% endblock content %}` is designed to be filled by other templates. Speaking of which, here is the code for `home.html`.

```html
<!-- templates/home.html -->

{% extends "base.html" %}
{% block content %}
{% for post in posts %}
<div class="post-entry">
    <h2><a href="">{{ post.title }}</a></h2>
    <p>Author: {{ post.author }}</a>
    <p>{{ post.body }}</p>
</div>
{% endfor %}
{% endblock content %}
```

At the top, we note that this template extends `base.html` and then wraps our desired code with content blocks. We use the Django Templating Language to set up a simple for loop for each blog post. We are looping over the context dictionary `posts`, which we defined in our view, and naming each item as `post`. Then, we can use dot notation to display fields like `post.title`, `post.author`, and `post.body`.

If you start the Django server again with `python manage.py runserver` and refresh the homepage, we can see it is working.

## Static Files

Static files are the Django community’s term for additional files commonly served on websites, such as CSS, fonts, images, and JavaScript. Even though we haven’t added any to our project yet, we are already relying on core Django static files—custom CSS, fonts, images, and

 JavaScript—to power the look and feel of the Django admin.

In production, things are more complex, which we will cover properly in the deployment section of this section. The central concept to understand is that it is far more efficient to combine all static files across a Django project into a single location in production. If you look near the bottom of the existing `django_project/settings.py` file, there is already a configuration for `STATIC_URL`, which refers to the URL location of all static files in production. In other words, if our website had the URL example.com, all static files would be available in example.com/static.

```python
# django_project/settings.py

STATIC_URL = "static/"
```

For local development, we don’t have to worry about static files because the web server–run via the `runserver` command–will automatically find and serve them for us.

The first question when adding a new static file is where to place it. By default, Django will look within each app for a folder called “static”; in other words, a folder called `blog/static/`. If you recall, this is similar to how templates are treated.

As Django projects grow in complexity over time and have multiple apps, it is often simpler to reason about static files if they are stored in a single, project-level directory instead. That is the approach we will take here.

Quit the local server with Control+c and create a new static directory in the same folder as the `manage.py` file.

```sh
mkdir static
```

`STATICFILES_DIRS` defines the additional locations the built-in staticfiles app will traverse looking for static files beyond an app/static folder. We need to add our project-level static folder to this configuration.

```python
# django_project/settings.py

STATIC_URL = "static/"
STATICFILES_DIRS = [BASE_DIR / "static"]  # new
```

Next, create a `css` directory within `static`.

```sh
mkdir static/css
```

Add a new file within your text editor in this directory called `static/css/style.css`. What should we put in our file? How about changing the title to red?

```css
/* static/css/style.css */

header h1 a {
    color: red;
}
```

The last step is adding the static files to our templates by adding `{% load static %}` to the top of `base.html`. Because our other templates inherit from `base.html`, we only have to add this once. Include a new line at the bottom of the `<head></head>` code that explicitly references our new `style.css` file.

```html
<!-- templates/base.html -->

{% load static %}
<html>
<head>
    <title>Django blog</title>
    <link rel="stylesheet" href="{% static 'css/style.css' %}">
</head>
...
```

Phew! That was a pain, but it’s a one-time hassle. We can add static files to our static directory, which will automatically appear in all our templates.

Start the server again with `python manage.py runserver` and look at our updated homepage at `http://127.0.0.1:8000/`.

If you see an error, `TemplateSyntaxError at /`, you forgot to add the `{% load static %}` line at the top. Even after all my years of using Django, I still make this mistake all the time! Fortunately, Django’s error message says, “Invalid block tag on line 4: ‘static’. Did you forget to register or load this tag?”. A pretty accurate description of what happened, no?

Even with this new styling, we can still do a little better. Let’s add a custom font and some more CSS. Since this section is not on CSS, we can insert the following between `<head></head>` tags to add Source Sans Pro, a free font from Google.

```html
<!-- templates/base.html -->

{% load static %}
<html>
<head>
    <title>Django blog</title>
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400"
          rel="stylesheet">
    <link href="{% static 'css/style.css' %}" rel="stylesheet">
</head>
...
```

Then, update our CSS file by copying and pasting the following code:

```css
/* static/css/style.css */

body {
    font-family: 'Source Sans Pro', sans-serif;
    font-size: 18px;
}
header {
    border-bottom: 1px solid #999;
    margin-bottom: 2rem;
    display: flex;
}
header h1 a {
    color: red;
    text-decoration: none;
}
.nav-left {
    margin-right: auto;
}
.nav-right {
    display: flex;
    padding-top: 2rem;
}
.post-entry {
    margin-bottom: 2rem;
}
.post-entry h2 {
    margin: 0.5rem 0;
}
.post-entry h2 a,
.post-entry h2 a:visited {
    color: blue;
    text-decoration: none;
}
.post-entry p {
    margin: 0;
    font-weight: 400;
}
.post-entry h2 a:hover {
    color: red;
}
```

Refresh the homepage at `http://127.0.0.1:8000/`; you should see the following.

## Individual Blog Pages

Now, we can add functionality for individual blog pages. We need to create a new view, URL, and template to do that. I hope you’re noticing a pattern in Django development!

Start with the view. At the top of our views file, import the shortcut function `get_object_or_404()`, which calls the `get` QuerySet method to return an object or raises a `Http404` error if unsuccessful.

We will name the view function `post_detail` as it represents the detailed view of a blog post. It accepts two parameters: the first, `request`, is an instance of the `HttpRequest` object; the second, `pk`, is a parameter extracted from the URL that identifies the specific blog post to be displayed by its primary key.

Let’s take a moment to focus on that last sentence, as it gets at the heart of understanding this function. To specify an individual blog post, we need a way to say that out of the list of all blog posts in the database, we should choose this specific one. The easiest and default way is to use the primary key ID associated with each record. For example, the first entry has a primary key (PK) of 1, the second of 2, and so on automatically set by the Django ORM.

Within the body of the `post_detail` function, there are two lines. First, we call `get_object_or_404` on the `Post` model and specify that the `pk` primary key matches the parameter `pk` from the URL. If we want the URL `/1`, our function will call the blog post with a primary key of 1. When you see this in action, it will make more sense. We set the variable `post` to equal this specific blog post. Then we use the `render()` function to return a response, where the first argument is the request variable, the second is the template `post_detail.html`, and the third is the template context where we create a variable `post` that matches the post from the previous line.

```python
# blog/views.py

from django.shortcuts import render, get_object_or_404  # new
from .models import Post

def post_list(request):
    posts = Post.objects.all()
    return render(request, 'home.html', {'posts': posts})

def post_detail(request, pk):  # new
    post = get_object_or_404(Post, pk=pk)
    return render(request, "post_detail.html", {"post": post})
```

This pattern for accessing a list of information from the database or a single item is repeated repeatedly in web development with Django, so don’t worry if it’s a little confusing at the moment.

With our view created, the next two steps are adding a URL route and a template. In the `blog/urls.py` file, import the new view, `post_detail`, and add a URL route at `post/<int:pk>/`.

This pattern will look a bit strange initially as it is our first use of a Django path converter. Up to this point, we have hardcoded our URL routes, but it is more common to use variables. In this case, we specify that individual posts will start at `post/`, but then we use `int` to specify that the captured value from the URL should be treated as an integer and the variable’s name passed to the view is `pk`. The second argument is the view name, `post_detail`, and we add the optional third argument of a name that is also `post_detail`.

```python
# blog/urls.py

from django.urls import path
from .views import post_list, post_detail  # new

urlpatterns = [
    path("post/<int:pk>/", post_detail, name="post_detail"),  # new
    path("", post_list, name="home"),
]
```

The last step is adding a new template file called `templates/post_detail.html` in your text editor. Then type in the following code:

```html
<!-- templates/post_detail.html -->

{% extends "base.html" %}
{% block content %}
<div class="post-entry">
    <h2>{{ post.title }}</h2>
    <p>{{ post.body }}</p>
</div>
{% endblock content %}
```

At the top, we specify that this template inherits from `base.html`. The template context variable `post` contains information from this particular blog post, and we can display individual fields using `post.title` and `post.body`.

If you start the server with `python manage.py runserver`, you’ll see

 a dedicated page for our first blog post at `http://127.0.0.1:8000/post/1/`.

You can also go to `http://127.0.0.1:8000/post/2/` to see the second entry.

To make our lives easier, we should update the link on the homepage so we can directly access individual blog posts from there. Swap out the current empty link, `<a href="">` with `<a href="{% url 'post_detail' post.pk %}">`.

```html
<!-- templates/home.html -->

{% extends "base.html" %}
{% block content %}
{% for post in posts %}
<div class="post-entry">
    <h2><a href="{% url 'post_detail' post.pk %}">{{ post.title }}</a></h2>
    <p>{{ post.body }}</p>
</div>
{% endfor %}
{% endblock content %}
```

We start by using Django’s `url` template tag and specifying the URL pattern name of `post_detail`. If you look at `post_detail` in our URLs file, it expects to be passed an argument `pk` representing the primary key for the blog post. Fortunately, Django has already created and included this `pk` field on our post object, but we must pass it into the URL by adding it to the template as `post.pk`.

To confirm everything works, refresh the main page at `http://127.0.0.1:8000/` and click on the title of each blog post to confirm the new links work.

## get_absolute_url()

Currently, we are using the `url` template tag, which means that every time we want to display an individual blog post in this template or other templates, we must repeat the pattern `{% url 'post_detail' post.pk %}`. If the URL pattern changes, we need to update every template where the URL is constructed, which increases the risk of errors.

A better approach is to use the built-in `get_absolute_url()` method, which tells Django how to calculate the canonical URL for our model object. In the `blog/models.py` file, add a new method for getting the `get_absolute_url`.

```python
# blog/models.py

from django.db import models
from django.urls import reverse  # new

class Post(models.Model):
    title = models.CharField(max_length=200)
    author = models.ForeignKey(
        "auth.User",
        on_delete=models.CASCADE,
    )
    body = models.TextField()

    def __str__(self):
        return self.title

    def get_absolute_url(self):  # new
        return reverse("post_detail", kwargs={"pk": self.pk})
```

At the top, we import `reverse()`, a utility function for our URLs. Then, we define `get_absolute_url` using `self` as the first parameter referring to the model instance on which the method is called. This is a standard practice in Python for instance methods. The `reverse()` function accepts the URL name and keyword arguments or “kwargs.” In this case, we are setting the variable `pk` to equal the primary key of our model instance.

We don’t need to update the migrations files because we aren’t changing the database schema here. Migrations are only required when changes to the model affect the database schema, such as adding or removing fields, changing field types, or modifying relationships between models.

In the template file, update the href link to now use `post.get_absolute_url`.

```html
<!-- templates/home.html -->

{% extends "base.html" %}
{% block content %}
{% for post in posts %}
<div class="post-entry">
    <h2><a href="{{ post.get_absolute_url }}">{{ post.title }}</a></h2> <!-- new -->
    <p>{{ post.body }}</p>
</div>
{% endfor %}
{% endblock content %}
```

URL paths can and do change over a project’s lifetime. With the previous method, if we changed the post detail view and URL path, we’d have to go through all our HTML and templates to update the code, a very error-prone and hard-to-maintain process. By using `get_absolute_url()` instead, we have one place, the `models.py` file, where the canonical URL is set, so our templates don’t have to change.

Refresh the main page at `http://127.0.0.1:8000/` and click on the title of each blog post to confirm the links still work as expected.

## Tests

Our Blog project has added new functionality we have not seen or tested before this section. The `Post` model has multiple fields; we have a user for the first time, and there is a list view of all blog posts and a detailed view for each blog post. There is quite a lot to test!

First, we can set up our test data and check the content of the `Post` model. Here’s how that might look.

```python
# blog/tests.py

from django.contrib.auth import get_user_model
from django.test import TestCase
from .models import Post

class BlogTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user = get_user_model().objects.create_user(
            username="testuser", email="test@email.com", password="secret"
        )
        cls.post = Post.objects.create(
            title="A good title",
            body="Nice body content",
            author=cls.user,
        )

    def test_post_model(self):
        self.assertEqual(self.post.title, "A good title")
        self.assertEqual(self.post.body, "Nice body content")
        self.assertEqual(self.post.author.username, "testuser")
        self.assertEqual(str(self.post), "A good title")
        self.assertEqual(self.post.get_absolute_url(), "/post/1/")
```

At the top, we import `get_user_model()` to refer to our User and then added `TestCase` and the `Post` model. Our class `BlogTests` contains setup data for both a test user and a test post. Currently, all the tests are focused on the `Post` model, so we name our test `test_post_model`. It checks that all three model fields return the expected values. Our model also has new tests for the `__str__` and `get_absolute_url` methods.

Go ahead and run the tests.

```sh
python manage.py test
```

Example output:

```sh
Found 1 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.
----------------------------------------------------------------------
Ran 1 test in 0.088s

OK
Destroying test database for alias 'default'...
```

What else to add? We now have two types of pages: a homepage that lists all blog posts and a detail page for each blog post containing its primary key in the URL. In the previous two sections, we implemented tests to check that:

- Expected URLs exist and return a 200 status code
- URL names work and return a 200 status code
- The correct template name is used
- The correct template content is outputted

All four tests need to be included. We could have eight new unit tests, four for each of our two pages, or we could combine them a bit. There isn’t a right or wrong answer here so long as tests are implemented to test functionality, and it is clear from their names what went wrong if an error arises.

Here is one way to add these checks to our code:

```python
# blog/tests.py

from django.contrib.auth import get_user_model
from django.test import TestCase
from django.urls import reverse  # new
from .models import Post

class BlogTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user = get_user_model().objects.create_user(
            username="testuser", email="test@email.com", password="secret"
        )
        cls.post = Post.objects.create(
            title="A good title",
            body="Nice body content",
            author=cls.user,
        )

    def test_post_model(self):
        self.assertEqual(self.post.title, "A good title")
        self.assertEqual(self.post.body, "Nice body content")
        self.assertEqual(self.post.author.username, "testuser")
        self.assertEqual(str(self.post), "A good title")
        self.assertEqual(self.post.get_absolute_url(), "/post/1/")

    def test_url_exists_at_correct_location_listview(self):  # new
        response = self.client.get("/")
        self.assertEqual(response.status_code, 200)

    def test_url_exists_at_correct_location_detailview(self):  # new
        response = self.client.get("/post/1/")
        self.assertEqual(response.status_code, 200)

    def test_post_listview(self):  # new
        response = self.client.get(reverse("home"))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Nice body content")
        self.assertTemplateUsed(response, "home.html")

    def test_post_detailview(self):  # new
        response = self.client.get(reverse("post_detail",
                                           kwargs={"pk": self.post.pk}))
        no_response = self.client.get("/post/100000/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(no_response.status_code, 404)
        self.assertContains(response, "A good title")
        self.assertTemplateUsed(response, "post_detail.html")
```

First, we check that the URL exists at the proper location for both views. Then we import `reverse` at the top and create `test_post_listview` to confirm that the named URL is used, returns a 200 status code, contains the expected content, and uses the `home.html` template. For `test_post_detailview`, we must pass in the `pk` of

 our test post to the response. The same template is used, and we add new tests for what we don’t want to see. For example, we don’t want a response at the URL `/post/100000/` because we have not created that many posts yet! And we don’t want a 404 HTTP status response either. It is always good to sprinkle in examples of incorrect tests that should pass through failure using the `no_response` method to ensure your tests aren’t mindlessly passing for some reason.

Run the new tests to confirm everything is working.

```sh
python manage.py test
```

Example output:

```sh
Found 5 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.....
----------------------------------------------------------------------
Ran 5 tests in 0.095s

OK
Destroying test database for alias 'default'...
```

A common mistake when testing URLs is failing to include the preceding slash `/`. For example, if `test_url_exists_at_correct_location_detailview` is checked in the response for `"post/1/"` that would throw a 404 error. However, if you check `"/post/1/"`, it will be a 200 status response.

## Git

Now is also a good time for our first Git commit. Initialize our directory and review all the added content by checking the status.

```sh
git init
git status
```

Oops, we do not want to include the `.venv` directory and the SQLite database! There might also be a `__pycache__` directory. To remove all three, in your text editor, create a project-level `.gitignore` file–in the same top directory as `manage.py`–and add these three lines.

```plaintext
.gitignore

Pipfile
Pipfile.lock
__pycache__/
db.sqlite3
```

Run `git status` again to confirm the `.venv` directory is no longer included. Then, add the rest of our work along with a commit message.

```sh
git status
git add -A
git commit -m "initial commit"
```

## Conclusion

We’ve now built a basic blog application from scratch! We can create, edit, or delete the content using the Django admin, which will display a list of all posts on the homepage and individual pages for each post. We looked at static files for the first time and added some styling with CSS. We also learned about the best practice of using `get_absolute_url` in our templates and made substantial progress on our test suite.

In the next section, we’ll switch to generic class-based views and add forms to create, update, and delete blog posts so we don’t have to use the Django admin for these changes.