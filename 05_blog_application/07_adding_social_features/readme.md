# **Enhancing Your Blog and Adding Social Features** 🚀✨

In the previous section, we built a **simple blog application** using **Django views, templates, and URLs**. Now, we will **enhance** our blog by adding **modern blogging features** that are common in popular blogging platforms. 📖💡

---

## **What You Will Learn in This Section** 🛠️📌

- **Using Canonical URLs for Models** 🌍
- **Creating SEO-Friendly URLs for Posts** 🔍
- **Adding Pagination to the Post List View** 📄
- **Building Class-Based Views** 🏗️
- **Sending Emails with Django** 📧
- **Using Django Forms to Share Posts via Email** 🔗
- **Adding Comments to Posts Using Model-Based Forms** 💬

<div align="center">

# `New Section Functional Overview`

</div>

# **Functional Overview of Enhancements** 🚀✨

In this section we will expand our **Django blog application** by adding **new functionalities** that enhance user interaction and navigation. The **diagram below illustrates** the key features that will be implemented. 📖💡

<div align="center">
  <img src="./images/comments_system.jpg" alt="Comment System" width="600px"/>

  **Figure 2.1**: Diagram of functionalities built in this section.

</div>

---

## **What We Will Build in This Chapter** 🛠️📌

### **1️⃣ Pagination for Post List View** 📄
- We will implement **pagination** to split the post list into multiple pages.
- This will improve **performance and user experience** when browsing blog posts.

### **2️⃣ Class-Based Views** 🏗️
- We will refactor the existing **post_list view** into a **class-based view**.
- Class-based views provide a more **structured and reusable** approach compared to function-based views.
- The new view will be called **PostListView**.

### **3️⃣ Sharing Posts via Email** 📧
- We will create the **post_share view** to allow users to **share posts via email**.
- Django’s **forms and SMTP (Simple Mail Transfer Protocol)** will be used to send recommendations.
- Users will be able to send **post links** to their friends directly from the blog.

### **4️⃣ Adding a Comment System** 💬
- We will build a **Comment model** to store comments for blog posts.
- A **post_comment view** will be implemented to allow users to leave comments.
- Django’s **model-based forms** will be used to handle user input.


<div align="center">

# `New Section Using Canonical URLs for Models`

</div>

# **Using Canonical URLs for Models** 🌍✨

A website may have **multiple pages displaying the same content**. In our blog application, each post's **initial content** is displayed on both the **post list page** and the **post detail page**. To **identify a preferred URL** for a resource, we use **canonical URLs**.

A **canonical URL** is the **main representative URL** for specific content. Even though posts might be displayed in different sections of the site, there should be **one primary URL** that acts as the **definitive** reference for that post. 🏷️

---

## **Why Canonical URLs Matter?** 🔍
- Prevents **duplicate content issues** in search engines.
- Ensures **better SEO ranking** by defining a single, authoritative URL.
- Helps users and crawlers **navigate efficiently**.

---

## **Implementing Canonical URLs in Django** 🛠️
Django allows us to implement the **`get_absolute_url()`** method in our models. This method **returns the canonical URL** for an object, ensuring that each post has a single, primary URL reference.

We will **build the canonical URL** using the `post_detail` URL pattern of the application. Django provides **URL resolver functions** to dynamically generate URLs. For this, we use the **`reverse()`** function from `django.urls`.

### **Editing `models.py` to Add Canonical URLs** 📝
Modify the `models.py` file of the blog application to:
✅ **Import the `reverse()` function**.
✅ **Add the `get_absolute_url()` method to the `Post` model**.

```python
from django.conf import settings
from django.db import models
from django.urls import reverse  # ✅ Import reverse
from django.utils import timezone

class PublishedManager(models.Manager):
    def get_queryset(self):
        return super().get_queryset().filter(status=Post.Status.PUBLISHED)

class Post(models.Model):
    # ... (existing fields)
    
    class Meta:
        ordering = ['-publish']
        indexes = [
            models.Index(fields=['-publish']),
        ]
    
    def __str__(self):
        return self.title

    def get_absolute_url(self):  # ✅ Define the canonical URL
        return reverse(
            'blog:post_detail',  # ✅ Uses post_detail from blog namespace
            args=[self.id]  # ✅ Passes the post ID as an argument
        )
```

