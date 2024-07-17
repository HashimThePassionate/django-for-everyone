# Blog with Forms

In this chapter, we’ll continue working on our Blog application from Chapter 5 by adding forms so a user can create, edit, or delete any of their blog entries. HTML forms are one of the more complicated and error-prone aspects of web development because any time you accept user input there are security concerns. All forms must be properly rendered, validated, and saved to the database.

Writing this code by hand would be time-consuming and difficult, so Django comes with powerful built-in [Forms](https://docs.djangoproject.com/en/4.0/topics/forms/) that abstract away much of the difficulty for us. Django also comes with generic editing views for common tasks like displaying, creating, updating, or deleting a form.

## CreateView

To start, update our base template to display a link to a page for entering new blog posts. It will take the form `<a href="{% url 'post_new' %}"></a>` where `post_new` is the name for our URL. Your updated file should look as follows:

### Code
```html
<!-- templates/base.html -->
{% load static %}
<html>
<head>
    <title>Django blog</title>
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400" rel="stylesheet">
    <link href="{% static 'css/base.css' %}" rel="stylesheet">
</head>
<body>
    <div>
        <header>
            <div class="nav-left">
                <h1><a href="{% url 'home' %}">Django blog</a></h1>
            </div>
            <div class="nav-right">
                <a href="{% url 'post_new' %}">+ New Blog Post</a>
            </div>
        </header>
        {% block content %}
        {% endblock content %}
    </div>
</body>
</html>
```

Let’s add a new URL for `post_new` now. Import `BlogCreateView` (which has not been created yet) at the top and then add a URL path for `post/new/`. We will give it the URL name of `post_new` so it can be referred to later in our templates.

### Code
```python
# blog/urls.py
from django.urls import path
from .views import BlogListView, BlogDetailView, BlogCreateView # new

urlpatterns = [
    path("post/new/", BlogCreateView.as_view(), name="post_new"), # new
    path("post/<int:pk>/", BlogDetailView.as_view(), name="post_detail"),
    path("", BlogListView.as_view(), name="home"),
]
```

Simple, right? It’s the same URL, views, template pattern we’ve seen before. Now let’s create our view by importing a new generic class called `CreateView` at the top and then subclass it to create a new view called `BlogCreateView`.

### Code
```python
# blog/views.py
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView # new
from .models import Post

class BlogListView(ListView):
    model = Post
    template_name = "home.html"

class BlogDetailView(DetailView):
    model = Post
    template_name = "post_detail.html"

class BlogCreateView(CreateView): # new
    model = Post
    template_name = "post_new.html"
    fields = ["title", "author", "body"]
```

Within `BlogCreateView`, we specify our database model, `Post`, the name of our template, `post_new.html`, and explicitly set the database fields we want to expose, which are `title`, `author`, and `body`.

The last step is to create our template called `post_new.html` in the text editor. Then add the following code:

### Code
```html
<!-- templates/post_new.html -->
{% extends "base.html" %}
{% block content %}
    <h1>New post</h1>
    <form action="" method="post">{% csrf_token %}
        {{ form.as_p }}
        <input type="submit" value="Save">
    </form>
{% endblock content %}
```

Let’s breakdown what we’ve done:

- On the top line, we inherit from our base template.
- Use HTML `<form>` tags with the POST method since we’re sending data. If we were receiving data from a form, for example in a search box, we would use GET.
- Add a `{% csrf_token %}` which Django provides to protect our form from cross-site request forgery. You should use it for all your Django forms.
- Then to output our form data, we use `{{ form.as_p }}` which renders the specified fields within paragraph `<p>` tags.
- Finally, specify an input type of submit and assign it the value “Save”.

To view our work, start the server with `python manage.py runserver` and go to the homepage at `http://127.0.0.1:8000/`.
Click the “+ New Blog Post” link in the upper right-hand corner. It will redirect to the web page at `http://127.0.0.1:8000/post/new/`.
Go ahead and try to create a new blog post and submit it by clicking the “Save” button.
Upon completion, it will redirect to a detail page at `http://127.0.0.1:8000/post/3/` with the post itself. Success!
## UpdateView

The process for creating an update form so users can edit blog posts should feel familiar. We’ll again use a built-in Django class-based generic view, `UpdateView`, and create the requisite template, URL, and view.
To start, let’s add a new link to `post_detail.html` so that the option to edit a blog post appears on an individual blog page.
### Code
```html
<!-- templates/post_detail.html -->
{% extends "base.html" %}
{% block content %}
    <div class="post-entry">
        <h2>{{ post.title }}</h2>
        <p>{{ post.body }}</p>
    </div>
    <a href="{% url 'post_edit' post.pk %}">+ Edit Blog Post</a>
{% endblock content %}
```
We’ve added a link using `<a href>...</a>` and the Django template engine’s `{% url ... %}` tag. Within it, we’ve specified the target name of our URL, which will be called `post_edit` and also passed the parameter needed, which is the primary key of the post `post.pk`.
Next, we create the template file for our edit page called `post_edit.html` and add the following code:
### Code
```html
<!-- templates/post_edit.html -->
{% extends "base.html" %}
{% block content %}
    <h1>Edit post</h1>
    <form action="" method="post">{% csrf_token %}
        {{ form.as_p }}
        <input type="submit" value="Update">
    </form>
{% endblock content %}
```
We again use HTML `<form></form>` tags, Django’s `csrf_token` for security, `form.as_p` to display our form fields with paragraph tags, and finally give it the value “Update” on the submit button.
Now to our view. We need to import `UpdateView` on the second-from-the-top line and then subclass it in our new view `BlogUpdateView`.
### Code
```python
# blog/views.py
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, UpdateView # new
from .models import Post

class BlogListView(ListView):
    model = Post
    template_name = "home.html"

class BlogDetailView(DetailView):
    model = Post
    template_name = "post_detail.html"

class BlogCreateView(CreateView):
    model = Post
    template_name = "post_new.html"
    fields = ["title", "author", "body"]

class BlogUpdateView(UpdateView): # new
    model = Post
    template_name = "post_edit.html"
    fields = ["title", "body"]
```
Notice that in `BlogUpdateView`, we are explicitly listing the fields we want to use `["title", "body"]` rather than using `"__all__"`. This is because we assume that the author of the post is not changing; we only want the title and text to be editable.
The final step is to update our `urls.py` file as follows. Add the `BlogUpdateView` up top and then the new route at the top of the existing `urlpatterns`.
### Code
```python
# blog/urls.py
from django.urls import path
from .views import (
    BlogListView,
    BlogDetailView,
    BlogCreateView,
    BlogUpdateView, # new
)
urlpatterns = [
    path("post/new/", BlogCreateView.as_view(), name="post_new"),
    path("post/<int:pk>/", BlogDetailView.as_view(), name="post_detail"),
    path("post/<int:pk>/edit/", BlogUpdateView.as_view(), name="post_edit"), # new
    path("", BlogListView.as_view(), name="home"),
]
```
At the top, we add our view `BlogUpdateView` to the list of imported views, then created a new URL pattern for `/post/pk/edit` and gave it the name `post_edit`.
Now if you click on a blog entry, you’ll see our new Edit button.
If you click on “+ Edit Blog Post” you’ll be redirected to `/post/1/edit/` if it is your first blog post, hence the `1` in the URL. Note that the form is pre-filled with our database’s existing data for the post. Let’s make a change…
And after clicking the “Update” button, we are redirected to the detail view of the post where you can see the change. This is because of our `get_absolute_url` setting. Navigate to the homepage, and you can see the change next to all the other entries.
## DeleteView
The process for creating a form to delete blog posts is very similar to that for updating a post. We’ll use yet another generic class-based view, `DeleteView`, create the necessary view, URL, and template.
Let’s start by adding a link to delete blog posts on our individual blog page, `post_detail.html`.
### Code
```html
<!-- templates/post_detail.html -->
{% extends "base.html" %}
{% block content %}
    <div class="post-entry">
        <h2>{{ post.title }}</h2>
        <p>{{ post.body }}</p>
    </div>
    <p><a href="{% url 'post_edit' post.pk %}">+ Edit Blog Post</a></p>
    <p><a href="{% url 'post_delete' post.pk %}">+ Delete Blog Post</a></p>
{% endblock content %}
```
Then create a new file for our delete page template. It will be called `templates/post_delete.html` and contain the following code:
### Code
```html
<!-- templates/post_delete.html -->
{% extends "base.html" %}
{% block content %}
    <h1>Delete post</h1>
    <form action="" method="post">{% csrf_token %}
        <p>Are you sure you want to delete "{{ post.title }}"?</p>
        <input type="submit" value="Confirm">
    </form>
{% endblock content %}
```
Note we are using `post.title` here to display the title of our blog post. We could also just use `object.title` as it too is provided by `DetailView`.
Now update the `blog/views.py` file, by importing `DeleteView` and `reverse_lazy` at the top, then create a new view that subclasses `DeleteView`.
### Code
```python
# blog/views.py
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, UpdateView, DeleteView # new
from django.urls import reverse_lazy # new
from .models import Post

class BlogListView(ListView):
    model = Post
    template_name = "home.html"

class BlogDetailView(DetailView):
    model = Post
    template_name = "post_detail.html"

class BlogCreateView(CreateView):
    model = Post
    template_name = "post_new.html"
    fields = ["title", "author", "body"]

class BlogUpdateView(UpdateView):
    model = Post
    template_name = "post_edit.html"
    fields = ["title", "body"]

class BlogDeleteView(DeleteView): # new
    model = Post
    template_name = "post_delete.html"
    success_url = reverse_lazy("home")
```
The `DeleteView` specifies a model, which is `Post`, a template `post_delete.html`, and a third field called `success_url`. What does this do? Well, after a blog post is deleted, we want to redirect the user to another page which is, in our case, the homepage at `home`.

An astute reader might notice that both `CreateView` and `UpdateView` also have redirects, yet we did not have to specify a `success_url`. This is because Django will automatically use `get_absolute_url()` on the model object if it is available. And the only way to know about this trait is to very closely read and remember the docs, where it talks about [model forms](https://docs.djangoproject.com/en/4.0/topics/class-based-views/generic-editing/#model-forms) and `success_url`. Or more likely to have an error crop up and backtrack to sort out this internal Django behavior.
One final point: we use `reverse_lazy` here as opposed to just `reverse` so that it won’t execute the URL redirect until our view has finished deleting the blog post.
As a final step, create a URL by importing our view `BlogDeleteView` and adding a new pattern:
### Code
```python
# blog/urls.py
from django.urls import path
from .views import (
    BlogListView,
    BlogDetailView,
    BlogCreateView,
    BlogUpdateView,
    BlogDeleteView, # new
)
urlpatterns = [
    path("post/new/", BlogCreateView.as_view(), name="post_new"),
    path("post/<int:pk>/", BlogDetailView.as_view(), name="post_detail"),
    path("post/<int:pk>/edit/", BlogUpdateView.as_view(), name="post_edit"),
    path("post/<int:pk>/delete/", BlogDeleteView.as_view(), name="post_delete"), # new
    path("", BlogListView.as_view(), name="home"),
]
```
If you start the server again with the command `python manage.py runserver` and refresh any individual post page, you’ll see our “Delete Blog Post” link.
Clicking on the link takes us to the delete page for the blog post, which displays the name of the blog post.
If you click on the “Confirm” button, it redirects you to the homepage where the blog post has been deleted!
So it works!

## Tests

Time for tests to make sure everything works now–and in the future–as expected. We’ve added new views for create, update, and delete, so that means three new tests:

- `def test_post_createview`
- `def test_post_updateview`
- `def test_post_deleteview`

Update your existing `tests.py` file with new tests below `test_post_detailview` as follows.

### Code
```python
# blog/tests.py
...
def test_post_createview(self): # new
    response = self.client.post(
        reverse("post_new"),
        {
            "title": "New title",
            "body": "New text",
            "author": self.user.id,
        },
    )
    self.assertEqual(response.status_code, 302)
    self.assertEqual(Post.objects.last().title, "New title")
    self.assertEqual(Post.objects.last().body, "New text")

def test_post_updateview(self): # new
    response = self.client.post(
        reverse("post_edit", args="1"),
        {
            "title": "Updated title",
            "body": "Updated text",
        },
    )
    self.assertEqual(response.status_code, 302)
    self.assertEqual(Post.objects.last().title, "Updated title")
    self.assertEqual(Post.objects.last().body, "Updated text")

def test_post_deleteview(self): # new
    response = self.client.post(reverse("post_delete", args="1"))
    self.assertEqual(response.status_code, 302)
```

For `test_post_createview`, we create a new response and check that the page has a 302 redirect status code and the `last()` object created on our model matches the new response. Then `test_post_updateview` sees if we can update the initial post created in `setUpTestData` since that data is available throughout our entire test class. The last new test, `test_post_deleteview`, confirms that a 302 redirect occurs when deleting a post.

There are always more tests that can be added, but at least we have some coverage on all our new functionality. Stop the local web server with `Control+c` and run these tests now. They should all pass.

### Shell
```shell
(.venv) > python manage.py test
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
......
----------------------------------------------------------------------
Ran 6 tests in 0.129s
OK
Destroying test database for alias 'default'...
```

## Conclusion

With a small amount of code, we’ve built a Blog application that allows for creating, reading, updating, and deleting blog posts. This core functionality is known by the acronym CRUD: Create-Read-Update-Delete. While there are multiple ways to achieve this same functionality–we could have used function-based views or written our own class-based views–we’ve demonstrated how little code it takes in Django to make this happen.

Note, however, a potential security concern: currently, any user can update or delete blog entries, not just the creator! This is not ideal and indeed Django comes with built-in features to restrict access based on permissions, which we’ll cover in-depth in upcoming section.

But for now, our Blog application is working, and in the next section, we’ll add user accounts so users can sign up, log in, and log out of the web app.
