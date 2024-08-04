# Comments
In this section, we'll add comments functionality to our Newspaper site. Instead of creating a separate app for comments, we will add a `Comment` model to our existing `articles` app and link it to the `Article` model using a foreign key. This approach simplifies the structure while still allowing for future scalability.

## Django Structure and Philosophy
Django’s structure, which organizes a project into multiple smaller apps, is designed to help developers understand and manage the logic of a web application. While the computer doesn't care about the code's structure, breaking functionality into smaller pieces makes the application easier to understand and maintain. Premature optimization should be avoided; the priority should be making the code work, ensuring it's performant, and structuring it to be understandable to others, even months later.

## Requirements for Comments Functionality
To add comments functionality, we need to work with models, URLs, views, templates, and forms. We'll follow a commonly used order: models -> URLs -> views -> templates/forms. By the end of this section, users will be able to add comments to any existing article on our website.

## Model

### Adding the Comment Model
We'll add a `Comment` model to our existing database. This model will have a many-to-one foreign key relationship with the `Article` model, meaning one article can have many comments, but a comment belongs to only one article. We'll also include a `comment` field for the text of the comment and an `author` field linked to the user who wrote the comment.

```python
# articles/models.py

from django.db import models
from django.conf import settings
from django.urls import reverse

class Comment(models.Model):  # new
    article = models.ForeignKey(Article, on_delete=models.CASCADE)
    comment = models.CharField(max_length=140)
    author = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
    )

    def __str__(self):
        return self.comment

    def get_absolute_url(self):
        return reverse("article_list")
```

### Migration
After updating the models, create a new migration file and apply it. By specifying the `articles` app in the `makemigrations` command, we ensure that only changes in this app are included in the migration file.

```bash
$ python manage.py makemigrations articles
$ python manage.py migrate
```

## Admin

### Registering the Comment Model
We’ll register the `Comment` model in the admin interface so we can manage it through Django's admin.

```python
# articles/admin.py

from django.contrib import admin
from .models import Article, Comment  # new

class ArticleAdmin(admin.ModelAdmin):
    list_display = ["title", "body", "author"]

admin.site.register(Article, ArticleAdmin)
admin.site.register(Comment)  # new
```

Start the server and navigate to `http://127.0.0.1:8000/admin/` to see the new `Comments` section under the "Articles" app.

## Inlines in Admin

### Displaying Related Comments
To view and manage all comments related to a single article in the admin interface, we can use Django admin's inline feature. We’ll first implement `StackedInline` and then show how to switch to `TabularInline` for a more compact view.

```python
# articles/admin.py

from django.contrib import admin
from .models import Article, Comment

class CommentInline(admin.StackedInline):  # new
    model = Comment
    extra = 0  # new

class ArticleAdmin(admin.ModelAdmin):  # updated
    inlines = [CommentInline]
    list_display = ["title", "body", "author"]

admin.site.register(Article, ArticleAdmin)
admin.site.register(Comment)
```

To use `TabularInline` instead:

```python
class CommentInline(admin.TabularInline):  # new
    model = Comment
    extra = 0
```

## Template Updates

### Displaying Comments in Templates
We want comments to appear on the articles list page and allow logged-in users to add a comment on the detail page for an article. We’ll update `article_list.html` and `article_detail.html` templates accordingly.

#### article_list.html

```html
<!-- templates/article_list.html -->
...
<div class="card-body">
    {{ article.body }}
    {% if article.author.pk == request.user.pk %}
        <a href="{% url 'article_edit' article.pk %}">Edit</a>
        <a href="{% url 'article_delete' article.pk %}">Delete</a>
    {% endif %}
</div>
<div class="card-footer">
    {% for comment in article.comment_set.all %}
        <p>
            <span class="fw-bold">{{ comment.author }} &middot;</span>
            {{ comment }}
        </p>
    {% endfor %}
</div>
</div>
<br/>
{% endfor %}
```

#### article_detail.html

```html
<!-- templates/article_detail.html -->

{% extends "base.html" %}
{% block content %}
<div class="article-entry">
    <h2>{{ object.title }}</h2>
    <p>by {{ object.author }} | {{ object.date }}</p>
    <p>{{ object.body }}</p>
</div>
<hr>
<!-- change staart here -->
<h4>Comments</h4>
{% for comment in article.comment_set.all %}
    <p>{{ comment.author }} &middot; {{ comment }}</p>
{% endfor %}
<hr>
<!-- change end here -->
{% if article.author.pk == request.user.pk %}
    <p><a href="{% url 'article_edit' article.pk %}">Edit</a>
    <a href="{% url 'article_delete' article.pk %}">Delete</a></p>
{% endif %}
<p>Back to <a href="{% url 'article_list' %}">All Articles</a>.</p>
{% endblock content %}
```

