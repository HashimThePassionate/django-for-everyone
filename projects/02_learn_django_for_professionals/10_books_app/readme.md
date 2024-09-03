# 📚 Books App Section

In this section, we will build a **Books app** for our project that displays all available books and has an individual page for each. We’ll also explore different URL approaches, starting with using an ID, then switching to a **slug**, and finally using a **UUID**.

### 🚀 Getting Started

To start, we must create this new app, which we’ll call **books**.

```bash
docker-compose exec web python manage.py startapp books
```

**Explanation:**

- This command uses `docker-compose` to execute a Django management command within the `web` container. The `startapp` command creates a new Django app named **books**. This app will contain the code specific to the book-related functionalities, such as models, views, templates, and URLs.

Next, we need to ensure Django knows about our new app. Open your text editor and add the new app to `INSTALLED_APPS` in our `django_project/settings.py` file:

```python
# django_project/settings.py
INSTALLED_APPS = [
    # Django apps
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "django.contrib.sites", 
    "allauth", 
    "allauth.account",  
    "allauth.socialaccount",
    "allauth.socialaccount.providers.github",
    "allauth.socialaccount.providers.google",
    # Other apps...
    "crispy_forms", 
    "crispy_bootstrap5", 
    # Local apps
    "accounts",
    "pages",
    "books",  # new
]
```

**Explanation:**

- **INSTALLED_APPS** is a list in Django's settings that defines all the applications that are active for this Django project.
- By adding `"books"`, Django is aware of the new **books** app, and this allows it to discover and register the app's models, views, and other components.
- The configuration includes Django default apps, third-party apps for forms and authentication, and local apps like **accounts**, **pages**, and now **books**.

✨ Initial creation complete!

## 🛠️ Models

To structure our app, we need a **model**, **view**, **URL**, and **template** for each page. Starting with the **model** is often the best approach as it sets the foundation. We will keep things simple by starting with fields like **title**, **author**, and **price**.

Update the `books/models.py` file to include our new **Book** model.

```python
# books/models.py
from django.db import models

class Book(models.Model):
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=200)
    price = models.DecimalField(max_digits=6, decimal_places=2)

    def __str__(self):
        return self.title
```

**Explanation:**

- **`from django.db import models`**: This imports the Django models module, which provides the base class `Model` to define our data model.
- **`class Book(models.Model):`**: This line defines a new model class named **Book**. It inherits from `models.Model`, meaning it becomes a Django model class that can be stored in the database.
- **`title = models.CharField(max_length=200)`**: This line defines a `title` field that is a character field (`CharField`) with a maximum length of 200 characters.
- **`author = models.CharField(max_length=200)`**: This line defines an `author` field, similar to `title`, with a maximum length of 200 characters.
- **`price = models.DecimalField(max_digits=6, decimal_places=2)`**: This line defines a `price` field that stores decimal values with up to 6 digits in total, and 2 of those digits after the decimal point. This is ideal for storing currency values.
- **`def __str__(self):`**: This special method returns a string representation of the Book object. When you print a book instance, it will display the book's title.

### 🔄 Database Migrations

Now that our new database model is created, we need to create a new migration record for it.

```bash
docker-compose exec web python manage.py makemigrations
```

**Explanation:**

- This command creates new migration files based on the changes made to the models (like our new `Book` model). Migrations are Django’s way of propagating model changes (e.g., adding a field, deleting a model) to the database schema.

Output:

```
Migrations for 'books':
books/migrations/0001_initial.py
- Create model Book
```

- The output confirms that Django has detected the new `Book` model and created a migration file (`0001_initial.py`) for it.

Apply the migration to our database.

```bash
docker-compose exec web python manage.py migrate
```

**Explanation:**

- This command applies the migrations to the database, creating the necessary tables and fields to store `Book` model instances. This makes the changes defined in the migration files part of the actual database schema.

Output:

```
Operations to perform:
  Apply all migrations: account, accounts, admin, auth, books, contenttypes, sessions, sites
Running migrations:
  Applying books.0001_initial... OK
```

- The output shows the migrations that were applied, including `books.0001_initial`.

Our database is now configured. ✅

## 📋 Admin Interface

