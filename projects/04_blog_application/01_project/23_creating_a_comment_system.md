# **Creating a comment system** 📝💬

We will continue extending our blog application with a comment system that will allow users to comment on posts. To build the comment system, we will need the following:

- 🗃️ **A Comment Model**: To save users' valuable feedback on our posts.
- 🖊️ **A Django Form**: For users to easily submit their comments, with all data validated.
- 🛠️ **A View**: To process the form and save the comments directly to our database.
- 📄 **Post Detail Template**: Display a list of existing comments and an easy-to-use form for new comments.

## 📝 Adding Comments to Your Blog

This guide walks you through creating and managing a **Comment** model in Django to store user comments on blog posts. Let's dive in step by step! 🚀

### 📦 Creating the Comment Model

To begin, open your `models.py` file and add the following code:

```python
from .models import Post

class Comment(models.Model):
    post = models.ForeignKey(
        Post,
        on_delete=models.CASCADE,
        related_name='comments'
    )
    name = models.CharField(max_length=80)
    email = models.EmailField()
    body = models.TextField()
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    active = models.BooleanField(default=True)

    class Meta:
        ordering = ['created']
        indexes = [
            models.Index(fields=['created']),
        ]

    def __str__(self):
        return f'Comment by {self.name} on {self.post}'
```

#### 🛠 Line-by-Line Explanation

1. **`from django.db import models`** 📂  
   - Imports Django's `models` module, which allows us to define database tables using Python classes.

2. **`class Comment(models.Model):`** 📝  
   - Defines a new database table named `Comment` by subclassing Django's `Model` class.

3. **`post = models.ForeignKey(...)`** 🔗  
   - Links each comment to a specific blog post using a foreign key.  
   - **`on_delete=models.CASCADE`**: Deletes all associated comments when a post is deleted.  
   - **`related_name='comments'`**: Allows accessing a post's comments using `post.comments.all()` instead of the default `post.comment_set`.

4. **`name = models.CharField(max_length=80)`** 🧑  
   - Defines a field for the commenter's name.  
   - **`max_length=80`**: Limits the name to 80 characters.

5. **`email = models.EmailField()`** 📧  
   - Stores the commenter's email address.  
   - Automatically validates the input to ensure it is a valid email format.

6. **`body = models.TextField()`** 💬  
   - Stores the main content of the comment.  
   - Allows for longer, unrestricted text compared to `CharField`.

7. **`created = models.DateTimeField(auto_now_add=True)`** ⏰  
   - Automatically sets the timestamp when a comment is created.  
   - **`auto_now_add`**: Ensures the field is only set during creation.

8. **`updated = models.DateTimeField(auto_now=True)`** 🔄  
   - Automatically updates the timestamp when the comment is edited.  
   - **`auto_now`**: Ensures the timestamp updates on every save.

9.  **`active = models.BooleanField(default=True)`** ✅  
    - A boolean field to mark comments as active or inactive.  
    - **`default=True`**: Comments are active by default.

10. **`class Meta:`** 📋  
    - Provides metadata for the model.

11. **`ordering = ['created']`** 📅  
    - Ensures comments are retrieved in chronological order by default.

12. **`indexes = [...]`** 🚀  
    - Adds an index to the `created` field for faster database queries and ordering.

13. **`def __str__(self):`** 🖋  
    - Defines a human-readable string representation for a comment.  
    - Example: `"Comment by Muhammad Hashim on Blog Post"`.

### 🛠️ Generating Database Migrations

1. **Create Migrations** 🏗️:  
   Generate migration files to reflect the changes in your database schema:  
   ```bash
   python manage.py makemigrations blog
   ```
   - This creates a migration file, e.g., `0003_comment.py`, which describes how to build the `Comment` table.

2. **Apply Migrations** 🚀:  
   Apply the migration to update your database schema:  
   ```bash
   python manage.py migrate
   ```
   - This command creates the **`blog_comment`** table in your database.

### 🎛️ Adding Comments to the Admin Panel

1. **Update `admin.py`**:  
   Add the following code to manage comments via the admin panel:  
   ```python
   from .models import Comment
   @admin.register(Comment)
   class CommentAdmin(admin.ModelAdmin):
       list_display = ['name', 'email', 'post', 'created', 'active']
       list_filter = ['active', 'created', 'updated']
       search_fields = ['name', 'email', 'body']
   ```

#### Detailed Explanation:
- **`list_display`**: Specifies fields to display in the admin interface list view.  
   Example: Displays the name, email, post title, created date, and active status.
