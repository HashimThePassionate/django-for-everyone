# 📚 Building a Library API with Django REST Framework

## Transforming the Library Website 🌐

Currently, your library website has a single page that **displays all the books** in the database. The goal is to turn this into a **web API** that outputs **data** rather than a traditional webpage.

### What Is a Web API? 🤔

Before diving into the code, let’s quickly review what a **web API** is. In a traditional website, when you visit a URL, you get a webpage filled with HTML, CSS, and JavaScript. But with a web API:

- There is **no HTML or CSS** for creating webpages.
- Instead, it serves **pure data** (often in **JSON format**), which can be read by other applications.
- APIs allow for **interaction with data** through HTTP verbs (like `GET`, `POST`, `PUT`, `DELETE`).

For now, we’ll focus on a **simple API** where the user can only **read** the content (i.e., view all the books), not update it.

---

## 📦 Adding Django REST Framework (DRF) to Your Django Project

### Step 1: Installing Django REST Framework ⚙️

The first thing you need to do is install **Django REST Framework** (DRF), a powerful and flexible toolkit for building web APIs in Django.

To install DRF, you’ll use `pipenv` (assuming you’re using it to manage dependencies).

#### Command to Install DRF:
```bash
pipenv install djangorestframework
```

Make sure your **Django server** is not running while you do this (you can quit the server using `Control + C`).

### Step 2: Updating `settings.py` to Include DRF 🔧

After installing DRF, you need to notify Django that you’ve added a new third-party app by updating the `INSTALLED_APPS` list in your **settings.py** file.

#### Here’s how you should modify your `settings.py` file:

```python
# django_project/settings.py

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "rest_framework",  # new: Django REST Framework
    "books",  # your books app
]
```

I recommend separating **third-party apps** (like `rest_framework`) from **local apps** (like `books`) for better organization. This becomes helpful when the number of apps grows in larger projects.

---

### Step 3: Creating an API App 🛠️

To keep the logic of your API separate from the rest of the project, it’s a good idea to create a **dedicated API app**. This app will handle the API-related views, serializers, and URLs.

#### Command to create the `apis` app:
```bash
python manage.py startapp apis
```

Now, add this new `apis` app to your `INSTALLED_APPS` section in `settings.py`.

#### Update `INSTALLED_APPS`:
```python
# django_project/settings.py

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",
    "rest_framework",  # third-party app
    "books",  # local app
    "apis",  # new API app
]
```
---
## 🛠️ **URLs**  

Let's start by configuring our URL routes for the API! 🌐 Setting up an API endpoint is just like adding any traditional Django URL route. Here's how to do it:

### 1. **Step 1: Update the Project-level URL Configs**  
   In the `django_project/urls.py` file, we need to include the `apis` app and configure its URL route to be accessed at `api/`. 🎯

**Code Example**:  
   ```python
   # django_project/urls.py
   from django.contrib import admin
   from django.urls import path, include

   urlpatterns = [
       path("admin/", admin.site.urls),
       path("api/", include("apis.urls")),  # 🌟 new addition!
       path("", include("books.urls")),
   ]
   ```

### 2. **Step 2: Create the API URL Config File**  
   Now, let's create a new file called `apis/urls.py`. This will be where we define our API routes. 🔧

   - This file will import a future view called `BookAPIView` and assign it to the URL route `""` (empty string), meaning it will be available at `api/`. 🌐
   - We'll also name this route `book_list`, which will make it easier to refer to in the future.

**Code Example**:  
```python
# apis/urls.py
from django.urls import path
from .views import BookAPIView
urlpatterns = [
path("", BookAPIView.as_view(), name="book_list"),
]
```
---

## 📚 **Views for Library API**

### 🎯 **Views in Django REST Framework (DRF)**

In traditional Django, views are used to send data to templates for rendering on a webpage. However, in Django REST Framework (DRF), views are a bit different! Instead of sending data to a webpage, DRF views return **serialized data in JSON format**. 🛠️

**Key Components in DRF Views**:
- **Model** 🏛️
- **URL** 🌐
- **Serializer** 🔄 (We will cover this in the next section!)

We'll use DRF's **generic views**, which make common operations easier! For example, we’ll use `ListAPIView` to display all the books in our library. 📚✨

### ⚙️ **Setting Up the Views**  

### 1. **Step 1: Naming the Views File**  
   Some developers prefer to name their API views file `apiviews.py` or `api.py` to avoid confusion. But when you're working within a dedicated `apis` app, calling it just `views.py` is completely fine! 👍

#### 2. **Step 2: Update the Views File**  
   Let’s update the `apis/views.py` file to define our API view! This view will list all books from our `Book` model.

   **Code Example**:  
   ```python
   # apis/views.py
   from rest_framework import generics
   from books.models import Book
   from .serializers import BookSerializer

   class BookAPIView(generics.ListAPIView):
       queryset = Book.objects.all()  # 📚 Fetch all books
       serializer_class = BookSerializer  # 🛠️ Use BookSerializer
   ```

   - **Imports**:  
     We import the **generic views** from DRF, the **Book model** from our `books` app, and the **BookSerializer** from the `apis` app (which we’ll create soon!).
   
   - **View Class**:  
     We define a class called `BookAPIView` using `ListAPIView` to create a read-only endpoint that lists all available books. 🎯

   - **Queryset**:  
     This specifies which data to retrieve — in this case, all books! 📖
   
   - **Serializer Class**:  
     The view will use the `BookSerializer` to convert the data into a JSON format that can be used by the API. 🌐