To access our data, we can use the Django **admin interface**. Don’t forget to update the `books/admin.py` file, or else the app won’t appear!

```python
# books/admin.py
from django.contrib import admin
from .models import Book

admin.site.register(Book)
```

**Explanation:**

- **`from django.contrib import admin`**: This imports the Django admin module, which is used to manage our models through a web interface.
- **`from .models import Book`**: This imports the `Book` model we just created.
- **`admin.site.register(Book)`**: This registers the `Book` model with the Django admin, so it will be accessible from the admin interface.

Once this is done, you can look into the admin at `http://127.0.0.1:8000/admin/`, and the Books app will be visible.

### 📝 Adding a Book Entry

To add a book entry, click on the **+ Add** button next to **Books** in the admin panel. For example:

- **Title**: "Python Deep Dive"
- **Author**: "Muhammad Hashim"
- **Price**: 69.00

After clicking on the **Save** button, it redirects to the main Books page, showing the title.

To display additional fields like **author** and **price** in the admin, update `books/admin.py`:

```python
# books/admin.py
from django.contrib import admin
from .models import Book

class BookAdmin(admin.ModelAdmin):
    list_display = ("title", "author", "price",)

admin.site.register(Book, BookAdmin)
```

**Explanation:**

- **`class BookAdmin(admin.ModelAdmin):`**: This creates a custom admin class, `BookAdmin`, which inherits from `admin.ModelAdmin`.
- **`list_display = ("title", "author", "price",)`**: This specifies the fields to be displayed in the list view of the admin panel for the `Book` model.

By refreshing the page, you should now see the **title**, **author**, and **price** columns in the Books list view.

## 🌐 URLs

We need to update two `urls.py` files to route our requests properly:

1. **Main URL Configuration (`django_project/urls.py`)**

Add the new path for the books app:

```python
# django_project/urls.py
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    # Django admin
    path("admin/", admin.site.urls),
    # User management
    path("accounts/", include("allauth.urls")),
    # Local apps
    path("", include("pages.urls")),
    path("books/", include("books.urls")),  # new
]
```

**Explanation:**

- **`path("books/", include("books.urls")),`**: This line includes the URLs from the **books** app. When a URL starts with `books/`, Django will look in the `books/urls.py` file for further instructions.

2. **Books App URLs (`books/urls.py`)**

Create a new `books/urls.py` file for our books app URL paths:

```python
# books/urls.py
from django.urls import path
from .views import BookListView, BookDetailView  # new

urlpatterns = [
    path("", BookListView.as_view(), name="book_list"),
    path("<int:pk>/", BookDetailView.as_view(), name="book_detail"),  # new
]
```

**Explanation:**

- **`from .views import BookListView, BookDetailView`**: This imports the `BookListView` and `BookDetailView` views we will create.
- **`path("", BookListView.as_view(), name="book_list"),`**: This sets the URL pattern for the book list page. When someone accesses `books/`, it triggers the `BookListView`.
- **`path("<int:pk>/", BookDetailView.as_view(), name="book_detail"),`**: This sets the

 URL pattern for the book detail page. The `<int:pk>` is a dynamic segment that captures the primary key (ID) of a book and passes it to the `BookDetailView`.

### Explanation of Primary Keys and IDs:

- **Primary Key (`pk`)**: A field that uniquely identifies each record in a table. By default, Django creates an `id` field as the primary key.
- **ID**: The `id` is the default primary key field in Django. It is auto-incrementing, meaning it starts at 1 and increases by 1 for each new record.
- Django uses `pk` and `id` interchangeably when referencing the primary key field. However, `pk` is safer to use as it will still work if the primary key field changes.

## 👀 Views

Now, let's create the **BookListView** and **BookDetailView** we referenced in our URLs file. This will rely on the built-in `ListView` and `DetailView`, which are Generic Class-Based Views (CBVs) provided for common use cases like this.

```python
# books/views.py
from django.views.generic import ListView, DetailView  # new
from .models import Book

class BookListView(ListView):
    model = Book
    context_object_name = "book_list"  # new
    template_name = "books/book_list.html"

class BookDetailView(DetailView):  # new
    model = Book
    context_object_name = "book"  # new
    template_name = "books/book_detail.html"
```