- **`list_filter`**: Adds filter options in the admin interface.  
   Example: Allows filtering comments by active status or creation date.
- **`search_fields`**: Enables a search bar to find comments by name, email, or body content.

2. **Start the Server** 💻:  
   Run the development server:  
   ```bash
   python manage.py runserver
   ```

3. **Access the Admin Panel** 🌐:  
   - Open [http://127.0.0.1:8000/admin/](http://127.0.0.1:8000/admin/) in your browser.  
   - You will see the **Comment** model listed under the **BLOG** section.

4. **Manage Comments**:  
   - Click **Add** under **Comments** to create new comments.  
   - Activate, deactivate, or edit comments using the admin panel.  
   - Use filters and search options to streamline comment management.

---

## 📦 Creating Forms from Models

We use Django's `ModelForm` to create a form dynamically based on the `Comment` model.
#### Code for `forms.py`:

```python
from django import forms
from .models import Comment

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ['name', 'email', 'body']
```
#### 🛠 Line-by-Line Explanation:

1. **`from django import forms`** 📂  
   - Imports Django's `forms` module, which provides tools for building forms.

2. **`from .models import Comment`** 🔗  
   - Imports the `Comment` model, which is used to dynamically create the form.

3. **`class CommentForm(forms.ModelForm):`** 📝  
   - Defines a new form class named `CommentForm` that inherits from Django's `ModelForm`.  
   - `ModelForm` automatically creates form fields based on the linked model.

4. **`class Meta:`** 📋  
   - The `Meta` inner class contains configuration for the form.

5. **`model = Comment`** 🏗️  
   - Specifies the model (`Comment`) from which the form fields are generated.

6. **`fields = ['name', 'email', 'body']`** 🔍  
   - Explicitly includes only the `name`, `email`, and `body` fields in the form.  
   - Excludes fields like `created` or `updated` that are managed automatically.

#### Key Points:
- 🛠 **Dynamic Form Creation**:  
  - Django automatically maps each field in the `Comment` model to a corresponding form field.
  - For example:
    - `CharField` → `TextInput`
    - `EmailField` → `EmailInput`
    - `TextField` → `Textarea`

- 🎯 **Customizable Fields**:  
  - Use the `fields` attribute to include specific fields or the `exclude` attribute to omit fields.

🔗 **More Info**: [Django ModelForms Documentation](https://docs.djangoproject.com/en/5.0/topics/forms/modelforms/)

### 🛠 Handling Form Submissions in Views

We will create a dedicated view to handle form submissions for comments.

#### Code in `views.py`:

```python
from django.shortcuts import get_object_or_404, render
from django.views.decorators.http import require_POST
from .forms import CommentForm
from .models import Post

@require_POST
def post_comment(request, post_id):
    post = get_object_or_404(Post, id=post_id, status=Post.Status.PUBLISHED)
    comment = None
    form = CommentForm(data=request.POST)
    if form.is_valid():
        comment = form.save(commit=False)
        comment.post = post
        comment.save()
    return render(
        request,
        'blog/post/comment.html',
        {'post': post, 'form': form, 'comment': comment}
    )
```

#### 🛠 Comprehensive Line-by-Line Explanation:

1. **`from django.shortcuts import get_object_or_404, render`** 📂  
   - **`get_object_or_404`**: Fetches an object by its primary key (or raises a 404 error if not found).  
   - **`render`**: Renders a template with a given context.

2. **`from django.views.decorators.http import require_POST`** 🔒  
   - Restricts the view to handle only HTTP POST requests.  
   - Accessing the view with any other HTTP method (e.g., GET) returns a 405 error.

3. **`from .forms import CommentForm`** ✍️  
   - Imports the `CommentForm` defined earlier to handle form submissions.

4. **`from .models import Post`** 🏗️  
   - Imports the `Post` model to retrieve the blog post for which the comment is submitted.

5. **`@require_POST`** 🚦  
   - Ensures this view only processes POST requests, providing additional security.

6. **`def post_comment(request, post_id):`** 📝  
   - Defines a view named `post_comment` that takes the HTTP request and a `post_id` parameter.

7. **`post = get_object_or_404(...)`** 🔍  
   - Retrieves the blog post with the given `post_id` and ensures it has a `PUBLISHED` status.

8. **`comment = None`** ❓  
   - Initializes a variable to hold the created comment object.

9. **`form = CommentForm(data=request.POST)`** 📝  
   - Instantiates the `CommentForm` with the submitted POST data.

10. **`if form.is_valid():`** ✅  
    - Validates the form. If invalid, validation errors are passed to the template.

11. **`comment = form.save(commit=False)`** 🛠️  
    - Creates a `Comment` object but does not save it to the database yet.  
    - This allows additional modifications before saving.

12. **`comment.post = post`** 🔗  
    - Links the comment to the retrieved blog post.

13. **`comment.save()`** 💾  
    - Saves the `Comment` object to the database.

14. **`render(...)`** 🎨  
    - Renders the `blog/post/comment.html` template with the `post`, `form`, and `comment` passed as context.

### 🌐 Adding the URL Pattern

To make the `post_comment` view accessible, add a URL pattern in `urls.py`.

#### Code in `urls.py`:

```python
from django.urls import path
from . import views

app_name = 'blog'

urlpatterns = [
    path('<int:post_id>/comment/', views.post_comment, name='post_comment'),
]
```

#### 🛠 Comprehensive Line-by-Line Explanation:

1. **`from django.urls import path`** 🌐  
   - Imports Django's `path` function for defining URL patterns.

2. **`from . import views`** 🔗  
   - Imports the `views` module to link views to URLs.

3. **`app_name = 'blog'`** 🏷️  
   - Namespaces the app, allowing you to reference URLs as `blog:post_comment`.

4. **`path('<int:post_id>/comment/', ...)`** 🔗  
   - Maps the `post_comment` view to a URL pattern.  
   - `<int:post_id>` captures the blog post ID from the URL.  
   - Example: `/5/comment/` handles comments for the post with ID `5`.

---

### 📂 Setting Up the Template Structure

To manage comments, we’ll organize templates effectively. The structure will look like this:

```plaintext
templates/
 blog/
  post/
   includes/
    comment_form.html
   comment.html
   detail.html
   list.html
   share.html
```

#### 🛠 Explanation:
1. **`includes/` Directory**:
   - Contains reusable template files like `comment_form.html` for shared components.
   - The **`{% include %}`** tag dynamically includes these files in other templates.

2. **Key Templates**:
   - **`comment_form.html`**: Displays the comment form.
   - **`comment.html`**: Handles form submissions for adding comments.
   - **`detail.html`**: Displays blog post details, including comments and the comment form.

### ✍️ Creating the `comment_form.html` Template

#### Code for `comment_form.html`:

```html
<h2>Add a new comment</h2>
<form action="{% url "blog:post_comment" post.id %}" method="post">
    {{ form.as_p }}
    {% csrf_token %}
    <p><input type="submit" value="Add comment"></p>
</form>
```

#### 🛠 Line-by-Line Explanation:

1. **`<h2>Add a new comment</h2>`** 📝  
   - Displays the heading above the form to indicate its purpose.

2. **`<form action="{% url "blog:post_comment" post.id %}" method="post">`** 🔗  
   - Defines the HTML `<form>` element.  
   - **`action`**: Builds the form submission URL dynamically using the **`{% url %}`** tag, linking it to the `post_comment` view.  
   - **`post.id`**: Passes the ID of the current post to the `post_comment` view.  
   - **`method="post"`**: Specifies the HTTP POST method, required for submitting data.

3. **`{{ form.as_p }}`** 📄  
   - Renders the form fields as HTML `<p>` elements.  
   - Automatically includes field labels, input boxes, and validation messages.

4. **`{% csrf_token %}`** 🔒  
   - Inserts a CSRF token for security, ensuring only trusted forms can submit data.

5. **`<p><input type="submit" value="Add comment"></p>`** 🚀  
   - Adds a submit button for the form.  
   - **`value="Add comment"`**: Sets the button text.


### ✨ Creating the `comment.html` Template

This template handles the **`post_comment`** view and displays success or error messages.

#### Code for `comment.html`:

```html
{% extends "blog/base.html" %}
{% block title %}Add a comment{% endblock %}
{% block content %}
    {% if comment %}
        <h2>Your comment has been added.</h2>
        <p><a href="{{ post.get_absolute_url }}">Back to the post</a></p>
    {% else %}
        {% include "blog/post/includes/comment_form.html" %}
    {% endif %}
{% endblock %}
```

#### 🛠 Line-by-Line Explanation:

1. **`{% extends "blog/base.html" %}`** 🌐  
   - Inherits the base blog template for consistent styling and layout.

2. **`{% block title %}Add a comment{% endblock %}`** 📝  
   - Sets the page title to "Add a comment."

3. **`{% block content %}`** 📄  
   - Defines the main content section of the template.

4. **`{% if comment %}`** ✅  
   - Checks if the form submission was successful (i.e., a `comment` object exists).

5. **`<h2>Your comment has been added.</h2>`** 🎉  
   - Displays a success message if the comment was added successfully.

6. **`<p><a href="{{ post.get_absolute_url }}">Back to the post</a></p>`** 🔗  
   - Provides a link to return to the blog post's detail page using the `post.get_absolute_url` method.

7. **`{% else %}`** ❌  
   - Handles the case where the form submission is invalid or contains errors.

8. **`{% include "blog/post/includes/comment_form.html" %}`** 🛠️  
   - Reuses the `comment_form.html` template to display the form again with validation errors.

### 📜 Updating the `post_detail` View

To integrate comments into the post detail view, update the `post_detail` function in `views.py`.

#### Updated Code in `views.py`:

```python
def post_detail(request, year, month, day, post):
    post = get_object_or_404(
        Post,
        status=Post.Status.PUBLISHED,
        slug=post,
        publish__year=year,
        publish__month=month,
        publish__day=day
    )
    # List of active comments for this post
    comments = post.comments.filter(active=True)
    # Form for users to comment
    form = CommentForm()
    return render(
        request,
        'blog/post/detail.html',
        {
            'post': post,
            'comments': comments,
            'form': form
        }
    )
```

#### 🛠 Line-by-Line Explanation:

1. **`post = get_object_or_404(...)`** 🔍  
   - Fetches the blog post with the specified parameters (slug, date, and status).  
   - Returns a 404 error if the post is not found or not published.

2. **`comments = post.comments.filter(active=True)`** ✅  
   - Retrieves all active comments for the post using the `related_name='comments'` defined in the `Comment` model.

3. **`form = CommentForm()`** 📝  
   - Creates a blank instance of the `CommentForm` for users to add new comments.

4. **`return render(...)`** 🎨  
   - Renders the `blog/post/detail.html` template, passing the `post`, `comments`, and `form` as context.

### 🎨 Updating the `detail.html` Template

To display comments and the form in the post detail page, edit the `detail.html` template.

#### Updated Code in `detail.html`:

```html
{% with comments.count as total_comments %}
<h2>
    {{ total_comments }} comment{{ total_comments|pluralize }}
</h2>
{% endwith %}

{% for comment in comments %}
<div class="comment">
    <p class="info">
        Comment {{ forloop.counter }} by {{ comment.name }}
        {{ comment.created }}
    </p>
    {{ comment.body|linebreaks }}
</div>
{% empty %}
<p>There are no comments.</p>
{% endfor %}

{% include "blog/post/includes/comment_form.html" %}
```

#### 🛠 Line-by-Line Explanation:

1. **`{% with comments.count as total_comments %}`** 🧮  
   - Counts the total number of comments and assigns it to the variable `total_comments`.

2. **`{{ total_comments|pluralize }}`** 📊  
   - Displays "comment" or "comments" based on the count value.

3. **`{% for comment in comments %}`** 🔄  
   - Loops through the list of comments.

4. **`{{ forloop.counter }}`** 🧾  
   - Displays the current iteration number (e.g., "Comment 1", "Comment 2").

5. **`{{ comment.name }}`** 🧑  
   - Displays the name of the commenter.

6. **`{{ comment.body|linebreaks }}`** 📝  
   - Displays the comment text, converting line breaks to HTML `<br>` tags.

7. **`{% empty %}`** ❌  
   - Handles cases where there are no comments, displaying a placeholder message.

8. **`{% include "blog/post/includes/comment_form.html" %}`** 🛠️  
   - Includes the reusable `comment_form.html` template for adding a new comment.

### 🧑‍🎨 Customizing Form Rendering

You can use custom HTML to style form fields instead of relying on `{{ form.as_p }}`.

#### Example Code:

```html
{% for field in form %}
<div class="my-div">
    {{ field.errors }}
    {{ field.label_tag }} {{ field }}
    <div class="help-text">{{ field.help_text|safe }}</div>
</div>
{% endfor %}
```

#### 🛠 Explanation:
1. **`{{ field.errors }}`** ❌  
   - Displays validation errors for the field.

2. **`{{ field.label_tag }}`** 🏷️  
   - Renders the field's label as an HTML `<label>`.

3. **`{{ field }}`** 📝  
   - Renders the input field itself.

4. **`{{ field.help_text|safe }}`** 🛟  
   - Renders help text for the field.


>**Regards Muhammad Hashim**