---

## 📚 **Serializers for Library API**

### 🔄 **Serializers in Django REST Framework**

We’re now on the final step of setting up our API: creating the **serializer**! 🎉

A serializer is like a translator—it takes complex data such as **querysets** and **model instances** and converts it into a format that is easy to work with over the internet, usually **JSON**. 🛠️

But there’s more! It also works in reverse. You can **deserialize** JSON data, validate it, and convert it into Python **dictionaries** that can be saved into the database! 🗃️

The beauty of Django REST Framework is how it simplifies this process for us! ✨ We’ll go deeper into serialization later, but for now, let’s focus on how easy it is to create a serializer.

### 1. **Create a new file**  
   In your text editor, create a new file called `apis/serializers.py`. This will hold our `BookSerializer`.

### 2. **Define the Serializer**  
   Here’s what your serializer file should look like:

   **Code Example**:  
   ```python
   # apis/serializers.py
   from rest_framework import serializers
   from books.models import Book

   class BookSerializer(serializers.ModelSerializer):
       class Meta:
           model = Book  # 🏛️ Define the model to use
           fields = ("title", "subtitle", "author", "isbn")  # 📝 Specify the fields
   ```
**Explanations:**
- **Imports**:  
 We import Django REST Framework’s `serializers` class and the `Book` model from our `books` app. 📚

- **ModelSerializer**:  
 We extend `ModelSerializer` to create a `BookSerializer` class. This tells Django which model we are using and which **fields** 
 we want to include in the API response. For our example, we expose the `title`, `subtitle`, `author`, and `isbn` fields. ✨

---

## 📚 **Testing the Library API**

### ✅ **Testing in Django and Django REST Framework (DRF)**

Testing is an essential part of ensuring your code works as expected. 🛠️ Django relies on Python’s built-in `unittest` module, with some awesome Django-specific extensions. The most important of these is the **test client**, which simulates GET and POST requests. 🎯

Django REST Framework (DRF) also offers helper classes to extend Django’s test framework. One of these is **APIClient**, which we’ll use to test retrieving API data from our database! 🧪

### 📝 **Writing API Tests**  

We already have tests for our **Book** model in `books/tests.py`, so let’s focus on testing our **API endpoint**. We’ll check:
1. The API uses the correct URL.
2. The API returns the expected **HTTP 200 status code**.
3. The content from the API matches the data in our database.

⚙️ **Step 1: Writing the Tests**

Open the `apis/tests.py` file and add the following code:

**Code Example**:  
```python
# apis/tests.py
from django.urls import reverse
from rest_framework import status
from rest_framework.test import APITestCase
from books.models import Book

class APITests(APITestCase):
    @classmethod
    def setUpTestData(cls):
        cls.book = Book.objects.create(
            title="Learning Web Development",
            subtitle="A Comprehensive Guide to Modern Web Apps",
            author="Jane Doe",
            isbn="9781234567890",
        )

    def test_api_listview(self):
        response = self.client.get(reverse("book_list"))
        self.assertEqual(response.status_code, status.HTTP_200_OK)  # ✅ Check status code
        self.assertEqual(Book.objects.count(), 1)  # 🧮 Check number of books in database
        self.assertContains(response, self.book)  # 📦 Check response contains the book data
```

Here’s what’s happening:
- **Imports**: We import `reverse` from Django and `status`, `APITestCase` from DRF. We also import the **Book** model from the `books` app. 📚
- **APITests Class**: This class extends `APITestCase` to set up our tests.
  - **setUpTestData**: This method creates a test book instance in the database with the title `"Learning Web Development"`, subtitle `"A Comprehensive Guide to Modern Web Apps"`, and author `"Jane Doe"`.
  - **test_api_listview**: This method checks if the API returns the expected URL, status code, book count, and data.

#### 🚀 **Step 2: Running the Tests**

Stop your local server and run the test suite with the following command:

```bash
python manage.py test
```

You'll see something like this in the output:

```bash
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
...
----------------------------------------------------------------------
Ran 3 tests in 0.009s
OK
Destroying test database for alias 'default'...
```

Here, **3 tests** passed because there were 2 tests in `books/tests.py` and 1 test in `apis/tests.py`.

#### 💡 **Running Specific Tests**

When your project grows, you may want to test just a specific app. To do that, run the following command:

```bash
python manage.py test apis
```

This will only run the tests within the `apis` app. Here’s an example output:

```bash
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.
----------------------------------------------------------------------
Ran 1 test in 0.005s
OK
Destroying test database for alias 'default'...
```
---