**Explanation:**

- **`from django.views.generic import ListView, DetailView`**: This imports the `ListView` and `DetailView` classes provided by Django.
- **`class BookListView(ListView):`**: This creates a view for displaying a list of all books.
  - **`model = Book`**: Specifies that the view is based on the `Book` model.
  - **`context_object_name = "book_list"`**: Changes the default context object name from `object_list` to `book_list` for clarity.
  - **`template_name = "books/book_list.html"`**: Specifies the template to use for rendering this view.
- **`class BookDetailView(DetailView):`**: This creates a view for displaying details of a single book.
  - **`context_object_name = "book"`**: Changes the default context object name from `object` to `book` for clarity.

## 🎨 Templates

It’s a good practice to create an app-specific folder within our base-level `templates` directory, especially as the number of templates grows. So we’ll create one called **books**:

```bash
docker-compose exec web mkdir templates/books/
```

**Explanation:**

- This command creates a new directory for the books templates. Organizing templates by app name is a convention that helps manage templates more easily in larger projects.

Create a new file called `templates/books/book_list.html`:

```html
<!-- templates/books/book_list.html -->
{% extends "_base.html" %}
{% block title %}Books{% endblock title %}
{% block content %}
  {% for book in book_list %}
  <div>
    <h2><a href="{% url 'book_detail' book.pk %}">{{ book.title }}</a></h2>
  </div>
  {% endfor %}
{% endblock content %}
```

**Explanation:**

- **`{% extends "_base.html" %}`**: This line means that `book_list.html` extends (inherits from) the `_base.html` template.
- **`{% block title %}Books{% endblock title %}`**: This block sets the title of the page to "Books".
- **`{% block content %}`**: This block contains the main content of the page.
  - **`{% for book in book_list %}`**: This starts a loop that iterates over the `book_list` context variable.
  - **`<a href="{% url 'book_detail' book.pk %}">{{ book.title }}</a>`**: This generates a clickable link to each book's detail page using the `book_detail` URL name and the book's primary key (`pk`).

For the detail view, create `templates/books/book_detail.html`:

```html
<!-- templates/books/book_detail.html -->
{% extends "_base.html" %}
{% block title %}{{ book.title }}{% endblock title %}
{% block content %}
<div class="book-detail">
  <h2>{{ book.title }}</h2>
  <p>Author: {{ book.author }}</p>
  <p>Price: {{ book.price }}</p>
</div>
{% endblock content %}
```

**Explanation:**

- Similar to `book_list.html`, this template extends the base template and defines content specific to displaying a book's details.

## 🖥️ Updating the Navbar

Add a navbar link for **Books** so we don’t have to type out the full URL each time:

```html
<!-- templates/_base.html -->
...
<div class="collapse navbar-collapse" id="navbarCollapse">
  <ul class="navbar-nav me-auto mb-2 mb-md-0">
    <li class="nav-item">
      <a class="nav-link" href="{% url 'book_list' %}">Books</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="{% url 'about' %}">About</a>
    </li>
  ...
```

**Explanation:**

- The `<a>` tag with `href="{% url 'book_list' %}"` creates a clickable link to the `book_list` view, making it easier to navigate to the Books page from any part of the site.

## 🔄 Update and Restart Containers

After adding our URLs and views, we need to spin down and then up our containers to reload the Django `django_project/settings.py` file. Otherwise, it won’t recognize the changes.

```bash
docker-compose down
docker-compose up -d
```

**Explanation:**

- Restarting the containers ensures all changes in the configuration are loaded correctly.

Visit `http://127.0.0.1:8000/books/` in your browser, and the new books page should be visible! 🎉

To view an individual book, navigate to `http://127.0.0.1:8000/books/1/`, and you’ll see a dedicated page for the first book.

## 🌐 Canonical URLs with `get_absolute_url()`

A recommended step is to add a `get_absolute_url()` method which sets a canonical URL for the model. It is also required when using the `reverse()` function.

Update the `books/models.py` file:

```python
# books/models.py
from django.db import models
from django.urls import reverse # new

class Book(models.Model):
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=200)
    price = models.DecimalField(max_digits=6, decimal_places=2)

    def __str__(self):
        return self.title

    def get_absolute_url(self):  # new
        return reverse("book_detail", args=[str(self.id)])
```

