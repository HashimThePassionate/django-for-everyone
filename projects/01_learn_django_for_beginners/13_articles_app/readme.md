# Articles App 

In this section, we will build out our Newspaper app. We will have an articles page where journalists can post articles, set up permissions so only the author of an article can edit or delete it, and finally add the ability for other users to write comments on each article.

## Setting Up the Articles App

To start, create an articles app and define the database models. There are no hard and fast rules around what to name your apps except that you can’t use the name of a built-in app. If you look at the `INSTALLED_APPS` section of `django_project/settings.py`, you can see which app names are off-limits:

- admin
- auth
- contenttypes
- sessions
- messages
- staticfiles

A general rule of thumb is to use the plural of an app name: posts, payments, users, etc. One exception would be when doing so is obviously wrong, such as blogs. In this case, using the singular blog makes more sense.

Start by creating our new articles app.

### Shell Command

```bash
python manage.py startapp articles
```

Then, add it to our `INSTALLED_APPS` and update the time zone, `TIME_ZONE`, lower down in the settings since we’ll be timestamping our articles. You can find your time zone in this [Wikipedia list](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones). For example, if you live in Boston, MA, in the Eastern time zone of the United States, your entry would be `America/New_York`.

### Code Update

```python
# django_project/settings.py

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    # 3rd Party
    "crispy_forms",
    "crispy_bootstrap5",
    # Local
    "accounts",
    "pages",
    "articles",  # new
]

TIME_ZONE = "America/New_York"  # new
```

## Defining the Database Model

Next, we define our database model, which contains four fields: title, body, date, and author. We’re letting Django automatically set the time and date based on our `TIME_ZONE` setting. For the author field, we want to reference our custom user model `"accounts.CustomUser"` which we set in the `django_project/settings.py` file as `AUTH_USER_MODEL`. We will also implement the best practice of defining a `get_absolute_url` and a `__str__` method for viewing the model in our admin interface.

### Code Implementation

```python
# articles/models.py

from django.conf import settings
from django.db import models
from django.urls import reverse

class Article(models.Model):
    title = models.CharField(max_length=255)
    body = models.TextField()
    date = models.DateTimeField(auto_now_add=True)
    author = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
    )

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse("article_detail", kwargs={"pk": self.pk})
```

There are two ways to refer to a custom user model: `AUTH_USER_MODEL` and `get_user_model`. As general advice:

- `AUTH_USER_MODEL` makes sense for references within a `models.py` file.
- `get_user_model()` is recommended everywhere else, such as views, tests, etc.

Since we have a new app and model, it’s time to make a new migration file and apply it to the database.

### Shell Commands

```bash
python manage.py makemigrations articles
python manage.py migrate
```

Output:

```
Migrations for 'articles':
  articles/migrations/0001_initial.py
    - Create model Article
```

Next, apply the migration:

```bash
python manage.py migrate
```

Output:

```
Operations to perform:
  Apply all migrations: accounts, admin, articles, auth, contenttypes, sessions
Running migrations:
  Applying articles.0001_initial... OK
```

## Admin Configuration

At this point, we can jump into the admin to play around with the model before building out the URLs/views/templates needed to display the data on the website. But first, we need to update `articles/admin.py` so our new app is displayed.

### Code Update

```python
# articles/admin.py

from django.contrib import admin
from .models import Article

admin.site.register(Article)
```

Now, start the server.

### Shell Command

```bash
python manage.py runserver
```

Navigate to the admin at `http://127.0.0.1:8000/admin/` and log in.

### Adding Sample Data

If you click “+ Add” next to “Articles” at the top of the page, you can enter some sample data. You’ll likely have three users available: your superuser, `testuser`, and `testuser2` accounts. Create new articles using your superuser account as the author. 

### Adding List Display in Admin

To display more information in the admin about each article, we can update `articles/admin.py` with `list_display`.

### Code Update

