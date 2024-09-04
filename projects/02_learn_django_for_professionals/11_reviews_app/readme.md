# 📚 Reviews App

In this section, we’ll add a reviews app so that readers can leave reviews of their favorite books. It gives us a chance to discuss foreign keys, app structure, and dive into forms.

## 🔑 Foreign Keys

We’ve already used a foreign key with our user model but didn’t have to think about it. Now we do! Fundamentally, a database table can be thought of as similar to a spreadsheet with rows and columns. There needs to be a **primary key** field that is unique and refers to each record. In the last section, we changed that from `id` to a `UUID`, but one still exists!

This matters when we want to link two tables together. For example, our `Books` model will link to a `Reviews` model since each review has to be connected to a relevant book. This implies a **foreign key** relationship.

There are three possible types of foreign key relationships:

- **One-to-one**
- **One-to-many**
- **Many-to-many**

### 📌 One-to-One Relationship

A **one-to-one** relationship is the simplest kind. An example would be a table of people’s names and a table of social security numbers. Each person has only one social security number, and each social security number is linked to only one person.

In practice, one-to-one relationships are rare. It’s unusual for both sides of a relationship to be matched to only one counterpart. Some other examples could be country-flag or person-passport.

For more details, you can check the Django documentation [OnetoOne](https://docs.djangoproject.com/en/5.1/ref/models/fields/#onetoonefield).

### 📌 One-to-Many Relationship

A **one-to-many** relationship is more common and is the default foreign key setting within Django. For example, consider a restaurant where one customer can place many orders. For more information, refer to the Django documentation [OnetoMany](https://docs.djangoproject.com/en/5.1/ref/models/fields/#foreignkey).

### 📌 Many-to-Many Relationship

It’s also possible to have a **ManyToManyField** relationship. Let’s consider a list of books and a list of authors: each book could have more than one author, and each author can write more than one book. That’s a many-to-many relationship. Just as with the previous two examples, you need a linked Foreign Key field to connect the two lists. Additional examples include doctors and patients (every doctor sees multiple patients and vice versa) or employees and tasks (each employee has multiple tasks while each task is worked on by multiple employees).

Check out Django documentation for [ManyToManyField](https://docs.djangoproject.com/en/5.1/ref/models/fields/#manytomanyfield).

### 🎨 Database Design

Database design is a fascinating, deep topic that is both an art and a science. As the number of tables grows in a project over time, it is almost inevitable that a refactoring will need to occur to address issues around inefficiency, bloat, and outright errors. **Normalization** is the process of structuring a relational database though far beyond the scope of this section. Learn more about database normalization [here](https://en.wikipedia.org/wiki/Database_normalization).

---

### 📝 Reviews Model

Coming back to our basic reviews app, the first consideration is what type of foreign key relationship will there be. If we are going to link a user to a review, then it is a straightforward one-to-many relationship. However, it could also be possible to link books to reviews, which would be many-to-many. The “correct” choice quickly becomes somewhat subjective and certainly dependent upon the particular needs of the project.

In this project, we’ll treat the reviews app as a one-to-many between authors and reviews as it’s the simpler approach.

Here again, we face a choice around how to design our project. Do we add the `Reviews` model within our existing `books/models.py` file or create a dedicated reviews app that we then link to? Let’s start by adding a `Reviews` model to the books app.

### 🧑‍💻 Code Implementation

```python
# books/models.py
import uuid
from django.contrib.auth import get_user_model  # new
from django.db import models
from django.urls import reverse

class Book(models.Model):
    # Existing fields...
    pass

class Review(models.Model):  # new
    book = models.ForeignKey(
        Book,
        on_delete=models.CASCADE,
        related_name="reviews",
    )
    review = models.CharField(max_length=255)
    author = models.ForeignKey(get_user_model(),on_delete=models.CASCADE)

    def __str__(self):
        return self.review
```

#### 📝 Explanation:

- **Import Statements:** At the top, we include `get_user_model`, which is needed to refer to our CustomUser model.
- **Review Model:** We create a dedicated `Review` model.
  - The `book` field is the one-to-many foreign key that links `Book` to `Review`. We follow the standard practice of naming it the same as the linked model.
  - The `review` field contains the actual content, which perhaps could be a `TextField` depending on how much space you want to provide for review length! For now, we’ll force reviews to be short at 255 characters or less.
  - The `author` field links to the user model to auto-populate the current user with the review.

For all many-to-one relationships such as a ForeignKey, we must also specify an `on_delete` option. We also explicitly set the `related_name` to make it easier to follow the foreign key relationship “backwards” in the future on queries. Note that this name must be unique to avoid future problems. Lastly, using `get_user_model` helps reference our custom user model.

### 🛠️ Creating Migrations

Create a new migrations file for our changes and then run migrate to apply them.

```bash
docker-compose exec web python manage.py makemigrations books
Migrations for 'books':
  books/migrations/0002_review.py
    - Create model Review
docker-compose exec web python manage.py migrate
Operations to perform:
  Apply all migrations: account, accounts, admin, auth, books, contenttypes, sessions, sites
Running migrations:
  Applying books.0002_review... OK
```

### 🛡️ Admin Configuration

For the reviews app to appear in the admin, we need to update `books/admin.py` substantially by adding the `Review` model and specifying a display of `TabularInline`.

```python
# books/admin.py
from django.contrib import admin
from .models import Book, Review

class ReviewInline(admin.TabularInline):
    model = Review

class BookAdmin(admin.ModelAdmin):
    inlines = [ReviewInline,]
    list_display = ("title", "author", "price",)

admin.site.register(Book, BookAdmin)
```

Now navigate to the books section at `http://127.0.0.1:8000/admin/books/book/` and then click on any of the books to see the reviews visible on the individual book page.

### 🔄 Adding a User

We’re limited to reviews by existing users at this point. Let's add a user called `testuser`.

From the **Users** section on the Admin homepage, click on the “+ Add” button. Add a new user called `testuser` and a password. Click the “Save” button. On the next page, add `testuser@email.com` as the email address. Notice the password is encrypted now? Django does not store raw passwords.

### 🖼️ Templates

With the reviews model set, it is time to update our templates to display reviews on the individual page for each book. Add a basic “Reviews” section and then loop over all existing reviews.

```html
<!-- templates/books/book_detail.html -->
{% extends "_base.html" %}
{% block title %}{{ book.title }}{% endblock title %}
{% block content %}
<div class="book-detail">
  <h2><a href="">{{ book.title }}</a></h2>
  <p>Author: {{ book.author }}</p>
  <p>Price: {{ book.price }}</p>
  <div>
    <h3>Reviews</h3>
    <ul>
      {% for review in book.reviews.all %}
      <li>{{ review.review }} ({{ review.author }})</li>
      {% endfor %}
    </ul>
  </div>
</div>
{% endblock content %}
```
### 🌟 Template Explanation:

...
1. **📝 Section Title (`<h3>Reviews</h3>`):**
   - Displays a heading titled **"Reviews"** on the webpage.

2. **📋 Unordered List (`<ul>`):**
   - Creates an unordered list (`<ul>`) to display the reviews in a list format.

3. **🔄 Loop Over Reviews (`{% for review in book.reviews.all %}`):**
   - This is a Django template tag that starts a **`for` loop** to iterate through all the reviews related to the current book.
   - `book.reviews.all` retrieves all the reviews linked to the specific book using the **`related_name`** `reviews` defined in the model (`related_name="reviews"`).

4. **🗒️ List Item (`<li>{{ review.review }} ({{ review.author }})</li>`):**
   - For each review in the list:
     - Displays the content of the review with `{{ review.review }}`.
     - Shows the author of the review in parentheses with `{{ review.author }}`.

5. **🔚 End of Loop (`{% endfor %}`):**
   - Ends the **`for` loop** in the Django template. This ensures all reviews are displayed correctly.

6. **🛑 Close Unordered List (`</ul>`):**
   - Closes the unordered list after all reviews are displayed.
  
...



Navigate over to the “Python Deep Dive” individual page to see the result.

### 🧪 Tests

Time for tests. We need to create a new user for our review and add a review to the `setUpTestData` method in our test suite.

```python
# books/tests.py
from django.test import TestCase
from django.urls import reverse
from .models import Book, Review
from django.contrib.auth import get_user_model  # new


class BookTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user = get_user_model().objects.create_user(  # new
            username="reviewuser",
            email="reviewuser@email.com",
            password="testpass123",
        )
        cls.book = Book.objects.create(
            title="Python Deep Dive",
            author="Muhammad Hashim",
            price="69.00",
        )
        cls.review = Review.objects.create(  # new
            book=cls.book,
            author=cls.user,
            review="An excellent review",
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
### 🌟 Django Tests Explanations 🌟

Here’s a detailed breakdown of each step in the Django `TestCase` code:

1. **🧩 Importing Required Modules:**
   - `TestCase` from `django.test`: This is Django’s built-in testing framework, providing a simple way to test your Django apps.
   - `reverse` from `django.urls`: This function is used to generate URLs by reversing URL patterns.
   - Models `Book` and `Review`: These models are being tested.
   - `get_user_model` from `django.contrib.auth`: This function retrieves the user model that is currently active in the project. It is useful when you have a custom user model.

2. **📚 Defining the Test Class:**
   - `class BookTests(TestCase):` 
     - This class inherits from `TestCase`, making it a unit test class for the `Book` and `Review` models.
     - It contains setup and multiple test methods to verify the functionality of different components.

3. **🚀 Setting Up Test Data (`setUpTestData`):**
   - `@classmethod` decorator indicates that the method is a class method, meaning it sets up data once for the entire class, making tests faster.
   - `cls.user = get_user_model().objects.create_user(...)`:
     - Creates a test user named **`reviewuser`** with an email and password.
   - `cls.book = Book.objects.create(...)`:
     - Creates a `Book` object named **`Python Deep Dive`** with the author **Muhammad Hashim** and a price of **69.00**.
   - `cls.review = Review.objects.create(...)`:
     - Creates a `Review` object linked to the created `Book` and `User` with the content **"An excellent review."**
   - These objects are stored in class variables (`cls.user`, `cls.book`, `cls.review`) for easy access across all test methods.

4. **📖 Test Method 1: `test_book_listing`**
   - Verifies the correctness of the `Book` model's data:
     - `self.assertEqual(f"{self.book.title}", "Python Deep Dive")`: Checks if the `title` of the book is **`Python Deep Dive`**.
     - `self.assertEqual(f"{self.book.author}", "Muhammad Hashim")`: Checks if the `author` is **Muhammad Hashim**.
     - `self.assertEqual(f"{self.book.price}", "69.00")`: Ensures the `price` is **69.00**.

5. **🌐 Test Method 2: `test_book_list_view`**
   - Tests the **`book_list`** view:
     - `response = self.client.get(reverse("book_list"))`: Sends a GET request to the `book_list` URL using Django's `client`.
     - `self.assertEqual(response.status_code, 200)`: Verifies that the response status code is **200 (OK)**.
     - `self.assertContains(response, "Python Deep Dive")`: Ensures the response contains the text **`Python Deep Dive`**.
     - `self.assertTemplateUsed(response, "books/book_list.html")`: Checks if the correct template, **`books/book_list.html`**, is used.

6. **🔍 Test Method 3: `test_book_detail_view`**
   - Tests the **`book_detail`** view:
     - `response = self.client.get(self.book.get_absolute_url())`: Sends a GET request to the detail page of the book using its `get_absolute_url()` method.
     - `no_response = self.client.get("/books/12345/")`: Tries to access a non-existing book URL to check for a 404 error.
     - `self.assertEqual(response.status_code, 200)`: Confirms that the response for the valid book URL is **200 (OK)**.
     - `self.assertEqual(no_response.status_code, 404)`: Ensures the response for the non-existing book URL is **404 (Not Found)**.
     - `self.assertContains(response, "Python Deep Dive")`: Confirms the response contains the book's title **`Python Deep Dive`**.
     - `self.assertTemplateUsed(response, "books/book_detail.html")`: Verifies the correct template, **`books/book_detail.html`**, is used for rendering.


If you run the tests now, they all should pass.

```bash
docker-compose exec web python manage.py test
Creating test database for alias 'default'...
System check identified no issues (0 silenced).
.................
----------------------------------------------------------------------
Ran 17 tests in 0.260s
OK
Destroying test database for alias 'default'...
```

### 🌳 Git Integration

Add our new code changes to Git and include a commit message for the section.

```bash
git status
git add .
git commit -m 'Added reviews app'
```

### 🔚 Conclusion

With more time, we might update the reviews functionality with a form on the page itself. However, this means AJAX calls using either `htmx`, `jQuery`, `React`, `Vue`, or another dedicated JavaScript framework. Unfortunately, covering that fully is well beyond the scope of this section.

As the project grows, it might also make sense to split reviews off into its own dedicated app. In general, keeping things as simple as possible—adding foreign keys within an existing app until it becomes too large to understand easily—is a solid approach.

In the next section, we will add image uploads to our site so there can be covers for each book. 📚