## Comment Form
The comments are now visible, but we need to add a form so users can add them to the website. Web forms are a very complicated topic since security is essential: any time you accept data from a user that will be stored in a database, you must be highly cautious. The good news is Django
forms handle most of this work for us. [ModelForm ](https://docs.djangoproject.com/en/5.0/topics/forms/modelforms/#modelform) is a helper class that translates database models into forms. We can use it to create a form called, appropriately enough, CommentForm. We could put this form in our existing
articles/models.py file, but generally, the best practice is to put all forms in a dedicated forms.py file within your app. That’s the approach we’ll use here. With your text editor, create a new file called articles/forms.py. At the top, import forms, which has ModelForm as a module. Then import our model, Comment, since we’ll need to add that, too. Finally, create the class CommentForm, specifying both the underlying model and the specific field to expose, comment. When we create the corresponding view, we will automatically set the author to the currently logged-in user

### Creating the Comment Form
We’ll use Django’s `ModelForm` to create a form for adding comments. The form will be placed in a new `forms.py` file within the `articles` app.

```python
# articles/forms.py

from django import forms
from .models import Comment

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ("comment",)
```

### Comment View
Currently, we rely on the generic class-based DetailView to power our ArticleDetailView. It displays individual entries but needs to be configured to add additional information like a form. Class-based views are powerful because their inheritance structure means that if we know where to look, there is often a specific module we can override to attain our desired outcome.  The one we want in this case is called [get_context_data](https://docs.djangoproject.com/en/5.0/ref/class-based-views/mixins-simple/#django.views.generic.base.ContextMixin.get_context_data). It is used to add information to template by [updating the context](https://docs.djangoproject.com/en/5.0/ref/templates/api/#django.template.Context), a dictionary object containing all the variable names and values available in our template. For performance reasons, Django templates compile only once; if we want something available in the template, it must load into the context at the beginning. What do we want to add in this case? Well, just our CommentForm. And since context is a dictionary, we must also assign a variable name. How about form? Here is what the new code looks like in articles/views.py.

We need to update our `ArticleDetailView` to include the comment form. We’ll override `get_context_data()` to add the form to the context.

```python
# articles/views.py

from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import DetailView
from .forms import CommentForm
from .models import Article

class ArticleDetailView(LoginRequiredMixin, DetailView):
    model = Article
    template_name = "article_detail.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["form"] = CommentForm()
        return context
```
Near the top of the file, just above from .models import Article, we added an import line for
CommentForm and then updated the module for get_context_data(). First, we pulled all existing
information into the context using super(), added the variable name form with the value of
CommmentForm(), and returned the updated context

### Displaying the Comment Form in the Template
We’ll update `article_detail.html` to display the comment form.

```html
<!-- templates/article_detail.html -->
{% extends "base.html" %}
{% load crispy_forms_tags %} <!-- new! -->
{% block content %}
<div class="article-entry">
<h2>{{ object.title }}</h2>
<p>by {{ object.author }} | {{ object.date }}</p>
<p>{{ object.body }}</p>
</div>
<hr>
<h4>Comments</h4>
{% for comment in article.comment_set.all %}
<p>{{ comment.author }} &middot; {{ comment }}</p>
{% endfor %}
<hr>
<!-- Changes start here! -->
<h4>Add a comment</h4>
<form action="" method="post">{% csrf_token %}
{{ form|crispy }}
<button class="btn btn-success ms-2" type="submit">Save</button>
</form>
<!-- Changes end here! -->
<div>
{% if article.author.pk == request.user.pk %}
<p><a href="{% url 'article_edit' article.pk %}">Edit</a>
<a href="{% url 'article_delete' article.pk %}">Delete</a>
</p>
{% endif %}
<p>Back to <a href="{% url 'article_list' %}">All Articles</a>.</p>
</div>
{% endblock content %}

```
### Comment Post View
We ultimately need a view that handles both GET and POST requests depending upon whether the form should be merely displayed or capable of being submitted. We could reach for [FormMixin](https://docs.djangoproject.com/en/5.0/ref/class-based-views/mixins-editing/#django.views.generic.edit.FormMixin) to combine both into our ArticleDetailView, but as the [Django docs illustrate quite well](https://docs.djangoproject.com/en/5.0/topics/class-based-views/mixins/#avoid-anything-more-complex), there are risks with this approach. To avoid subtle interactions between DetailView and FormMixin, we will separate the GET and POST variations into their dedicated views. We can then transform ArticleDetailView into a wrapper view that combines them. This is a very common pattern in more advanced Django development because a single URL must often behave differently based on the user request (GET, POST, etc.) or even the format (returning HTML vs. JSON). Let’s start by renaming ArticleDetailView into CommentGet since it handles GET requests but not POST requests. We’ll then create a new CommentPost view that is empty for now. And we can combine both CommentPost and CommentGet into a new ArticleDetailView that subclasses [View ](https://docs.djangoproject.com/en/5.0/ref/class-based-views/base/#django.views.generic.base.View), the foundational class upon which all other class-based views are built.



### Creating a Post View for Comments
We’ll create a view that handles both GET and POST requests for comments. To avoid the complexity of mixing GET and POST logic in one view, we’ll split the logic into two separate views: `CommentGet` for GET requests and `CommentPost` for POST requests.

```python
# articles/views.py
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import DetailView, FormView
from django.views.generic.detail import SingleObjectMixin
from django.urls import reverse
from .forms import CommentForm
from .models import Article
from django.views import View # new
...
class CommentGet(DetailView):  # new
    model = Article
    template_name = "article_detail.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context["form"] = CommentForm()
        return context

class CommentPost(SingleObjectMixin, FormView):  # new
    model = Article
    form_class = CommentForm
    template_name = "article_detail.html"

    def post(self, request, *args, **kwargs):
        self.object = self.get_object()
        return super().post(request, *args, **kwargs)

    def form_valid(self, form):
        comment = form.save(commit=False)
        comment.article = self.object
        comment.author = self.request.user
        comment.save()
        return super().form_valid(form)

    def get_success_url(self):
        article = self.object
        return reverse("article_detail", kwargs={"pk": article.pk})

class ArticleDetailView(LoginRequiredMixin, View):  # updated
    def get(self, request, *args, **kwargs):
        view = CommentGet.as_view()
        return view(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        view = CommentPost.as_view()
        return view(request, *args, **kwargs)
```

Navigate back to the homepage in your web browser and then reload the article page with a comment. Everything should work as before.
We’re ready to write CommentPost and complete the task of adding comments to our website. We are almost done! [FormView](https://docs.djangoproject.com/en/5.0/ref/class-based-views/generic-editing/#django.views.generic.edit.FormView) is a built-in view that displays a form, any validation errors, and redirects to a new URL. We will use it with [SingleObjectMixin](https://docs.djangoproject.com/en/5.0/ref/class-based-views/mixins-single-object/#django.views.generic.detail.SingleObjectMixin) to associate the current article with our form; in other words, if you have a comment at articles/4/, as I do in the screenshots, then SingleObjectMixin will grab the 4 so that our comment is saved to the article with a pk of 4. Here is the complete code, which we’ll run through below line-by-line.

```python 
# articles/views.py
from django.contrib.auth.mixins import LoginRequiredMixin, UserPassesTestMixin
from django.views import View
from django.views.generic import ListView, DetailView, FormView # new
from django.views.generic.detail import SingleObjectMixin # new
from django.views.generic.edit import UpdateView, DeleteView, CreateView
from django.urls import reverse_lazy, reverse # new
from .forms import CommentForm
from .models import Article


...
class CommentPost(SingleObjectMixin, FormView): # new
    model = Article
    form_class = CommentForm
    template_name = "article_detail.html"
    def post(self, request, *args, **kwargs):
        self.object = self.get_object()
        return super().post(request, *args, **kwargs)
    def form_valid(self, form):
        comment = form.save(commit=False)
        comment.article = self.object
        comment.author = self.request.user
        comment.save()
        return super().form_valid(form)
    def get_success_url(self):
        article = self.object
        return reverse("article_detail", kwargs={"pk": article.pk})
...
```
### Code Explanation:

1. **Class Definition:**
   - The `CommentPost` class is defined, which inherits from two classes: `SingleObjectMixin` and `FormView`. This class is used to handle posting comments on articles.

2. **Attributes:**
   - `model = Article`: This specifies that the `CommentPost` class is working with the `Article` model (which means each comment will be associated with an article).
   - `form_class = CommentForm`: This tells the class to use the `CommentForm` for handling the form submission.
   - `template_name = "article_detail.html"`: This sets the template used to display the form and article details.

3. **Methods:**
   - **`post(self, request, *args, **kwargs)`**:
     - This method is triggered when someone submits the comment form.
     - It first gets the specific article using the `get_object()` method from `SingleObjectMixin`, which finds the article based on the URL.
     - Then it calls the `post` method from `FormView` to continue the form handling process.
   
   - **`form_valid(self, form)`**:
     - This method is called when the form is successfully validated (meaning all the data in the form is correct).
     - The form data is saved into a `comment` object, but it’s not yet stored in the database (`commit=False` means "don't save it to the database yet").
     - Before saving the comment, the method assigns the current article to the `comment.article` field and the current logged-in user to the `comment.author` field.
     - Then the comment is saved to the database with the correct associations.
     - Finally, it calls the `form_valid` method of the parent class to complete the form submission process.
   
   - **`get_success_url(self)`**:
     - This method determines where to redirect the user after a successful comment submission.
     - It returns the URL of the current article's detail page using the article's primary key (`pk`).

## Adding a New omment Link
We’ll add a "New Comment" link on the articles list page to allow users to quickly navigate to the article detail page and add a comment.

```html
<!-- templates/article_list.html -->

<div class="card-body">
    <p>{{ article.body }}</p>
    {% if article.author.pk == request.user.pk %}
        <a href="{% url 'article_edit' article.pk %}">Edit</a>
        <a href="{% url 'article_delete' article.pk %}">Delete</a>
    {% endif %}
    <a href="{{ article.get_absolute_url }}">New Comment</a> <!-- new -->
</div>
```

## Git Management

### Saving Your Work
After making all these changes, save your work using Git.

```bash
$ git status -s
$ git add .
$ git commit -m "Adding Comments To Articles"
$ git push origin main
```

## Conclusion
Our Newspaper app now supports comments. We’ve added a comment model, updated the admin, and modified the templates to display and add comments. In the next section, we'll deploy the app using environment variables, PostgreSQL, and additional settings.