```python
# articles/admin.py

from django.contrib import admin
from .models import Article

class ArticleAdmin(admin.ModelAdmin):
    list_display = [
        "title",
        "body",
        "author",
    ]

admin.site.register(Article, ArticleAdmin)
```

This will allow us to see more information in the admin interface. We’ve extended `ModelAdmin`, a class that represents a model in the admin interface, and specified our fields to list with `list_display`. At the bottom of the file, we registered `ArticleAdmin` along with the `Article` model we imported at the top.

### Testing in the Admin Interface

If you click on an individual article, you will see that the title, body, and author are displayed but not the date, even though we defined a date field in our model. That’s because the date was automatically added by Django for us and, therefore, can’t be changed in the admin. We could make the date editable–in more complex apps, it’s common to have both a `created_at` and `updated_at` attribute–but to keep things simple, we’ll have the date be set upon creation by Django for us for now. Even though the date is not displayed here, we can still access it in our templates for display on web pages.

## Configuring URLs and Views

The next step is to configure our URLs and views. Let’s have our articles appear at `articles/`. 

### Adding URLs

Add a URL pattern for articles in our `django_project/urls.py` file.

### Code Update

```python
# django_project/urls.py

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path("admin/", admin.site.urls),
    path("accounts/", include("accounts.urls")),
    path("accounts/", include("django.contrib.auth.urls")),
    path("articles/", include("articles.urls")),  # new
    path("", include("pages.urls")),
]
```

Next, create a new `articles/urls.py` file and populate it with our routes. Let’s start with the page to list all articles at `articles/`, which will use the view `ArticleListView`.

### Creating Views and Templates

We’ll create a view using the built-in generic `ListView` from Django. The only two attributes we need to specify are the model `Article` and our template name, which will be `article_list.html`.

### Code Implementation

```python
# articles/urls.py

from django.urls import path
from .views import ArticleListView

urlpatterns = [
    path("", ArticleListView.as_view(), name="article_list"),
]
```

### Creating the List View

Now, create our view using the built-in generic `ListView` from Django. The only two attributes we need to specify are the model `Article` and our template name, which will be `article_list.html`.

### Code Implementation

```python
# articles/views.py

from django.views.generic import ListView
from .models import Article

class ArticleListView(ListView):
    model = Article
    template_name = "article_list.html"
```

### Creating the Template

