# Blog Application with Forms

In this section, we’ll continue working on our Blog application by switching to class-based views and adding forms so a user can create, edit, or delete any of their blog entries. HTML forms are one of the more complicated and error-prone aspects of web development. Any time you accept user input, there are significant security concerns since users are uploading information to your database. All forms must be properly rendered, validated, and saved to the database. Writing this code by hand would be time-consuming and complex, so Django comes with powerful built-in [forms](https://docs.djangoproject.com/en/5.0/topics/forms/) and [generic editing views](https://docs.djangoproject.com/en/5.0/ref/class-based-views/generic-editing/) for common tasks like displaying, creating, updating, or deleting a form.

## ListView and DetailView

Currently, we are using function-based views for our page listing all blog posts and powering individual posts. We could continue down this page and create function-based views for create, edit, and delete functionality; however, doing so requires a lot more code and is error-prone compared to using generic class-based views designed explicitly for the job. For this reason, we will switch to using generic class-based views throughout the rest of the section.

Let’s look at the current `blog/views.py` file.

```python
# blog/views.py
from django.shortcuts import render, get_object_or_404
from .models import Post

def post_list(request):
    posts = Post.objects.all()
    return render(request, 'home.html', {'posts': posts})

def post_detail(request, pk):
    post = get_object_or_404(Post, pk=pk)
    return render(request, "post_detail.html", {"post": post})
```

Switching over to generic class-based views is relatively straightforward. Here is the updated code for the views:

```python
# blog/views.py
from django.views.generic import ListView, DetailView
from .models import Post

class BlogListView(ListView):
    model = Post
    template_name = "home.html"

class BlogDetailView(DetailView):
    model = Post
    template_name = "post_detail.html"
```

At the top, we import the generic views `ListView` and `DetailView`, along with our model, `Post`. We pass in the generic class-based view and define the model and template for both views. That’s it.

Next up is the URLs file. We change the views imports to match our new ones, `BlogListView` and `BlogDetailView`. Then, we update the second argument in both routes, specifying the view name and adding `as_view()` to transform the class into a callable view function.

```python
# blog/urls.py
from django.urls import path
from .views import BlogListView, BlogDetailView

urlpatterns = [
    path("post/<int:pk>/", BlogDetailView.as_view(), name="post_detail"),
    path("", BlogListView.as_view(), name="home"),
]
```

The final update is to our template. Previously, in our function-based list and detail views, we named the context object `posts` and `post` respectively. But for the GCBV `ListView`, you need to know that the default naming pattern is `<model>_list`; since our model is `Post`, the context object will be `post_list`. The updated code looks as follows:

```html
<!-- templates/home.html -->
{% extends "base.html" %}
{% block content %}
    {% for post in post_list %}
        <div class="post-entry">
            <h2><a href="{{ post.get_absolute_url }}">{{ post.title }}</a></h2>
            <p>{{ post.body }}</p>
        </div>
    {% endfor %}
{% endblock content %}
```

Do you want to change the context object name? You can! Django almost always provides a way to customize behavior. The attribute to update is called `context_object_name`. The update below would switch it back to `posts` as opposed to `post_list`. We won’t implement this change in the section, but you are welcome to do so on your own.

```python
# blog/views.py
class BlogListView(ListView):
    model = Post
    template_name = "home.html"
    context_object_name = 'posts'
```

The context object name in a `DetailView` also has a default value of either the model name (so `post` in this case) or `object`. That means we could leave our current template as is.

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

Or we could change `post` to `object` like this:

```html
<!-- templates/post_detail.html -->
{% extends "base.html" %}
{% block content %}
    <div class="post-entry">
        <h2>{{ object.title }}</h2>
        <p>{{ object.body }}</p>
    </div>
{% endblock content %}
```

If you refresh an individual blog post page in your web browser, you’ll see that both work. Which naming pattern you prefer is a personal preference. I like to use the model name, so we’ll use `post` going forward in our detail view templates. If you don’t like these built-in names for the template context object, you can override the existing `context_object_name` variable in your `DetailView`.

### Mixins

If you were paying close attention, you noticed that the `context_object_name` attribute for `ListView` was part of `MultipleObjectMixin` whereas for `DetailView` it was part of `SingleObjectMixin`. Why the difference?

A mixin is a type of multiple inheritance where you can add specific functionality to a class by including additional classes. Mixins are used in class-based views (CBVs) and generic class-based views (GCBVs) to add reusable behaviors or functionality without duplicating code. But you need to know what you’re doing to use them effectively.

Covering Django mixins fully is beyond the scope of a beginner section, but it is worth briefly explaining how the inheritance structure works. To do this, we will rely on Classy [Class-Based Views](https://ccbv.co.uk/), a website dedicated to describing the full methods and attributes for each Django GCBV. It is an invaluable resource if you decide to work with GCBVs. Looking at the entry for `ListView`, you can see its Ancestors listed at the top of the page. The hierarchy of classes used by `ListView` starts from the bottom.

1. `ListView`
2. `MultipleObjectTemplateResponseMixin`
3. `TemplateResponseMixin`
4. `BaseListView`
5. `MultipleObjectMixin`
6. `ContextMixin`
7. `View`

The base class, `View`, is used by all class-based views. You don’t need to memorize all these mixins to use GCBVs. But over time as attempt to customize their behavior, you will likely find yourself looking for the specific attribute or method that needs to be overridden.

A proponent of function-based views would say that this is ridiculous; you should have all the code you are using visible. A fan of class-based views would counter that it is ridiculous to write the same boilerplate code repeatedly when you only want to change one or two lines. I fall in the latter camp, but you can certainly understand why some very experienced Django developers prefer function-based views.

## CreateView

We now need a view where users can create a new blog post. `CreateView` is a generic class-based view designed for exactly this purpose. Here is the code we need in our views file.

```python
# blog/views.py
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView
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
```

At the top we import `CreateView` from the `django.views.generic.edit` module. Then we create a class, `BlogCreateView`, that extends `CreateView`, specifying the model, `Post`, the template name, `post_new.html`, and the database fields we want visible on the form, which are `title`, `author`, and `body`. That’s it! The function-based version of this view is much, much longer.

Then, update the URLs file to add a URL route for the create page.

```python
# blog/urls.py
from django.urls import path
from .views import BlogListView, BlogDetailView, BlogCreateView

urlpatterns = [
    path("post/new/", BlogCreateView.as_view(), name="post_new"),
    path("post/<int:pk>/", BlogDetailView.as_view(), name="post_detail"),
    path("", BlogListView.as_view(), name="home"),
]
```

Simple, right? It’s the same URL, views, and template pattern we’ve seen before. We import the new view, `BlogCreateView` and set the new path. It is located at `post/new/`, uses the view `BlogCreateView`, and has a URL name of `post_new`.

The only thing left is our template. Make a new template, `templates/post_new.html`, in the text editor. Then add the following code:

```html
<!-- templates/post_new.html -->
{% extends "base.html" %}
{% block content %}
    <h1>New post</h1>
    <form action="" method="post">{% csrf_token %}
        {{ form

 }}
        <input type="submit" value="Save">
    </form>
{% endblock content %}
```

Let’s break down what we’ve done:
- On the top line, we extended our base template.
- Use HTML `<form>` tags with the POST method since we’re sending data. If we were receiving data from a form, for example, in a search box, we would use GET.
- Add a [`{% csrf_token %}`](https://docs.djangoproject.com/en/5.0/ref/csrf/) which Django provides to protect our form from cross-site request forgery. You should use it for all your Django forms.
- Then, to output our form data use `{{ form }}` to render the specified fields.
- Finally, specify an input type of submit and assign the value “Save”.

To view our work, start the server with `python manage.py runserver` and go to the create a new page at `http://127.0.0.1:8000/post/new`.

### What is CSRF?

**CSRF** stands for **Cross-Site Request Forgery**. It's a type of cyber attack. Let's break it down in simple words:

#### Imagine This Scenario:

1. **You are logged into your bank website**.
2. **In another tab**, you open a different website (not related to your bank).
3. The second website secretly sends a request to your bank website, making it look like the request is coming from you.
4. **Since you are logged in**, the bank website trusts the request and processes it.

### What Happens?

- The attacker tricks your browser into sending unauthorized requests.
- These requests can do things like transfer money without you knowing.

### Why is it Dangerous?

- The attacker can perform actions on your behalf without your permission.
- It exploits the trust that a website has in your browser.

### How Do Websites Protect Against CSRF?

1. **CSRF Tokens**: Websites use special tokens (like secret codes) that are unique to your session. When you perform actions, the website checks for this token to make sure the request is legitimate.
2. **SameSite Cookies**: Cookies are set to be used only on the site they are created on, preventing other sites from using them.

### Simple Example

- **Without Protection**: 
  - You log in to your email.
  - Visit a malicious website.
  - The malicious site sends an email from your account without you knowing.

- **With Protection**:
  - You log in to your email.
  - Visit a malicious website.
  - The malicious site tries to send an email, but the request is rejected because it doesn't have the correct CSRF token.


Try to create a new blog post and submit it by clicking the “Save” button.

Upon completion, it will redirect to a detail page with the post at `http://127.0.0.1:8000/post/3/`. Success!

Rather than making a user guess where the create new post page is, let’s add a link to our base template. It will take the form `<a href="{% url 'post_new' %}"></a>` where `post_new` is the name for our URL.

Your updated `templates/base.html` file should look as follows:

```html
<!-- templates/base.html -->
{% load static %}
<html>
<head>
    <title>Django blog</title>
    <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400" rel="stylesheet">
    <link href="{% static 'css/style.css' %}" rel="stylesheet">
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

Navigate to the homepage and the “+ New Blog Post” link in the upper right-hand corner will be visible. Clicking it will redirect to the create new post page at `http://127.0.0.1:8000/post/new/`.

If we were to create this functionality using function-based views, we’d need a dedicated `blog/forms.py` file and a much longer view explaining how to handle the form, validate the data, and save it to the database. By using `CreateView` instead, we rely on built-in code to handle all these issues.

## UpdateView

Our next task is to add a page with a form for editing existing blog posts. It turns out that the generic class-based view, `UpdateView`, is designed explicitly for this. We will add it to our Blog, and the pattern of adding a new view, then a new URL path, and finally, a new template should feel familiar.

Let’s begin with the view. At the top of the `blog/views.py` file import `UpdateView` and then create a new class, `BlogUpdateView`, that extends it. Just as with `CreateView`, we only have to define three things: the model, template name, and fields we want displayed on the form.

```python
# blog/views.py
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, UpdateView
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
```

Notice that we are not including `author` in the fields because we assume that the author of a post will not change during editing. We only want the title and body text to be available to update.

Next, we need a new URL path for this update view. Update `blog/urls.py` by importing `BlogUpdateView` at the top and then create a new route with the URL pattern of `/post/pk/edit`. It will use `BlogUpdateView` as the view and have a URL named `post_edit`.

```python
# blog/urls.py
from django.urls import path
from .views import (
    BlogListView,
    BlogDetailView,
    BlogCreateView,
    BlogUpdateView,
)

urlpatterns = [
    path("post/new/", BlogCreateView.as_view(), name="post_new"),
    path("post/<int:pk>/", BlogDetailView.as_view(), name="post_detail"),
    path("post/<int:pk>/edit/", BlogUpdateView.as_view(), name="post_edit"),
    path("", BlogListView.as_view(), name="home"),
]
```

The third step is adding a new template for the update page. We know from our view that it should have the name `post_edit.html`, so add that file to your templates directory. It should have the following code.

```html
<!-- templates/post_edit.html -->
{% extends "base.html" %}
{% block content %}
    <h1>Edit post</h1>
    <form action="" method="post">{% csrf_token %}
        {{ form }}
        <input type="submit" value="Update">
    </form>
{% endblock content %}
```

At the top, we use `extends` on the base template, `base.html`, and then sandwich this page’s content between the content blocks. We again use HTML `<form></form>` tags, Django’s `csrf_token` for security, and give it the value “Update” on the submit button.

We could go directly to the URL for a specific post, for example, `127.0.0.1:8000/post/1/edit/` for the first blog post. However, a better approach is to add a link to the individual blog page in the `post_detail.html` template.

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

We’ve added a link using `<a href>...</a>` and the `{% url ... %}` tag. Within it, we’ve specified the target name of our URL, which will be called `post_edit`, and also passed the parameter needed, which is the primary key of the post: `post.pk`.

Now, if you click on a blog entry, you’ll see our new + Edit Blog Post hyperlink. If you click on “+ Edit Blog Post” you’ll be redirected to `/post/1/edit/` if it is your first blog post, hence the 1 in the URL. Note that the form is pre-filled with our database’s existing data for the post. Let’s make a change…

After clicking the “Update” button, we are redirected to the detail view of the post where the change is visible. Navigate to the homepage to see the change next to all the other entries.

## DeleteView

The final feature to add in this section is the ability to delete blog posts. We’ll use yet another generic class-based view, `DeleteView`, to do this and create the necessary view, URL, and template.

To begin, update the `blog/views.py` file by importing `DeleteView` and `reverse_lazy` at the top and then create a new view that subclasses `DeleteView`. Both `reverse` and `reverse_lazy` perform the same task: generating a URL based on an input like the URL name. The difference is when they are evaluated: `reverse` executes right away, so when `BlogDeleteView` is executed, immediately the model, `template_name`, and `success_url` methods are loaded. But the `success_url` needs to find out what the resulting URL path is associated with the URL name “home.” It can’t always do that in time! That’s why we use `reverse_lazy` in this example: it delays the actual call to the URL dispatcher until the moment it is needed, not when our class `BlogDeleteView` is being evaluated.

```python
# blog/views.py
from django.views.generic import ListView, DetailView
from django.views.generic.edit import CreateView, UpdateView, DeleteView
from django.urls import reverse_lazy
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

class BlogDeleteView(DeleteView):
    model = Post
    template_name = "post_delete.html"
    success_url = reverse_lazy("home")
```

`DeleteView` requires a model, template name, and success URL. We have supplied all three here. Remember, after a blog post is deleted, we have to redirect the user somewhere. In this case, that is our homepage at the URL name of “home”.

An astute reader might notice that both `CreateView` and `UpdateView` also have redirects yet we did not have to specify a `success_url`. Why is this? If available, Django, by default, will use the `get_absolute_url()` on the model object, a handy feature, but you would only know about it from reading a section like this or deeply reading the docs. More likely, with experience, you have used these GCBVs before and vaguely recall something about the redirect, consult the docs on model forms and then implement. There is no way to memorize everything you need to know as a Django developer; instead, with time, you’ll start to see the broad patterns and be able to look up the documentation for implementation details.

The `reverse_lazy` function in Django's `DeleteView` is used to define the URL to redirect to after a successful deletion. Unlike `reverse`, which resolves URLs immediately, `reverse_lazy` delays this process until the URL is actually needed, ensuring the URL configuration is fully loaded. This makes it ideal for use in class-based views, where attributes like `success_url` are set at the time the module is imported. In your `BlogDeleteView`, `reverse_lazy("home")` ensures that after deleting a post, the user is redirected to the home page without any URL resolution issues.

With our view complete, we can turn to the URL. It’s a similar pattern where we import the view, `BlogDeleteView`, set a URL path, specify the view, and include a URL name. A convention is to add `/delete/` to your URL path as we’ve done here.

```python
# blog/urls.py
from django.urls import path
from .views import (
    BlogListView,
    BlogDetailView,
    BlogCreateView,
    BlogUpdateView,
    BlogDeleteView,
)

urlpatterns = [
    path("post/new/", BlogCreateView.as_view(), name="post_new"),
    path("post/<int:pk>/", BlogDetailView.as_view(), name="post_detail"),
    path("post/<int:pk>/edit/", BlogUpdateView.as_view(), name="post_edit"),
    path("post/<int:pk>/delete/", BlogDeleteView.as_view(), name="post_delete"),
    path("", BlogListView.as_view(), name="home"),
]
```

Lastly, we need to add a template file confirming the user’s wish to delete the blog post. It will be called `templates/post_delete.html` and contain the following code:

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

Note we are using `post.title` here to display the title of our blog post. We could use `object.title` as it is also provided by `DetailView`.

We can add a link to delete blog posts on the individual blog page, `post_detail.html`.

```html
<!-- templates/post_detail.html -->
{% extends "base.html" %}
{% block content %}
    <div class="post-entry">
        <h2>{{ post.title }}</h2>
        <p>{{ post.body }}</p>
    </div>
    <div>
        <p><a href="{% url 'post_edit' post.pk %}">+ Edit Blog Post</a></p>
        <p><a href="{% url 'post_delete' post.pk %}">+ Delete Blog Post</a></p>
    </div>
{% endblock content %}
```

If you start the server again with the command `python manage.py runserver` and refresh any individual post page, you’ll see our “Delete Blog Post” link. Clicking on the link takes us to the delete page for the blog post, which displays the blog post’s title. If you click the “Confirm” button, it redirects you to the homepage where the blog post has been deleted!

## Tests

It’s time for tests to make sure everything works now–and in the future–as expected. We’ve added new views for create, update, and delete, so that means three new tests:
- `def test_post_createview`
- `def test_post_updateview`
- `def test_post_deleteview`

Update your existing `tests.py` file with new tests below `test_post_detailview` as follows.

```python
# blog/tests.py
# ... all previous tests as it is 
def test_post_createview(self):
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

def test_post_updateview(self):
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

def test_post_deleteview(self):
    response = self.client.post(reverse("post_delete", args="1"))
    self.assertEqual(response.status_code, 302)
```

For `test_post_createview`, we create a new response and check that the page has a 302 redirect status code and that the `last()` object created on our model matches the new response. Then `test_post_updateview` sees if we can update the initial post created in `setUpTestData` since that data is available throughout our entire test class. The last new test, `test_post_deleteview`, confirms that a 302 redirect occurs when deleting a post.

More tests can always be added later, such as for the templates, but at least we have some coverage of all our new functionality. Stop the local web server with `Control+c` and run these tests now. They should all pass.

```sh
(pipenv) $ python manage.py test
Found 8 test(s).
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
......
----------------------------------------------------------------------
Ran 8 tests in 0.101s
OK
Destroying test database for alias 'default'...
```

## Conclusion

With a small amount of code, we’ve built a blog application that allows for creating, reading, updating, and deleting blog posts. While there are multiple ways to achieve this same functionality–we could have used function-based views or written our own class-based views–we’ve demonstrated how little code it takes in Django to make this happen.

Note, however, a potential security concern: currently any user can update or delete blog entries, not just the creator! Fortunately, Django has built-in features to restrict access based on permissions, which we’ll cover later in the section.

But for now, our blog application is working, and in the next section, we’ll add user accounts so users can sign up, log in, and log out of the web app.