---

## **Understanding the `reverse()` Function 🔄**
Django’s `reverse()` function **dynamically generates URLs** based on the **URL name** defined in `urls.py`. 

📌 **Key Points:**
- **`'blog:post_detail'`** refers to the `post_detail` URL inside the **blog namespace**.
- The **post ID (`self.id`)** is passed as an argument using `args=[self.id]`.
- This ensures that **every post has a unique, SEO-friendly URL**.

📌 **Example Usage:**
```python
post = Post.objects.get(id=5)
print(post.get_absolute_url())  # Output: /blog/5/
```

---

## **Where is `post_detail` Defined? 📌**
The `post_detail` URL is defined in `urls.py`:
```python
urlpatterns = [
    path('<int:id>/', views.post_detail, name='post_detail'),
]
```

### **How URLs Are Built** 🏗️
| URL Namespace | URL Name | Example Output |
|--------------|---------|---------------|
| `blog`       | `post_detail` | `/blog/5/` |

Since the **blog namespace** is defined when including `blog.urls` in the project’s `urls.py`, the resulting URL reference **can be used globally across the project**.

<div align="center">

# `New Section Updating Post Detail URLs`

</div>

# **Updating Post Detail URLs in Templates** 🌐✨

Now that we have implemented **canonical URLs** using the `get_absolute_url()` method, we need to **update our templates** to use this method instead of hardcoding the URL with `{% url 'blog:post_detail' post.id %}`. 🎯

This ensures that our blog posts always reference the **canonical URL dynamically**, making our project **more maintainable and structured**. 🏗️

---

## **Updating the Template** 📝

### **Modify `blog/post/list.html`**
Edit the `blog/post/list.html` file and replace the existing post detail link:

❌ **Old Code:**
```html
<a href="{% url 'blog:post_detail' post.id %}">
```
✅ **New Code (Using `get_absolute_url()`):**
```html
<a href="{{ post.get_absolute_url }}"> {% comment %} added here {% endcomment %}
```

### **Updated `blog/post/list.html` File:**
```html
{% extends "blog/base.html" %}
{% block title %}My Blog{% endblock %}
{% block content %}
 <h1>My Blog</h1>
 {% for post in posts %}
 <h2>
 <a href="{{ post.get_absolute_url }}"> {% comment %} absolute url {% endcomment %}
 {{ post.title }}
 </a>
 </h2>
 <p class="date">
 Published {{ post.publish }} by {{ post.author }}
 </p>
 {{ post.body|truncatewords:30|linebreaks }}
 {% endfor %}
{% endblock %}
```

---

## **Testing the Changes 🛠️**
To ensure everything works correctly, **start the Django development server** by running the following command:

```bash
python manage.py runserver
```