The last step is to create a new template file in the text editor called `templates/article_list.html`. Bootstrap has a built-in component called [Cards](https://getbootstrap.com/docs/5.3/components/card/) that we can customize for our individual articles. 

We display each article’s title, body, author, and date. We can even provide links to the “detail”, “edit”, and “delete” pages that we haven’t built yet.

### Code Implementation

```html
<!-- templates/article_list.html -->

{% extends "base.html" %}
{% block title %}Articles{% endblock title %}

{% block content %}
{% for article in article_list %}
<div class="card">
    <div class="card-header">
        <span class="fw-bold">
            <a href="#">{{ article.title }}</a>
        </span> &middot;
        <span class="text-muted">by {{ article.author }} | {{ article.date }}</span>
    </div>
    <div class="card-body">
        {{ article.body }}
    </div>
    <div class="card-footer text-center text-muted">
        <a href="#">Edit</a>

 <a href="#">Delete</a>
    </div>
</div>
<br />
{% endfor %}
{% endblock content %}
```

Start the server again and check out our page at `http://127.0.0.1:8000/articles/`.

## Detail, Edit, and Delete Views

The next step is to add detail, edit, and delete options for the articles. This means creating new URLs, views, and templates. 

### Creating Detail, Edit, and Delete URLs

For our detail page, we want the route to be at `articles/<int:pk>`. The `int` here is a  [path converter](https://docs.djangoproject.com/en/5.0/topics/http/urls/#path-converters) and essentially tells Django that we want this value to be treated as an integer and not another data type like a string. Therefore, the URL route for the first article will be `articles/1/`. Since we are in the articles app, all URL routes will be prefixed with `articles/` because we set that in `django_project/urls.py`. We only need to add the `<int:pk>` part here.

Next up are the edit and delete routes that will also use the primary key. They will be at the URL routes `articles/1/edit/` and `articles/1/delete/` with the primary key of 1. Here is how the updated `articles/urls.py` file should look.

### Code Update

```python
# articles/urls.py

from django.urls import path
from .views import (
    ArticleListView,
    ArticleDetailView,  # new
    ArticleUpdateView,  # new
    ArticleDeleteView,  # new
)

urlpatterns = [
    path("<int:pk>/", ArticleDetailView.as_view(), name="article_detail"),  # new
    path("<int:pk>/edit/", ArticleUpdateView.as_view(), name="article_edit"),  # new
    path("<int:pk>/delete/", ArticleDeleteView.as_view(), name="article_delete"),  # new
    path("", ArticleListView.as_view(), name="article_list"),
]
```

### Creating Views

We will use Django’s generic class-based views for `DetailView`, `UpdateView`, and `DeleteView`. The detail view only requires listing the model and template name. For the update/edit view, we also add the specific attributes–title and body–that can be changed. And for the delete view, we must add a redirect for where to send the user after deleting the entry. That requires importing `reverse_lazy` and specifying the `success_url` along with a corresponding named URL.

### Code Implementation

```python
# articles/views.py

from django.views.generic import ListView, DetailView  # new
from django.views.generic.edit import UpdateView, DeleteView  # new
from django.urls import reverse_lazy  # new
from .models import Article

class ArticleListView(ListView):
    model = Article
    template_name = "article_list.html"

class ArticleDetailView(DetailView):  # new
    model = Article
    template_name = "article_detail.html"

class ArticleUpdateView(UpdateView):  # new
    model = Article
    fields = ("title", "body")
    template_name = "article_edit.html"

class ArticleDeleteView(DeleteView):  # new
    model = Article
    template_name = "article_delete.html"
    success_url = reverse_lazy("article_list")
```

### Creating Templates

Now, create three new template files:

- `templates/article_detail.html`
- `templates/article_edit.html`
- `templates/article_delete.html`

### Detail Template

```html
<!-- templates/article_detail.html -->

{% extends "base.html" %}
{% block content %}
<div class="article-entry">
    <h2>{{ object.title }}</h2>
    <p>by {{ object.author }} | {{ object.date }}</p>
    <p>{{ object.body }}</p>
</div>
<div>
    <p><a href="{% url 'article_edit' article.pk %}">Edit</a> <a href="{% url 'article_delete' article.pk %}">Delete</a></p>
    <p>Back to <a href="{% url 'article_list' %}">All Articles</a>.</p>
</div>
{% endblock content %}
```

### Edit Template

```html
<!-- templates/article_edit.html -->

{% extends "base.html" %}
{% load crispy_forms_tags %}
{% block content %}
<h1>Edit</h1>
<form action="" method="post">{% csrf_token %}
    {{ form|crispy }}
    <button class="btn btn-info ms-2" type="submit">Update</button>
</form>
{% endblock content %}
```

### Delete Template

```html
<!-- templates/article_delete.html -->

{% extends "base.html" %}
{% block content %}
<h1>Delete</h1>
<form action="" method="post">{% csrf_token %}
    <p>Are you sure you want to delete "{{ article.title }}"?</p>
    <button class="btn btn-danger ms-2" type="submit">Confirm</button>
</form>
{% endblock content %}
```

### Updating the List View Template

Now, update the `article_list.html` to replace the existing `<a href="#">` placeholders with real links.

### Code Update

```html
<!-- templates/article_list.html -->

{% extends "base.html" %}
{% block title %}Articles{% endblock title %}

{% block content %}
{% for article in article_list %}
<div class="card">
    <div class="card-header">
        <span class="fw-bold">
            <!-- add link here! -->
            <a href="{{ article.get_absolute_url }}">{{ article.title }}</a>
        </span> &middot;
        <span class="text-muted">by {{ article.author }} | {{ article.date }}</span>
    </div>
    <div class="card-body">
        {{ article.body }}
    </div>
    <div class="card-footer text-center text-muted">
        <!-- new links here! -->
        <a href="{% url 'article_edit' article.pk %}">Edit</a>
        <a href="{% url 'article_delete' article.pk %}">Delete</a>
    </div>
</div>
<br />
{% endfor %}
{% endblock content %}
```

### Testing the CRUD Functionality

Start the server and navigate to the articles list page at `http://127.0.0.1:8000/articles/`. Click the “Edit” link next to the first article, and you’ll be redirected to `http://127.0.0.1:8000/articles/1/edit/`.

### Create Page

The final step is to create a page for new articles using Django’s built-in `CreateView`. Our steps are to create a view, URL, and template.

### Code Implementation

```python
# articles/views.py

...
from django.views.generic.edit import (
    UpdateView, DeleteView, CreateView  # new
)
...
class ArticleCreateView(CreateView):  # new
    model = Article
    template_name = "article_new.html"
    fields = (
        "title",
        "body",
        "author",
    )
```

Next, update the `articles/urls.py` file with the new route.

### Code Update

```python
# articles/urls.py

from django.urls import path
from .views import (
    ArticleListView,
    ArticleDetailView,
    ArticleUpdateView,
    ArticleDeleteView,
    ArticleCreateView,  # new
)

urlpatterns = [
    path("<int:pk>/", ArticleDetailView.as_view(), name="article_detail"),
    path("<int:pk>/edit/", ArticleUpdateView.as_view(), name="article_edit"),
    path("<int:pk>/delete/", ArticleDeleteView.as_view(), name="article_delete"),
    path("new/", ArticleCreateView.as_view(), name="article_new"),  # new
    path("", ArticleListView.as_view(), name="article_list"),
]
```

### Creating the Create Template

To complete the new create functionality, add a template named `templates/article_new.html`.

### Code Implementation

```html
<!-- templates/article_new.html -->

{% extends "base.html" %}
{% load crispy_forms_tags %}
{% block content %}
<h1>New article</h1>
<form action="" method="post">{% csrf_token %}
    {{ form|crispy }}
    <button class="btn btn-success ms-2" type="submit">Save</button>
</form>
{% endblock content %}
```

## Additional Links

We should add the URL link for creating new articles to our navbar so that logged-in users can access it everywhere on the site.

### Code Update

```html
<!-- templates/base.html -->

...
{% if user.is_authenticated %}
<li><a href="{% url 'article_new' %}" class="nav-link px-2 link-dark">+ New</a></li>
...
```

Refreshing the webpage and clicking “+ New” will redirect to the create new article page.

One final link to add is to make the articles list page accessible from the home page. Add a button link to the `templates/home.html` file.

### Code Update

```html
<!-- templates/home.html -->

{% extends "base.html" %}
{% block title %}Home{% endblock title %}

{% block content %}
{% if user.is_authenticated %}
Hi {{ user.username }}! You are {{ user.age }} years old.
<form action="{% url 'logout' %}" method="post">
    {% csrf_token %}
    <button type="submit">Log Out</button>
</form>
<br/>
<p><a class="btn btn-primary" href="{% url 'article_list' %}" role="button">View all articles</a></p> <!-- new -->
{% else %}
<p>You are not logged in</p>
<a href="{

% url 'login' %}">Log In</a> |
<a href="{% url 'signup' %}">Sign Up</a>
{% endif %}
{% endblock content %}
```

Refresh the homepage, and the button will appear and work as intended.

## Saving with Git

We added quite a lot of new code in this section, so let’s save it with Git.

### Shell Commands

```bash
git status
git add .
git commit -m "newspaper app"
git push origin main
```

## Conclusion

We have now created a dedicated articles app with CRUD functionality. Articles can be created, read, updated, deleted, and even viewed as an entire list. However, there are no permissions or authorizations yet, which means anyone can do anything! If logged-out users know the correct URLs, they can edit an existing article or delete one, even one that’s not theirs! In the next section, we will add permissions and authorizations to our project to fix this.