**Explanation:**

- **`from django.urls import reverse`**: This imports the `reverse` function, which is used to generate URLs from URL names.
- **`def get_absolute_url(self):`**: This method returns the absolute URL for a book's detail page using the `reverse()` function. It constructs the URL by passing the `book_detail` URL name and the `id` of the book.

Update the `book_list.html` to use `get_absolute_url()`:

```html
<!-- templates/books/book_list.html -->
{% extends '_base.html' %}
{% block title %}Books{% endblock title %}
{% block content %}
{% for book in book_list %}
<div>
  <h2><a href="{{ book.get_absolute_url }}">{{ book.title }}</a></h2>
</div>
{% endfor %}
{% endblock content %}
```

**Explanation:**

- The `<a>` tag now uses `{{ book.get_absolute_url }}` instead of `{% url 'book_detail' book.pk %}`. This makes the URL construction more dynamic and centralized within the model itself.

## 🔍 Primary Keys vs. IDs

When deciding between using a **primary key** (PK) or **ID** in a project, note:

- **ID**: A model field automatically set by Django to auto-increment.
- **PK**: Refers to the primary key field of a model, and it could be `id` or another field. When in doubt, use `pk` to avoid confusion.

## 🔐 Slugs vs. UUIDs

Using the `pk` field in the URL of our `DetailView` is quick and easy, but not ideal for a real-world project. A better approach is to use a **UUID** (Universally Unique Identifier) which Django now supports via a dedicated `UUIDField`.

### Explanation of Slugs and UUIDs:

- **Slug**: A URL-friendly, readable string often derived from a model field (like `title`). Used to make URLs more descriptive but prone to synchronization issues.
- **UUID (Universally Unique Identifier)**: A 128-bit unique identifier that is practically unique across space and time, making it much more secure for URLs.

Update the model to use a UUID:

```python
# books/models.py
import uuid  # new
from django.db import models
from django.urls import reverse

class Book(models.Model):
    id = models.UUIDField(primary_key=True,default=uuid.uuid4,editable=False) # new
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=200)
    price = models.DecimalField(max_digits=6, decimal_places=2)

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse("book_detail", args=[str(self.id)])
```

**Explanation:**

- **`import uuid`**: Imports Python's `uuid` module, which allows us to generate universally unique identifiers (UUIDs).
- **`id = models.UUIDField()`**: Replaces the default `id` field with a `UUIDField`, making the ID a UUID instead of an integer.
- **`primary_key=True`**: Sets the UUID field as the primary key of the model.
- **`default=uuid.uuid4`**: Uses the `uuid4` method to generate a random UUID.
- **`editable=False`**: Ensures the UUID cannot be edited once set.

Update the URL path in `books/urls.py`:

```python
# books/urls.py
from django.urls import path
from .views import BookListView, BookDetailView

urlpatterns = [
    path("", BookListView.as_view(), name="book_list"),
    path("<uuid:pk>/", BookDetailView.as_view(), name="book_detail"),  # new
]
```

**Explanation:**

- **`<uuid:pk>`**: The URL pattern now expects a UUID rather than an integer. This change ensures URLs are more secure and do not expose sequential database IDs.

### 🔄 Migrating Changes

If there are existing book entries and related migration files, you may need to remove old migrations and start over to apply the UUID changes correctly:

```bash
docker-compose exec web rm -r books/migrations
docker-compose down
docker volume rm 10_books_app_postgres_data
docker-compose up -d
docker-compose exec web python manage.py makemigrations books
docker-compose exec web python manage.py migrate
docker-compose exec web python manage.py createsuperuser
```

**Explanation 🌟**

1. **🗑️ Remove Existing Migrations for the `books` App:**
   - **Command:** `docker-compose exec web rm -r books/migrations`
   - **Explanation:**
     - 🚀 Runs the command inside the `web` container.
     - 🗂️ Removes the `migrations` directory for the `books` app, deleting all migration files.
     - **🔍 Purpose:** Clears old migration files to avoid conflicts after major model changes (e.g., switching to UUIDs).

