# 📚 Implementing Search Functionality

Searching is a fundamental feature for most websites, especially e-commerce platforms like our Bookstore! 🛒 In this section, we'll learn how to implement a search function using forms and filters in Django. We’ll start with basic search features and gradually enhance them with more advanced logic and options. While our database currently has only two books, the code we'll write will be scalable to handle any number of books in the future. Let's get started! 🚀


## 🔍 **Understanding Search Functionality in Django**

Search functionality consists of two main components:

1. **Form for User Search Queries** 📝
2. **Results Page that Displays Filtered Results** 📋

Determining the "right" type of filter makes search both interesting and challenging. But before we dive deep into that, we need to set up both a form and a search results page. We'll configure the filtering logic first and then create the form.


## 📄 **Setting Up the Search Results Page**

Creating a search results page in Django requires three things:

1. **URL Configuration** 🛤️
2. **View for Handling Search Logic** 🎥
3. **Template for Displaying Results** 🖼️

### 1️⃣ **Define the URL Pattern**

In `books/urls.py`, add a new path for `search/` with a URL name of `search_results` that uses a view called `SearchResultsListView`.

```python
# books/urls.py
from django.urls import path
from .views import (
    BookListView, BookDetailView, BookCreateView, BookUpdateView, BookDeleteView, ReviewCreateView , SearchResultsListView)  # new
urlpatterns = [
    path('', BookListView.as_view(), name='book_list'),
    path('<uuid:pk>/', BookDetailView.as_view(), name='book_detail'),
    path('create/', BookCreateView.as_view(), name='book_create'),
    path('<uuid:pk>/update/', BookUpdateView.as_view(), name='book_update'),
    path('<uuid:pk>/delete/', BookDeleteView.as_view(), name='book_delete'),
    path('<uuid:pk>/review/', ReviewCreateView.as_view(), name='review_create'),
    path("search/", SearchResultsListView.as_view(), name="search_results"),  # new
]
```

### 2️⃣ **Create the View**

The `SearchResultsListView` will list all available books initially. Since it involves listing items, we use Django's `ListView`. The associated template will be named `search_results.html` and will live in the `templates/books/` directory.

```python
# books/views.py
from django.views.generic import ListView
from .models import Book  # Import the Book model

class SearchResultsListView(ListView):  # new
    model = Book
    context_object_name = "book_list"
    template_name = "books/search_results.html"
```

### 3️⃣ **Build the Template**

Create a new file `templates/books/search_results.html` and set it up to list all books by title, author, and price.

```html
<!-- templates/books/search_results.html -->
{% extends "_base.html" %}
{% block title %}Search{% endblock title %}
{% block content %}
<h1>🔍 Search Results</h1>
<div class="row row-cols-1 row-cols-md-3 g-4">
    {% if book_list %}
    <!-- If books are available, display them using Bootstrap cards -->
    {% for book in book_list %}
    <div class="col">
      <div class="card h-100">
        {% if book.cover %}
        <img
          src="{{ book.cover.url }}"
          class="card-img-top"
          alt="{{ book.title }}"
        />
        {% endif %}
        <div class="card-body">
          <h5 class="card-title">
            <a href="{{ book.get_absolute_url }}">{{ book.title }}</a>
          </h5>
          <p class="card-text">Author: {{ book.author }}</p>
          <p class="card-text">Price: {{ book.price }}</p>
        </div>
        <div class="card-footer">
          <a href="{{ book.get_absolute_url }}" class="btn btn-primary"
            >View Details</a
          >
        </div>
      </div>
    </div>
    {% endfor %}
{% endblock content %}
```

You can now access the search results page at `http://127.0.0.1:8000/books/search/`. 🎉

## 🎯 **Implementing Basic Filtering with QuerySets**

Currently, our search results page displays all the books available in the `Book` model. To make it a real search page, we need to filter results based on the user's search query.

### 🔧 **Customizing QuerySets**

Django’s **QuerySet API** is quite powerful and offers various methods to filter results from a database model. By overriding the default `queryset` attribute in `ListView`, we can filter the books directly in the view.

```python
# books/views.py
class SearchResultsListView(ListView):
    model = Book
    context_object_name = "book_list"
    template_name = "books/search_results.html"
    queryset = Book.objects.filter(title__icontains="beginners")  # new
```

🔄 **Reload the search results page**, and you'll now see only books with titles containing "beginners." Success! 🎉

### 📌 **Key QuerySet Methods to Know**

- `filter()`
- `all()`
- `get()`
- `exclude()`

These methods are often enough for basic filtering needs. For more complex queries, Django’s [QuerySet API](https://docs.djangoproject.com/en/5.1/ref/models/querysets/#queryset-api) offers additional tools and techniques.

### 🧩 **Advanced Filtering with Q Objects**

For more complex lookups that involve "OR" logic, you can use `Q` objects in Django. Below is an example where we filter books that contain either "beginners" or "api" in their titles.

```python
# books/views.py
from django.db.models import Q  # new

class SearchResultsListView(ListView):
    model = Book
    context_object_name = "book_list"
    template_name = "books/search_results.html"

    def get_queryset(self):  # new
        return Book.objects.filter(
            Q(title__icontains="beginners") | Q(title__icontains="api")
        )
```

Refresh the search results page to see the results dynamically updated based on these filters. 🎈

---

## 📝 **Adding a Search Form to the Navbar**

A web form is a simple way to capture user input and send it to a URL using either a `GET` or `POST` method. In our case, since we're only retrieving data (not modifying it), we will use the `GET` method for our search form.

To add the search form, update the `_base.html` template and include it within the navigation bar:

```html
<!-- templates/_base.html -->
...
{% endif %}
</ul>
<form class="d-flex" action="{% url 'search_results' %}" method="get">
<input class="form-control me-2" type="search" name="q" placeholder="Search" aria-\
label="Search" >
<button class="btn btn-outline-success" type="submit">Search</button>
</form>
</div>
</div>
</nav>
```

- **Input Field:** This is where users will type their search query. The `name="q"` attribute will be used to capture the search term.
- **Submit Button:** The button styled with Bootstrap allows users to submit their search.

Navigate to any page, and you'll see the search box in the top-right corner. 🔝 Try searching for “hello” and notice the URL updating to `/search/?q=hello`. 🚦

### 🛠️ **Updating the View to Handle User Input**

We need to modify `SearchResultsListView` to take the user's input from the form and filter the results dynamically.

```python
# books/views.py
class SearchResultsListView(ListView):
    model = Book
    context_object_name = "book_list"
    template_name = "books/search_results.html"

    def get_queryset(self):  # new
        query = self.request.GET.get("q")
        return Book.objects.filter(
            Q(title__icontains=query) | Q(author__icontains=query)
        )
```

- **`query = self.request.GET.get("q")`:** Captures the user's search term.
- **`filter(...)`:** Filters books by title or author based on the query.

Refresh the search results page, and you will see the search functionality in action. Try searching for "api" or "beginners" to see the results change dynamically! 🕵️‍♂️

---

## 🛠️ **Save Your Changes with Git**

Ensure all changes are saved by committing them to Git:

```bash
git status
git add .
git commit -m 'Search functionality'
```

## 🚀 **Conclusion**

We have successfully implemented a basic search feature in Django! 🎉 There are numerous ways to enhance this further, such as adding form validation, improving search relevance, or integrating third-party solutions like `django-watson` or `ElasticSearch`.
In the next section, we'll explore various performance optimizations as we prepare our Bookstore project for deployment.🌟