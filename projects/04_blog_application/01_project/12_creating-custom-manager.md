#  📘 **Creating Custom Model Managers** ✨

Django allows you to define custom managers to extend or modify how queries are made for a model. A manager provides an interface through which database operations can be performed. This guide will explain how to create and use a **custom manager** for filtering posts with a `PUBLISHED` status.

---

## 📚 Table of Contents

1. ✨ [What Are Model Managers?](#-what-are-model-managers)  
2. 🛠 [Creating a Custom Manager](#-creating-a-custom-manager)  
3. 🔍 [Testing the Custom Manager](#-testing-the-custom-manager)  
4. 🌟 [Default vs. Custom Managers](#-default-vs-custom-managers)  
5. 📘 [Practical Example](#-practical-example)  

---

## ✨ What Are Model Managers?

A **model manager** in Django is the interface through which database query operations are provided to a model. By default, every Django model comes with a default manager named `objects`.

### Why Create a Custom Manager?
- Simplify common query patterns.
- Add reusable, model-specific functionality to your queries.
- Customize the default `QuerySet` returned for a model.

---

## 🛠 Creating a Custom Manager

### Step 1: Define a Custom Manager Class
- Create a new manager by inheriting from `models.Manager`.
- Override the `get_queryset()` method to customize the query logic.

### Step 2: Add the Custom Manager to Your Model
- Explicitly include the `objects` manager if you want to retain it.
- Add your custom manager to the model.

### Updated Code for `models.py`:
```python
from django.db import models

class PublishedManager(models.Manager):
    def get_queryset(self):
        # Return only posts with PUBLISHED status
        return super().get_queryset().filter(status=Post.Status.PUBLISHED)

class Post(models.Model):
    class Status(models.TextChoices):
        DRAFT = 'DF', 'Draft'
        PUBLISHED = 'PB', 'Published'

    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    author = models.ForeignKey('auth.User', on_delete=models.CASCADE)
    body = models.TextField()
    publish = models.DateTimeField()
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    status = models.CharField(max_length=2, choices=Status.choices, default=Status.DRAFT)

    # Managers
    objects = models.Manager()  # Default manager
    published = PublishedManager()  # Custom manager

    class Meta:
        ordering = ['-publish']
        indexes = [
            models.Index(fields=['-publish']),
        ]

    def __str__(self):
        return self.title
```

---

## 🔍 Testing the Custom Manager

### Step 1: Start the Django Shell
```bash
python manage.py shell
```

### Step 2: Test Queries Using the Custom Manager
1. **Retrieve all published posts:**
   ```python
   from blog.models import Post
   posts = Post.published.all()  # Only posts with status=PUBLISHED
   print(posts)
   ```

2. **Filter published posts by title:**
   ```python
   published_posts = Post.published.filter(title__startswith='Who')
   print(published_posts)
   ```

### Key Notes:
- The `get_queryset()` method in the custom manager ensures that the `published` manager always returns posts with a `PUBLISHED` status.
- To test this, ensure you have posts in the database with `status=PUBLISHED`.

---

## 🌟 Default vs. Custom Managers

1. **Default Manager (`objects`)**
   - Always available unless explicitly removed.
   - Returns all objects in the database.

2. **Custom Manager (`published`)**
   - Custom logic defined in `get_queryset()` to filter objects.
   - Example: Only returns posts with `status=PUBLISHED`.

### Explicit Default Manager
If you define custom managers, you must explicitly include the default `objects` manager if you want to retain it.

---

## 📘 Practical Example

### Scenario: Using Both Default and Custom Managers

#### Create a Post in the Shell:
```python
>>> from django.contrib.auth.models import User
>>> from blog.models import Post

>>> user = User.objects.get(username='admin')
>>> post = Post.objects.create(
...     title='Published Post',
...     slug='published-post',
...     body='This is a published post.',
...     author=user,
...     status=Post.Status.PUBLISHED
... )
```

#### Retrieve All Posts:
```python
>>> Post.objects.all()
<QuerySet [<Post: Published Post>]>
```

#### Retrieve Published Posts Only:
```python
>>> Post.published.all()
<QuerySet [<Post: Published Post>]>
```

---

## 🌟 How Custom Managers Work

### `get_queryset()` Method
- Defines the default behavior of the manager.
- The `PublishedManager` filters posts by `status=Post.Status.PUBLISHED`.

### Why Use a Custom Manager?
1. Encapsulate logic within the manager instead of repeating it in views or queries.
2. Provide a clean API:
   ```python
   Post.published.all()  # Explicitly retrieves only published posts.
   ```

---

## 🌐 Additional Resources

- 📖 **Django Managers Documentation**: [Official Docs](https://docs.djangoproject.com/en/5.0/topics/db/managers/)  
- 📘 **QuerySet API Reference**: [Django QuerySets](https://docs.djangoproject.com/en/5.0/ref/models/querysets/)  