### **Verify in the Browser** 🖥️
- Open your web browser and go to: 
  **[http://127.0.0.1:8000/blog/](http://127.0.0.1:8000/blog/)**
- Click on any **blog post title**.
- The links should now be **correctly built using `get_absolute_url()`**.


<div align="center">

# `New Section Creating SEO-Friendly URLs`

</div>


# **Creating SEO-Friendly URLs for Posts** 🔍✨

The current **canonical URL** for a blog post detail view looks like:

```plaintext
/blog/1/
```

This format is **not SEO-friendly** because it lacks meaningful keywords that search engines use for indexing. To **improve search engine rankings**, we will modify the **URL structure** to include the **publish date** and **slug**.

For example, a new **SEO-friendly URL** will look like:

```plaintext
/blog/2025/1/1/python-deep-dive/
```

This new format will make **URLs more informative** and **search engine-friendly**, as they include both the **title** and **date of publication**.

---

## **Ensuring Unique Slugs for Each Post** 🔄

To **retrieve posts** using a combination of **publish date** and **slug**, we need to ensure that **no post** in the database has the **same slug and publish date** as another post.

We will enforce this **uniqueness constraint** by modifying the `Post` model to ensure that slugs are unique for a given publication date.

### **Editing ********`models.py`******** to Enforce Unique Slugs** 🛠️

Modify the `Post` model in `models.py` to include the **`unique_for_date`** constraint for the `slug` field.

```python
class Post(models.Model):
    # ... (existing fields)
    
    slug = models.SlugField(
        max_length=250,
        unique_for_date='publish'  # ✅ Ensure slugs are unique per publication date
    )
    
    # ... (other fields and methods)
```

### **What Does ********`unique_for_date`******** Do? 🤔**

✅ Ensures that **no two posts** can have the **same slug on the same publish date**.
✅ Prevents **duplicate posts** in the database.
✅ Works at the **Django model level**, not at the **database level**.
✅ Applies uniqueness check **only to the date**, ignoring the time portion of `DateTimeField`.

Now, Django will **automatically prevent duplicate slugs** for posts published on the same date. 📆✨

---

## **Applying Model Changes with Migrations** 📜

Since we have **modified the model**, we need to **create migrations**. However, note that `unique_for_date` is **not enforced at the database level**, so no actual database modification is needed.

### **Step 1: Create the Migration** ⚙️

Run the following command in the shell prompt:

```bash
python manage.py makemigrations blog
```

**Expected Output:**

```plaintext
Migrations for 'blog':
  blog/migrations/0002_alter_post_slug.py
  - Alter field slug on post
```

Django has generated the **0002\_alter\_post\_slug.py** file inside the **migrations directory**.

### **Step 2: Apply the Migration** ✅

To apply the migration, run:

```bash
python manage.py migrate
```

**Expected Output:**

```plaintext
Applying blog.0002_alter_post_slug... OK
```

Even though **no actual database change occurs**, Django **tracks model changes** through migrations to ensure consistency.

<div align="center">

# `New Section SEO-Friendly URLs`

</div>

# **Modifying the URL Patterns for SEO-Friendly URLs** 🌍✨

To make our **blog post URLs SEO-friendly**, we need to modify the **post detail URL pattern** so that it includes **the publication date and slug** instead of just the post ID. This will make our URLs **more readable, structured, and optimized for search engines**. 🔍📈

For example, instead of:

```plaintext
/blog/1/
```

We will now have:

```plaintext
/blog/2024/1/27/python-deep-dive/
```

This will help search engines and users understand the **context** of the post just by looking at the URL. 🚀

---

## **Updating the URL Patterns** 🛠️

We need to **modify** the `urls.py` file inside the `blog` application.

### **Old Code:** ❌

```python
path('<int:id>/', views.post_detail, name='post_detail'),
```

### **New Code (SEO-Friendly URLs):** ✅

```python
path(
    '<int:year>/<int:month>/<int:day>/<slug:post>/',  # ✅ Updated URL pattern
    views.post_detail,
    name='post_detail'
),
```

### **Updated ****************`urls.py`**************** File:** 📌

```python
from django.urls import path
from . import views

app_name = 'blog'

urlpatterns = [
    # Post views
    path('', views.post_list, name='post_list'),
    path(
        '<int:year>/<int:month>/<int:day>/<slug:post>/',  # ✅ New SEO-friendly pattern
        views.post_detail,
        name='post_detail'
    ),
]
```

---

## **Understanding the New URL Pattern** 📖

The new **post detail URL pattern** takes the following parameters:

- **`year`** 🗓️ → Requires an **integer** (`int`) to specify the **year** of publication.
- **`month`** 📆 → Requires an **integer** (`int`) to specify the **month** of publication.
- **`day`** 🕒 → Requires an **integer** (`int`) to specify the **day** of publication.
- **`post`** 🔖 → Requires a **slug** (`slug`) which contains only **letters, numbers, underscores, or hyphens**.

### **Django Path Converters Used** 🔄

| Path Converter | Description                                        |
| -------------- | -------------------------------------------------- |
| `int`          | Matches an integer value (e.g., `2025`, `1`, `27`) |
| `slug`         | Matches a slug (e.g., `python-deep-dive`)  |

To learn more about **path converters in Django**, visit:
🔗 [Django Path Converters Documentation](https://docs.djangoproject.com/en/5.0/topics/http/urls/#path-converters)

<div align="center">

# `New Section post_detail View to Match SEO-Friendly URLs`

</div>

# **Modifying the `post_detail` View to Match SEO-Friendly URLs** 🛠️✨

To ensure that our **post_detail view** matches the **new SEO-friendly URL structure**, we need to update its parameters. The view should now accept **year, month, day, and post (slug)** to correctly retrieve the **corresponding blog post**. 📆🔍

---

## **Updating the `post_detail` View** 📝
Edit the `views.py` file inside the **blog application** and update the `post_detail` view as follows:

### **Old Code (Before SEO-Friendly URLs)** ❌
```python
def post_detail(request, id):
    post = get_object_or_404(Post, id=id, status=Post.Status.PUBLISHED)
    return render(request, 'blog/post/detail.html', {'post': post})
```

### **New Code (After Updating to SEO-Friendly URLs)** ✅
```python
from django.shortcuts import get_object_or_404, render
from .models import Post

def post_detail(request, year, month, day, post):  # ✅ Updated parameters
    post = get_object_or_404(
        Post,
        status=Post.Status.PUBLISHED,
        slug=post,  # ✅ Match post slug
        publish__year=year,  # ✅ Match year of publication
        publish__month=month,  # ✅ Match month of publication
        publish__day=day  # ✅ Match day of publication
    )
    return render(
        request,
        'blog/post/detail.html',
        {'post': post}
    )
```

---

## **Understanding the Changes in `post_detail`** 🧐

- **✅ Added `year, month, day, and post` as parameters**: 
  - These match the **new URL structure** to fetch the correct post.
- **✅ Used `slug=post`**: 
  - Instead of fetching by `id`, we now use the **slug field**.
- **✅ Filtered posts by `publish__year`, `publish__month`, and `publish__day`**: 
  - Ensures that posts are retrieved based on their **exact publication date**.
- **✅ Only retrieves posts with `status=Post.Status.PUBLISHED`**: 
  - This prevents fetching drafts or unpublished posts.

---

## **How `get_object_or_404` Works in This Context** 🔍🛠️

The function `get_object_or_404()` is a **Django shortcut** that attempts to retrieve an object from the database using the given parameters. If the object does **not** exist, Django **automatically raises a 404 error** (`Http404` exception), returning an HTTP 404 response.

### **Breaking Down the Parameters Inside `get_object_or_404()`** 🧐
```python
post = get_object_or_404(
    Post,  # ✅ Model to query
    status=Post.Status.PUBLISHED,  # ✅ Filter posts that are published only
    slug=post,  # ✅ Match the post's slug
    publish__year=year,  # ✅ Match the exact year of publication
    publish__month=month,  # ✅ Match the exact month of publication
    publish__day=day  # ✅ Match the exact day of publication
)
```
### **How It Works Step by Step** 📌
1️⃣ **Queries the `Post` model** to fetch a post matching the given filters.
2️⃣ **Filters by `status=Post.Status.PUBLISHED`** to ensure only published posts are retrieved.
3️⃣ **Filters by `slug=post`** to match the requested slug.
4️⃣ **Filters by `publish__year`, `publish__month`, and `publish__day`**:
   - Ensures the retrieved post has the exact **date of publication** as specified in the URL.
5️⃣ **If a post exists that meets all these conditions**, it is returned.
6️⃣ **If no post is found**, Django **automatically raises an HTTP 404 error** (instead of returning `None` or causing an error later in the view).

### **Why Use `get_object_or_404()` Instead of `get()`?** 🤔
✅ **Avoids writing manual error handling**
✅ **Automatically raises a proper 404 response**
✅ **Reduces unnecessary try/except blocks**
✅ **Enhances user experience by properly handling missing content**

---

## **How Does This Work? 🤔**
1️⃣ **User Requests a Blog Post**
   - Example URL: `/blog/2024/1/1/who-was-django-reinhardt/`

2️⃣ **Django Matches the URL to `post_detail` View**
   - Extracts **year, month, day, and slug** from the URL.

3️⃣ **Django Fetches the Post from the Database**
   - Looks for a **published post** that matches the given **date and slug**.

4️⃣ **Renders the `blog/post/detail.html` Template**
   - Displays the requested **blog post details**.


<div align="center">

# `New Section Modifying the Canonical URL`

</div>

# **Modifying the Canonical URL for Posts** 🌍✨
To fully align with the new **SEO-friendly URL structure**, we need to update the `get_absolute_url()` method in our **Post model**. This ensures that the canonical URL of each post now includes the **publication date** (year, month, and day) along with the **slug**. 📆🔗

---

## **Updating the `get_absolute_url()` Method** 📝
Edit the `models.py` file inside the **blog application** and modify the `get_absolute_url()` method as follows:

### **Old Code (Before SEO-Friendly URLs)** ❌
```python
def get_absolute_url(self):
    return reverse('blog:post_detail', args=[self.id])
```

### **New Code (After Updating to SEO-Friendly URLs)** ✅
```python
from django.urls import reverse

class Post(models.Model):
    # ... (other model fields)
    
    def get_absolute_url(self):  # ✅ Updated canonical URL method
        return reverse(
            'blog:post_detail',
            args=[
                self.publish.year,  # ✅ Year of publication
                self.publish.month,  # ✅ Month of publication
                self.publish.day,  # ✅ Day of publication
                self.slug  # ✅ Unique slug for the post
            ]
        )
```

---

## **Understanding the Changes in `get_absolute_url()`** 🧐

- **✅ Uses `self.publish.year`, `self.publish.month`, and `self.publish.day`**: 
  - Ensures URLs include the **exact publication date**.
- **✅ Uses `self.slug`**:
  - Replaces the use of `id` with a **user-friendly slug**.
- **✅ Generates URLs that match the new `post_detail` URL pattern**:
  - This ensures that **all references** to post URLs are dynamically built.

---

## **Starting the Development Server & Testing the Changes** 🚀
After modifying the `models.py` file, start the **Django development server** by running:
```sh
python manage.py runserver
```

Now, open your browser and visit:
```sh
http://127.0.0.1:8000/blog/
```
Click on any **post title**, and it should direct you to a detail page with the new **SEO-friendly URL format**. 🎯


<div align="center">
  <img src="./images/seo_friendly_urls.jpg" alt="Seo Friendly urls" width="600px"/>

  **Figure 2.2**:  The page for the post’s detail view

</div>

## **Expected URL Format After Changes** 🔍
The URL structure for posts should now look like:
```sh
/blog/2024/1/1/who-was-django-reinhardt/
```
Instead of using `id`, we are now using **publish date + slug** to generate **SEO-friendly, human-readable URLs**. This is beneficial for **search engine optimization (SEO) and user readability**.

<div align="center">

# `New Section Adding Pagination`

</div>

# **Implementing Pagination in Django**📄✨

When your blog accumulates **a large number of posts**, displaying all of them on **a single page** can be inefficient. Instead, it's best to **split** the post list across multiple pages with **pagination**. This approach significantly enhances **performance** and **user experience**. 🚀

---

## **Understanding Pagination 📌**
Pagination is a technique that divides **large datasets** into smaller chunks, displaying only a **subset of items per page**. This allows users to navigate through multiple pages instead of loading all content at once.

### **Example: Pagination in Search Engines 🔍**
A well-known example of pagination is **Google Search**, where search results are divided into multiple pages. Users can navigate between pages using **next/previous buttons** or by selecting a specific page number.

<div align="center">
  <img src="./images/google.jpg" alt="" width="600px"/>

  **Figure 2.3**:  Google pagination links for search result pages

</div>

---

## **Django’s Built-in Pagination Class 🛠️**
Django provides a **built-in pagination system** that makes implementing pagination seamless. With Django’s pagination class, you can:
- ✅ Define the **number of posts** to display per page.
- ✅ Retrieve the **correct posts** for each page request.
- ✅ Generate **pagination controls** for easy navigation.

---

## **Why Use Pagination? 🤔**
- 🚀 **Performance Optimization:** Loading only a subset of posts reduces **page load times**.
- 🎯 **User-Friendly Navigation:** Users can **easily switch pages** instead of endless scrolling.
- 🔍 **Better SEO:** Search engines can **index** pages efficiently.

<div align="center">

# `New Section Pagination to the Post List View`

</div>

# **Adding Pagination to the Post List View** 📄🔄✨

---

## **Updating the ****`post_list`**** View for Pagination** 🛠️

To implement pagination, we will use Django's built-in `Paginator` class to divide posts into multiple pages.

### **Edit the ****`views.py`**** file** 📄

Modify the `post_list` view as follows:

```python
from django.core.paginator import Paginator  # ✅ Import Paginator class
from django.shortcuts import get_object_or_404, render
from .models import Post

def post_list(request):
    post_list = Post.published.all()
    
    # ✅ Pagination with 3 posts per page
    paginator = Paginator(post_list, 3)
    
    # ✅ Get page number from request, default to 1 if not provided
    page_number = request.GET.get('page', 1)
    
    # ✅ Retrieve the corresponding page of posts
    posts = paginator.page(page_number)
    
    return render(
        request,
        'blog/post/list.html',
        {'posts': posts}
    )
```

---

## **Understanding the Changes** 🔍📌

### **1️⃣ Instantiating the ****`Paginator`**** Class**

```python
paginator = Paginator(post_list, 3)
```

- We **instantiate the ****`Paginator`**** class** with the full list of published posts.
- The second argument (`3`) specifies the **number of posts per page**.

### **2️⃣ Retrieving the Requested Page Number**

```python
page_number = request.GET.get('page', 1)
```

- We use `request.GET.get('page', 1)` to retrieve the **current page number** from the URL query parameters.
- If no page number is provided, it defaults to **1**, ensuring that the **first page is loaded by default**.

### **3️⃣ Fetching the Posts for the Current Page**

```python
posts = paginator.page(page_number)
```

- We call `paginator.page(page_number)` to **retrieve only the posts belonging to the requested page**.
- This method returns a **`Page`**** object**, containing paginated data.

### **4️⃣ Passing Paginated Posts to the Template**

```python
return render(request, 'blog/post/list.html', {'posts': posts})
```

- The `posts` object (which contains only a subset of posts for the current page) is passed to the template.

---

## **How Does This Work? 🤔**

🔹 When a user visits `/blog/`, the first three posts are displayed.
🔹 When they visit `/blog/?page=2`, the next three posts are displayed.
🔹 If they enter an invalid page number, Django raises an error


<div align="center">

# `New Section Pagination Template`

</div>

#  **Creating a Pagination Template** 📌

## 📖 Introduction

We will create a **pagination template** that can be reused for any object pagination on our website. 📝

---

## 📂 Setting Up the Pagination Template

1. Navigate to the **templates/** directory of your project.
2. Create a new file and name it **pagination.html**.
3. Add the following **HTML** code to the file:

```html
<div class="pagination">
    <span class="step-links">
        {% if page.has_previous %}
            <a href="?page={{ page.previous_page_number }}">Previous</a>
        {% endif %}
        <span class="current">
            Page {{ page.number }} of {{ page.paginator.num_pages }}.
        </span>
        {% if page.has_next %}
            <a href="?page={{ page.next_page_number }}">Next</a>
        {% endif %}
    </span>
</div>
```

### 📌 Explanation of the Code

✅ **`<div class="pagination">`**: A wrapper `div` to contain the pagination links.</br>
✅ **`<span class="step-links">`**: A `span` element that holds the navigation links.</br>
✅ **`{% if page.has_previous %}`**: Checks if there is a previous page and, if so, displays a **Previous** button.</br>
✅ **`<a href="?page={{ page.previous_page_number }}">Previous</a>`**: Creates a hyperlink to navigate to the previous page.</br>
✅ **`<span class="current"> Page {{ page.number }} of {{ page.paginator.num_pages }}. </span>`**: Displays the **current page number** and the **total number of pages**.</br>
✅ **`{% if page.has_next %}`**: Checks if there is a next page and, if so, displays a **Next** button.</br>
✅ **`<a href="?page={{ page.next_page_number }}">Next</a>`**: Creates a hyperlink to navigate to the next page.</br>

This **generic pagination template** is designed to work with a **Page object** in the context and dynamically render navigation links based on the current page state. 🛠️

---

## 🏗️ Integrating Pagination into the Blog List Template

To include the pagination template in our **blog post list page**, follow these steps:

1. Open the **blog/post/list.html** template.
2. Include the **pagination.html** file at the bottom of the `{% block content %}`.

Modify the file as follows:

```html
{% extends "blog/base.html" %}
{% block title %}My Blog{% endblock %}
{% block content %}
    <h1>My Blog</h1>
    {% for post in posts %}
        <h2>
            <a href="{{ post.get_absolute_url }}">
                {{ post.title }}
            </a>
        </h2>
        <p class="date">
            Published {{ post.publish }} by {{ post.author }}
        </p>
        {{ post.body|truncatewords:30|linebreaks }}
    {% endfor %}

    {% include "pagination.html" with page=posts %} {% comment %} ✅  include here {% endcomment %}
{% endblock %}
```

### 📌 Explanation of the Code

✅ **`{% extends "blog/base.html" %}`**: Inherits the base template.</br>
✅ **`{% block title %}My Blog{% endblock %}`**: Sets the page title.</br>
✅ **Loop through posts** using `{% for post in posts %}` to display each blog post.</br>
✅ **`{% include "pagination.html" with page=posts %}`**: Includes the **pagination.html** file and passes the `posts` Page object as `page`.</br>

### 🔄 How Pagination Works

- The `{% include %}` tag **loads the pagination template** and renders it **within the current template context**.
- We use `{% with page=posts %}` to pass the **posts** variable (which is a Page object) to the pagination template.
- This method makes the **pagination template reusable** for any type of object. 🔄

---

## 🚀 Running the Development Server

To test our pagination, we need to start the **Django development server**. Run the following command in your terminal:

```bash
python manage.py runserver
```

### 🌐 Viewing the Blog Posts

1. Open your **Django Admin Panel** to create blog posts:

   - URL: [http://127.0.0.1:8000/admin/blog/post/](http://127.0.0.1:8000/admin/blog/post/)
   - Create **four** different posts.
   - Set the **status to Published** for each post.

2. Open the **blog post list page** in your browser:

   - URL: [http://127.0.0.1:8000/blog/](http://127.0.0.1:8000/blog/)
   - You should see **three posts per page** in **reverse chronological order**.
   - The **pagination links** will appear at the bottom of the post list.

<div align="center">
  <img src="./images/pagination_page.jpg" alt="" width="600px"/>

  **Figure 2.4**: The post list page including pagination

</div>

If you click on Next, you will see the last post. The URL for the second page contains the ?page=2 GET
parameter. This parameter is used by the view to load the requested page of results using the paginator.

<div align="center">
  <img src="./images/next_page.jpg" alt="" width="600px"/>

  **Figure 2.5**: The second page of results

</div>

<div align="center">

# `New Section Handling Pagination Errors `

</div>

# **Handling Pagination Errors in Django** 🛠️📄

## Understanding Pagination Errors ⚠️

When working with Django's `Paginator`, you might encounter errors if a user:

- Requests a page number that **does not exist**. ❌
- Provides a **non-numeric value** as the page number. 🔢

For example, opening the following URL:

```
http://127.0.0.1:8000/blog/?page=3
```

If **page 3** does not exist, Django throws an `EmptyPage` exception. To prevent this, we need to **handle pagination errors** properly. ✅

<div align="center">
  <img src="./images/handling_error.jpg" alt="" width="600px"/>

  **Figure 2.6**: The EmptyPage error page

</div>

## Implementing Error Handling in Views 🛠️

To handle pagination errors gracefully, follow these steps:

### Step 1: Modify `views.py` 📄

Edit the `views.py` file in your **blog application** to include error handling.

```python
from django.core.paginator import Paginator, EmptyPage  # Import EmptyPage
from django.shortcuts import render
from .models import Post

def post_list(request):
    post_list = Post.published.all()  # Retrieve all published posts
    
    # Pagination: Display 3 posts per page
    paginator = Paginator(post_list, 3)
    page_number = request.GET.get('page', 1)  # Get page number from URL (default: 1)
    
    try:
        posts = paginator.page(page_number)  # Fetch requested page
    except EmptyPage:
        # If requested page is out of range, return the last page
        posts = paginator.page(paginator.num_pages)
    
    return render(request, 'blog/post/list.html', {'posts': posts})
```

### Explanation of the Code 📌

1. **Importing Necessary Modules** 🏗️

   - `EmptyPage`: Catches errors when the requested page is **out of range**.

2. **Handling Pagination Errors with Try-Except** 🛠️

   - `paginator.page(page_number)`: Fetches the requested page.
   - `except EmptyPage`: If the **requested page is out of range**, fetch the **last available page** instead.
   - `paginator.num_pages`: Provides the total number of pages (i.e., last page number).

## Testing the Implementation ✅

Revisit the URL after implementing error handling:

```
http://127.0.0.1:8000/blog/?page=3
```

- If page **3 exists**, it will be displayed. 📖
- If page **3 does not exist**, the last page of results will be shown instead. 🔄

<div align="center">
  <img src="./images/handle_pagination_error.jpg" alt="" width="600px"/>

  **Figure 2.7**: The last page of results

</div>

<div align="center">

# `New Section Handling Non-Integer Page`

</div>

# **Handling Non-Integer Page Numbers** 🔢🚀

When implementing pagination in Django, we must handle cases where users provide **invalid page numbers** (such as text instead of integers). If an invalid page parameter is passed, Django's `Paginator` raises a `PageNotAnInteger` exception. This guide covers how to handle such errors properly. 🛠️

## Problem: Non-Integer Page Number ❌

Consider the following URL:
```
http://127.0.0.1:8000/blog/?page=asdf
```
Since **page numbers should be integers**, Django throws a `PageNotAnInteger` exception when attempting to retrieve the page **'asdf'**. We need to handle this exception and ensure our pagination remains functional. ✅

<div align="center">
  <img src="./images/pagenotintegererror.jpg" alt="" width="600px"/>

  **Figure 2.8**: The PageNotAnInteger error page

</div>

## Implementing Error Handling in Views 🛠️

### Step 1: Modify `views.py` 📄
Edit your `views.py` file to include error handling for non-integer page numbers.

```python
from django.shortcuts import get_object_or_404, render
from django.core.paginator import EmptyPage, Paginator, PageNotAnInteger  # Import PageNotAnInteger
from .models import Post

def post_list(request):
    post_list = Post.published.all()  # Retrieve all published posts
    
    # Pagination: Display 3 posts per page
    paginator = Paginator(post_list, 3)
    page_number = request.GET.get('page')
    
    try:
        posts = paginator.page(page_number)  # Fetch requested page
    except PageNotAnInteger:  # Handle non-integer page numbers
        # If page_number is not an integer, return the first page
        posts = paginator.page(1)
    except EmptyPage:  # Handle out-of-range pages
        # If requested page is out of range, return the last page
        posts = paginator.page(paginator.num_pages)
    
    return render(request, 'blog/post/list.html', {'posts': posts})
```

### Explanation of the Code 📌
1. **Importing Required Modules** 🏗️
   - `PageNotAnInteger`: Catches errors when the **page number is not an integer**.
  
2. **Handling Different Pagination Errors** ⚠️
   - `except PageNotAnInteger:` If the user provides **a non-integer page number**, return **the first page**.
   - `except EmptyPage:` If the requested page is **out of range**, return **the last available page**.

## Testing the Implementation ✅

Revisit the following URLs after implementing error handling:

- **Valid Page**: `http://127.0.0.1:8000/blog/?page=2` → Displays **Page 2**. 📖
- **Invalid Page (Text)**: `http://127.0.0.1:8000/blog/?page=asdf` → Redirects to **Page 1**. 🔄
- **Out of Range Page**: `http://127.0.0.1:8000/blog/?page=100` → Redirects to **Last Page**. 📌


<div align="center">

# `New Section Starts here`

</div>