2. **🛑 Stop All Running Containers:**
   - **Command:** `docker-compose down`
   - **Explanation:**
     - 🚧 Stops and removes all containers defined in `docker-compose.yml`.
     - **🔍 Purpose:** Cleans up the environment and stops any processes that might be using database volumes.

3. **🗑️ Remove the Docker Volume for PostgreSQL Data:**
   - **Command:** `docker volume rm books_app_postgres_data`
   - **Explanation:**
     - 🗄️ Deletes the named Docker volume `10_books_app_postgres_data` where PostgreSQL data is stored.
     - **🔍 Purpose:** Completely removes old database data to prevent conflicts with the new schema.

4. **🔄 Rebuild and Start the Containers:**
   - **Command:** `docker-compose up -d`
   - **Explanation:**
     - ⚙️ Rebuilds (if necessary) and starts the containers in detached mode (background).
     - **🔍 Purpose:** Recreates the environment with a clean slate, ensuring no old data or states persist.

5. **📝 Create New Migrations for the `books` App:**
   - **Command:** `docker-compose exec web python manage.py makemigrations books`
   - **Explanation:**
     - 📦 Runs the `makemigrations` command inside the `web` container for the `books` app.
     - **🔍 Purpose:** Generates new migration files reflecting the current state of the models, including new UUID primary keys.

6. **📊 Apply the New Migrations to the Database:**
   - **Command:** `docker-compose exec web python manage.py migrate`
   - **Explanation:**
     - ⚙️ Applies all migrations to the database inside the `web` container.
     - **🔍 Purpose:** Creates new database tables and schema based on the freshly created migrations.

7. **👤 Create a New Superuser:**
   - **Command:** `docker-compose exec web python manage.py createsuperuser`
   - **Explanation:**
     - 🎟️ Runs the `createsuperuser` command inside the `web` container.
     - 🛠️ Prompts to set up a new superuser account.
     - **🔍 Purpose:** Creates a new admin user for accessing the Django admin interface since the old user data was wiped.


## 🧪 Tests

To ensure the **Books** model and views work as expected, we need to add tests. Here’s a sample `books/tests.py` file:

```python
# books/tests.py
from django.test import TestCase
from django.urls import reverse
from .models import Book

class BookTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.book = Book.objects.create(
            title="Python Deep Dive",
            author="Muhammad Hashim",
            price="69.00",
        )

    def test_book_listing(self):
        self.assertEqual(f"{self.book.title}", "Python Deep Dive")
        self.assertEqual(f"{self.book.author}", "Muhammad Hashim")
        self.assertEqual(f"{self.book.price}", "69.00")

    def test_book_list_view(self):
        response = self.client.get(reverse("book_list"))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Python Deep Dive")
        self.assertTemplateUsed(response, "books/book_list.html")

    def test_book_detail_view(self):
        response = self.client.get(self.book.get_absolute_url())
        no_response = self.client.get("/books/12345/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(no_response.status_code, 404)
        self.assertContains(response, "Python Deep Dive")
        self.assertTemplateUsed(response, "books/book_detail.html")
```

**Explanation:**

Each test case checks different functionalities of the Django app to ensure everything is working as expected.

### 1. **`setUpTestData` Method** 🛠️

Before we dive into each test case, let's discuss the `setUpTestData` method:

```python
@classmethod
def setUpTestData(cls):
    cls.book = Book.objects.create(
        title="Python Deep Dive",
        author="Muhammad Hashim",
        price="69.00",
    )
```

- **Purpose**: This is a class method that sets up initial data for the entire `BookTests` class. The `setUpTestData` method is called once at the beginning to create a sample book in the database.
- **What it does**: It creates a `Book` object with the title `"Python Deep Dive"`, author `"Muhammad Hashim"`, and price `"69.00"`.
- **Why it's useful**: This ensures that each test case starts with a consistent state and the same data, making the tests reliable and repeatable.

### 2. **`test_book_listing` Method** 📋

```python
def test_book_listing(self):
    self.assertEqual(f"{self.book.title}", "Python Deep Dive")
    self.assertEqual(f"{self.book.author}", "Muhammad Hashim")
    self.assertEqual(f"{self.book.price}", "69.00")
```

