# Permissions and Authorization
Our current Newspaper website has several issues, particularly regarding financial sustainability and user access control. While we can consider adding a dedicated payments app in the future, our immediate goal is to implement permissions and authorization features. This section will explore how to require users to log in to view articles and ensure that only the author of an article can edit or delete it.

## Improved CreateView

### Problem
Currently, the author of a new article can be set to any existing user. This is not ideal as it should automatically be set to the currently logged-in user.

### Solution
We can modify Django’s `CreateView` to automatically set the author to the currently logged-in user by removing the `author` field and setting it via the `form_valid` method.

### Implementation

```python
# articles/views.py
class ArticleCreateView(CreateView):
    model = Article
    template_name = "article_new.html"
    fields = ("title", "body")  # new

    def form_valid(self, form):  # new
        form.instance.author = self.request.user
        return super().form_valid(form)
```

### Explanation
The `form_valid` method is overridden to set the `author` field to the currently logged-in user. This customization is possible by understanding the source code of Django’s class-based views, which can be explored using [Classy Class-Based Views](https://ccbv.co.uk/), a valuable resource that breaks down how each generic class-based view works in Django.

After implementing this, reload your browser and click on the “+ New” link in the top navigation bar. You will be redirected to the updated create page where the author is no longer a field. Upon creating a new article, it will automatically be set to the currently logged-in user.

## Authorizations

### Problem
There are multiple issues related to the lack of authorizations. We want to restrict access to specific parts of the site to logged-in users only.

### Test Scenario
To test what happens when a logged-out user tries to create a new article:
1. Log out from your account.
2. Try accessing the URL directly: `http://127.0.0.1:8000/articles/new/`.

You will notice that the page is still accessible, and attempting to create a new article will result in an error because the `author` field is required, but since the user is logged out, there’s no author.

## Mixins for Authorization
We want to set some authorizations so only logged-in users can access specific URLs. To do this, we can use a mixin, a special kind of multiple inheritance that Django uses to avoid duplicate code and still allow customization. For example, the built-in generic ListView192 needs a way to return a template. But so does DetailView193 and almost every other view. Rather than repeat the same code in each big generic view, Django breaks out this functionality into a mixin known as [Class Base Generic](https://docs.djangoproject.com/en/5.0/ref/class-based-views/generic-display/#django.views.generic.list)  and  [ListView](https://docs.djangoproject.com/en/5.0/ref/class-based-views/generic-display/#detailview). You’ll see mixins used everywhere if you read the Django source code, which is freely available on Github. To restrict view access to only logged-in users, Django has a LoginRequired mixin that we can use. It’s powerful and extremely concise. In the articles/views.py file, import LoginRequiredMixin and add it to ArticleCreateView. Make sure that the mixin is to the left of CreateView so it will be read first. We want the CreateView to know we intend to restrict access. And that’s it! We’re done.


### Solution
To ensure only logged-in users can access specific URLs, we use Django’s `LoginRequiredMixin`.

### Implementation

```python
# articles/views.py
from django.contrib.auth.mixins import LoginRequiredMixin
from django.views.generic import ListView, DetailView

class ArticleCreateView(LoginRequiredMixin, CreateView):  # new
    model = Article
    template_name = "article_new.html"
    fields = ("title", "body")

    def form_valid(self, form):
        form.instance.author = self.request.user
        return super().form_valid(form)
```

### Explanation
By adding `LoginRequiredMixin` to the `ArticleCreateView`, we ensure that only logged-in users can access the article creation page. When a logged-out user tries to access this page, they will be redirected to the login page.

The complete views.py file should now look like this:

```python
# articles/views.py
from django.views.generic import ListView, DetailView  # new
from django.views.generic.edit import UpdateView, DeleteView, CreateView  # new
from django.urls import reverse_lazy  # new
from .models import Article
from django.contrib.auth.mixins import LoginRequiredMixin  # new


class ArticleCreateView(LoginRequiredMixin, CreateView):
    model = Article
    template_name = "article_new.html"
    fields = ("title", "body")  # new

    def form_valid(self, form):  # new
        form.instance.author = self.request.user
        return super().form_valid(form)

class ArticleListView(ListView):
    model = Article
    template_name = "article_list.html"

class ArticleDetailView(DetailView):  # new
    model = Article
    template_name = "article_detail.html"

class ArticleUpdateView(UpdateView):  # new
    model = Article
    fields = (
        "title",
        "body",
    )
    template_name = "article_edit.html"

class ArticleDeleteView(DeleteView):  # new
    model = Article
    template_name = "article_delete.html"
    success_url = reverse_lazy("article_list")
```

## Restricting Access to Other Views

### Problem
We need to restrict access to the other views like `ListView`, `DetailView`, `UpdateView`, and `DeleteView` to logged-in users.

###  Complete Code Implementation articles/views.py

```python
# articles/views.py
from django.views.generic import ListView, DetailView  # new
from django.views.generic.edit import UpdateView, DeleteView, CreateView  # new
from django.urls import reverse_lazy  # new
from .models import Article
from django.contrib.auth.mixins import LoginRequiredMixin  # new

class ArticleCreateView(LoginRequiredMixin, CreateView):
    model = Article
    template_name = "article_new.html"
    fields = ("title", "body")  # new

    def form_valid(self, form):  # new
        form.instance.author = self.request.user
        return super().form_valid(form)

class ArticleListView(LoginRequiredMixin, ListView):  # new
    model = Article
    template_name = "article_list.html"

class ArticleDetailView(LoginRequiredMixin, DetailView):  # new
    model = Article
    template_name = "article_detail.html"

class ArticleUpdateView(LoginRequiredMixin, UpdateView):  # new
    model = Article
    fields = ("title", "body",)
    template_name = "article_edit.html"

class ArticleDeleteView(LoginRequiredMixin, DeleteView):  # new
    model = Article
    template_name = "article_delete.html"
    success_url = reverse_lazy("article_list")
```

### Explanation
The `LoginRequiredMixin` is added to all views to restrict access to logged-in users only. Play around with the site to confirm that the redirect to the login page works as expected.

## UpdateView and DeleteView Authorization
We’re progressing, but our edit and delete views are still an issue. Any logged-in user can change any article, but we want to restrict this access so that only the article’s author has this permission. We could add permissions logic to each view for this, but a more elegant solution is to create a dedicated mixin, a class with a particular feature we want to reuse in our Django code. And better yet, Django ships with a built-in mixin, [UserPassesTestMixin](https://docs.djangoproject.com/en/5.0/topics/auth/default/#django.contrib.auth.mixins.UserPassesTestMixin), just for this purpose! To use UserPassesTestMixin, first, import it at the top of the articles/views.py file and then
add it to both the update and delete views where we want this restriction. The test_func method is used by UserPassesTestMixin for our logic; we need to override it. In this case, we set the variable obj to the current object returned by the view using get_object(). Then we say, if the author on the current object matches the current user on the webpage (whoever is logged in and trying to make the change), then allow it. If false, an error will automatically be thrown.

### Problem
We want to restrict the ability to edit or delete an article to only its author.

### Solution
To achieve this, we use Django’s `UserPassesTestMixin`.

### Implementation

```python
# articles/views.py
from django.contrib.auth.mixins import (
    LoginRequiredMixin,
    UserPassesTestMixin  # new
)
from django.views.generic import ListView, DetailView
from django.views.generic.edit import UpdateView, DeleteView, CreateView
from django.urls import reverse_lazy
from .models import Article

class ArticleUpdateView(LoginRequiredMixin, UserPassesTestMixin, UpdateView):  # new
    model = Article
    fields = ("title", "body",)
    template_name = "article_edit.html"

    def test_func(self):  # new
        obj = self.get_object()
        return obj.author == self.request.user

class ArticleDeleteView(LoginRequiredMixin, UserPassesTestMixin, DeleteView):  # new
    model = Article
    template_name = "article_delete.html"
    success_url = reverse_lazy("article_list")

    def test_func(self):  # new
        obj = self.get_object()
        return obj.author == self.request.user
```
The order is critical when using mixins with class-based views. LoginRequiredMixin comes first so that we force login, then add UserPassesTestMixin for an additional layer of functionality, and finally, either UpdateView or DeleteView. The code will only work properly if you have this order.log in with your testuser account and go to the articles list page. If the code works, you should not be able to edit or delete any posts written by your superuser account; instead, you will see a Permission Denied 403 error page.

### Explanation
The `test_func` method in `UserPassesTestMixin` is overridden to check if the logged-in user is the author of the article. If not, access is denied.

## Template Logic

### Problem
We need to hide the edit and delete links from users who are not the author of the article.

### Solution
Add simple logic to the templates to restrict the display of these links.

### Implementation
code article_list.html
```html
<!-- templates/article_list.html -->
<div class="card-footer text-center text-muted">
    {% if article.author.pk == request.user.pk %}
        <a href="{% url 'article_edit' article.pk %}">Edit</a>
        <a href="{% url 'article_delete' article.pk %}">Delete</a>
    {% endif %}
</div>
```
code article_detail.html
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
    {% if article.author.pk == request.user.pk %}
        <p><a href="{% url 'article_edit' article.pk %}">Edit</a>
        <a href="{% url 'article_delete' article.pk %}">Delete</a></p>
    {% endif %}
    <p>Back to <a href="{% url 'article_list' %}">All Articles</a>.</p>
</div>
{% endblock content %}
```

### Explanation
By adding an `if` condition in the templates, the edit and delete links are only visible to the article’s author.

## Conclusion

Our Newspaper app now has essential permissions and authorizations in place, ensuring that only logged-in users can view, create, edit, or delete articles. We have also restricted access to certain functionalities based on the logged-in user's role. The last item to implement is the ability for logged-in users to leave comments, which will be covered in the next section.

## Git Commands

```bash
$ git status -s
$ git add .
$ git commit -m "Permissions and Authorizations"
$ git push origin main
```

In the `.gitignore` file, make sure to include the following:

```plaintext
Pipfile
Pipfile.lock
db.sqlite3
pycache
```

### Conclusion
Our newspaper app is almost done. We could take further steps at this point, such as only displaying edit and delete links to the appropriate users, which would involve custom template tags,but overall, the app is in good shape. Our articles are correctly configured, set permissions and
authorizations, and have a working user authentication flow. The last item needed is the ability
for fellow logged-in users to leave comments, which we’ll cover in the next section