- **Purpose**: This test checks if the `Book` object was created correctly and its fields (`title`, `author`, and `price`) are set as expected.
- **What it does**:
  1. `self.assertEqual(f"{self.book.title}", "Python Deep Dive")` checks if the `title` of the created `Book` object matches `"Python Deep Dive"`.
  2. `self.assertEqual(f"{self.book.author}", "Muhammad Hashim")` checks if the `author` matches `"Muhammad Hashim"`.
  3. `self.assertEqual(f"{self.book.price}", "69.00")` checks if the `price` matches `"69.00"`.
- **Why it's useful**: It ensures that the `Book` model is working correctly and the data is stored as expected.

---

### 3. **`test_book_list_view` Method** 📄

```python
def test_book_list_view(self):
    response = self.client.get(reverse("book_list"))
    self.assertEqual(response.status_code, 200)
    self.assertContains(response, "Python Deep Dive")
    self.assertTemplateUsed(response, "books/book_list.html")
```

- **Purpose**: This test checks the `ListView` of books to ensure it returns the correct HTTP response and content.
- **What it does**:
  1. `response = self.client.get(reverse("book_list"))` sends a `GET` request to the URL mapped to the `book_list` view.
  2. `self.assertEqual(response.status_code, 200)` asserts that the HTTP status code is `200`, which means the request was successful.
  3. `self.assertContains(response, "Python Deep Dive")` checks if the response contains the text `"Python Deep Dive"`, indicating that the book list is displaying correctly.
  4. `self.assertTemplateUsed(response, "books/book_list.html")` ensures that the correct template `books/book_list.html` is being used to render the page.
- **Why it's useful**: It ensures that the book list page is accessible, displays the correct book information, and uses the correct template.

### 4. **`test_book_detail_view` Method** 🔍

```python
def test_book_detail_view(self):
    response = self.client.get(self.book.get_absolute_url())
    no_response = self.client.get("/books/12345/")
    self.assertEqual(response.status_code, 200)
    self.assertEqual(no_response.status_code, 404)
    self.assertContains(response, "Python Deep Dive")
    self.assertTemplateUsed(response, "books/book_detail.html")
```

- **Purpose**: This test checks the `DetailView` of a specific book to ensure it shows the right content and handles non-existent entries properly.
- **What it does**:
  1. `response = self.client.get(self.book.get_absolute_url())` sends a `GET` request to the URL for the `Book` object created in `setUpTestData`.
  2. `no_response = self.client.get("/books/12345/")` sends a `GET` request to a URL that doesn’t exist (assuming there is no book with ID `12345`).
  3. `self.assertEqual(response.status_code, 200)` checks that the HTTP status code is `200`, meaning the book detail page is accessible.
  4. `self.assertEqual(no_response.status_code, 404)` checks that a non-existent book returns a `404` status code, meaning "Not Found".
  5. `self.assertContains(response, "Python Deep Dive")` verifies that the detail view contains the correct book title `"Python Deep Dive"`.
  6. `self.assertTemplateUsed(response, "books/book_detail.html")` confirms that the correct template `books/book_detail.html` is used for the detail view.
- **Why it's useful**: It ensures that the detail page for a book displays the correct information, uses the correct template, and properly handles requests for non-existent books.

Run the tests:

```bash
docker-compose exec web python manage.py test
```

**Explanation:**

- This command runs all the tests defined in the `tests.py` file to ensure everything works as expected.

### 📚 Git Version Control
Add all changes to version control with Git:

```bash
git status
git add .
git commit -m 'Books App'
```

**Explanation:**

- **`git status`**: Shows the current status of the repository, including modified files.
- **`git add .`**: Stages all changes for commit.
- **`git commit -m 'Books App Section Complete'`**: Commits the changes with a descriptive message.

The official source code for this section is available on [GitHub](https://github.com/wsvincent/djangoforprofessionals/tree/main/ch11-books) for reference.

## 🎯 Conclusion

We’re at the end of quite a long section, but the architecture of our Bookstore project is now much clearer. We’ve added a **books model**, learned how to change the **URL structure**, and switched to the much more secure **UUID** pattern.

In the next section, we’ll learn about **foreign key relationships** and add a **reviews option** to our project. Stay tuned! 🚀
