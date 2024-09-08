# 📖 Permissions

In our Bookstore project, we currently have **no permissions set**. This means that any user, even one who is not logged in, can visit any page and perform any action. While this is fine for prototyping, implementing a robust permissions structure is essential before deploying a website to production. 🏗️

Fortunately, Django comes with built-in authorization options for locking down pages to either **logged-in users**, **specific groups**, or **users with specific permissions**. Let's explore how to implement these! 🚀

---

## 🔒 Restrict Access to Logged-In Users

There are several ways to restrict access to only logged-in users in Django:

1. **Using the `login_required()` Decorator** 🛠️: This is used for function-based views.
2. **Using `LoginRequiredMixin`** 🧩: This is more suitable for class-based views, which we are using in our project.

For our Bookstore project, we will use `LoginRequiredMixin` to limit access to the **Books** pages only to logged-in users.

**Steps to Restrict Access:**

1. **Import `LoginRequiredMixin`**: Import it at the top of your `views.py` file.
2. **Add `LoginRequiredMixin` to Class-Based Views**: It must be placed **before** the actual view class (`ListView` or `DetailView`) to function correctly.
3. **Add `login_url`**: This specifies the URL to redirect users to if they are not logged in. Since we use `django-allauth`, the login URL is `account_login`.

📝 Here is the updated code:

```python
# books/views.py
from django.contrib.auth.mixins import LoginRequiredMixin  # 🚨 New Import
from django.views.generic import ListView, DetailView
from .models import Book

class BookListView(LoginRequiredMixin, ListView):  # 🚨 New
    model = Book
    context_object_name = "book_list"
    template_name = "books/book_list.html"
    login_url = "account_login"  # 🔗 New

class BookDetailView(LoginRequiredMixin, DetailView):  # 🚨 New
    model = Book
    context_object_name = "book"
    template_name = "books/book_detail.html"
    login_url = "account_login"  # 🔗 New

  class BookCreateView(LoginRequiredMixin, CreateView):
    model = Book
    form_class = BookForm
    template_name = 'books/book_form.html'
    success_url = reverse_lazy('book_list')

    def form_valid(self, form):
        form.instance.creator = self.request.user  # Set the creator of the book
        return super().form_valid(form)

# ✏️ Update View for handling the editing of a book
class BookUpdateView(LoginRequiredMixin, UserPassesTestMixin, UpdateView):
    model = Book
    form_class = BookForm
    template_name = 'books/book_form.html'
    success_url = reverse_lazy('book_list')

    def test_func(self):
        # Ensure only the creator can edit the book
        book = self.get_object()
        return self.request.user == book.creator

# ❌ Delete View for handling the deletion of a book
class BookDeleteView(LoginRequiredMixin, UserPassesTestMixin, DeleteView):
    model = Book
    template_name = 'books/book_confirm_delete.html'
    success_url = reverse_lazy('book_list')

    def test_func(self):
        # Ensure only the creator can delete the book
        book = self.get_object()
        return self.request.user == book.creator

# 🖊️ Create View for handling the creation of a new review
class ReviewCreateView(LoginRequiredMixin, CreateView):
    model = Review
    form_class = ReviewForm
    template_name = 'books/book_detail.html'

    def form_valid(self, form):
        form.instance.author = self.request.user
        form.instance.book = get_object_or_404(Book, pk=self.kwargs['pk'])
        return super().form_valid(form)

    def get_success_url(self):
        return reverse_lazy('book_detail', kwargs={'pk': self.kwargs['pk']})
```

With this setup, if a user tries to access the "Books" page while not logged in, they will be redirected to the "Log In" page. If they are logged in, the "Books" page will load normally! 🚀


## 🔐 Setting Up Permissions in Django Admin

Django includes a basic permissions system that is managed through the **Django Admin** interface. To demonstrate this:

1. **Create a New User Account**: Go to the Admin homepage and click on **“+ Add”** next to **Users**. 👤
2. **Configure User Details**: Set the username, password, and provide an email address.
3. **Set User Permissions**: Scroll down to see the available permissions. For now, we'll leave these as defaults. 🔧


## 🛠️ Custom Permissions

Creating custom permissions is a common practice in Django projects. We can set these using the `Meta` class on our models. Let's add a custom permission that allows a special user to **read all books**. 📚

**Update the Model:**

Add the `Meta` class to the `Book` model to define the custom permission.

```python
# books/models.py
...
class Book(models.Model):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    title = models.CharField(max_length=200)
    author = models.CharField(max_length=200)
    price = models.DecimalField(max_digits=6, decimal_places=2)
    cover = models.ImageField(upload_to="covers/", blank=True)
    creator = models.ForeignKey(get_user_model(), on_delete=models.CASCADE, related_name="books")  # 🆕 New field

    class Meta:  # 🚨 New
        permissions = [
            ("special_status", "Can read all books"),  # 👓 New Permission
        ]

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse("book_detail", args=[str(self.id)])
...
```

After adding this, create a new migration and migrate the database:

```bash
docker-compose exec web python manage.py makemigrations books  # 🏗️ Make Migrations
docker-compose exec web python manage.py migrate  # 🚀 Migrate
```

## 👥 Assign Custom Permission to a User

To apply this custom permission to a user:

1. **Navigate to Users in Admin**: Find the user to whom you want to assign the permission. 🕵️‍♂️
2. **Add Permission**: Under "User permissions," select `books | book | Can read all books` and add it. ✔️

## 🧩 Using `PermissionRequiredMixin`

Now, we can use `PermissionRequiredMixin` to enforce the custom permission on a view. This mixin should be placed **after `LoginRequiredMixin`** but before the view class in the inheritance list.

```python
# books/views.py
from django.contrib.auth.mixins import (
    LoginRequiredMixin,
    PermissionRequiredMixin  # 🚨 New
)
from django.views.generic import ListView, DetailView
from .models import Book

class BookListView(LoginRequiredMixin, ListView):
    model = Book
    context_object_name = "book_list"
    template_name = "books/book_list.html"
    login_url = "account_login"

class BookDetailView(
    LoginRequiredMixin,
    PermissionRequiredMixin,  # 🚨 New
    DetailView):
    model = Book
    context_object_name = "book"
    template_name = "books/book_detail.html"
    login_url = "account_login"
    permission_required = "books.special_status"  # 🔑 New
```

This setup ensures that only users with the `special_status` permission can access the book detail page. 📜

## 🔄 Testing the Permissions

It's crucial to run tests to verify that permissions are working correctly. 🧪

**Update the Tests:**

```python
# books/tests.py
from django.contrib.auth import get_user_model
from django.contrib.auth.models import Permission  # 🚨 New
from django.test import TestCase
from django.urls import reverse
from .models import Book, Review

class BookTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        # Creating a test user
        cls.user = get_user_model().objects.create_user(
            username="reviewuser",
            email="reviewuser@email.com",
            password="testpass123",
        )

        # Assigning special permission to the user
        cls.special_permission = Permission.objects.get(
            codename="special_status"
        )  # 🚨 New

        # Creating a test book with the creator field set
        cls.book = Book.objects.create(
            title="Python Deep Dive",
            author="Muhammad Hashim",
            price="69.00",
            creator=cls.user,  # Set the creator to the test user
        )

        # Creating a test review for the book
        cls.review = Review.objects.create(
            book=cls.book,
            author=cls.user,
            review="An excellent review",
        )

    def test_book_listing(self):
        # Test if the book listing details are correct
        self.assertEqual(f"{self.book.title}", "Python Deep Dive")
        self.assertEqual(f"{self.book.author}", "Muhammad Hashim")
        self.assertEqual(f"{self.book.price}", "69.00")

    def test_book_list_view_for_logged_in_user(self):
        # Test if the book list view is accessible for logged-in users and uses the correct template
        self.client.login(username="reviewuser", password="testpass123")
        response = self.client.get(reverse("book_list"))
        self.assertEqual(response.status_code, 200)
        self.assertContains(response, "Python Deep Dive")
        self.assertTemplateUsed(response, "books/book_list.html")

    def test_book_list_view_for_logged_out_user(self):
        # Test if the book list view redirects logged-out users to the login page
        self.client.logout()
        response = self.client.get(reverse("book_list"))
        self.assertEqual(response.status_code, 302)
        self.assertRedirects(response, "%s?next=/books/" % (reverse("account_login")))
        response = self.client.get("%s?next=/books/" % (reverse("account_login")))
        self.assertContains(response, "Log In")

    def test_book_detail_view_with_permissions(self):
        # Test if the book detail view is accessible and displays the correct content for users with permission
        self.client.login(username="reviewuser", password="testpass123")
        self.user.user_permissions.add(self.special_permission)  # 🚨 Assigning permission
        response = self.client.get(self.book.get_absolute_url())
        no_response = self.client.get("/books/12345/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(no_response.status_code, 404)
        self.assertContains(response, "Python Deep Dive")
        self.assertContains(response, "An excellent review")
        self.assertTemplateUsed(response, "books/book_detail.html")

    def test_review_form_display(self):
        # Test if the review form is displayed on the book detail page
        self.client.login(username="reviewuser", password="testpass123")
        self.user.user_permissions.add(self.special_permission)  # 🚨 Ensure user has permission
        response = self.client.get(self.book.get_absolute_url())
        self.assertEqual(response.status_code, 200)  # Ensure the page loads correctly
        self.assertContains(response, "Leave a Review")
        self.assertContains(response, "Submit Review")

    def test_create_review(self):
        # Test if a review can be successfully created for a book
        self.client.login(username="reviewuser", password="testpass123")
        self.user.user_permissions.add(self.special_permission)  # 🚨 Ensure user has permission
        response = self.client.post(
            reverse("review_create", kwargs={"pk": self.book.pk}),
            {"review": "A very informative and deep knowledge book!"},
        )
        self.assertEqual(response.status_code, 302)  # Should redirect after successful post
        self.assertEqual(Review.objects.count(), 2)  # Check if a new review was added
        self.assertEqual(Review.objects.last().review, "A very informative and deep knowledge book!")
        self.assertEqual(Review.objects.last().author, self.user)  # Ensure the review author is correct
        self.assertRedirects(response, reverse("book_detail", kwargs={"pk": self.book.pk}))

    # 🚀 Test case to create a new book
    def test_create_book(self):
        # Ensure the user is logged in to create a book
        self.client.login(username="reviewuser", password="testpass123")
        response = self.client.post(
            reverse("book_create"),
            {
                "title": "Django Unleashed",
                "author": "Andrew Pinkham",
                "price": "59.00",
                "cover": "",  # Set cover to an empty string to simulate no file being uploaded
            },
        )
        self.assertEqual(response.status_code, 302)  # Should redirect after successful post
        self.assertEqual(Book.objects.count(), 2)  # Check if a new book was added

    # ✏️ Test case to update a book
    def test_update_book(self):
        # Ensure the user is logged in to update a book
        self.client.login(username="reviewuser", password="testpass123")
        self.user.user_permissions.add(self.special_permission)  # 🚨 Assigning permission
        response = self.client.post(
            reverse("book_update", kwargs={"pk": self.book.pk}),
            {
                "title": "Advanced Python Programming",
                "author": "Muhammad Hashim",
                "price": "79.00",
            },
        )
        self.book.refresh_from_db()  # Refresh from database to get updated values
        self.assertEqual(response.status_code, 302)  # Should redirect after successful post
        self.assertEqual(self.book.title, "Advanced Python Programming")  # Ensure the book title was updated

    # ❌ Test case to delete a book
    def test_delete_book(self):
        # Ensure the user is logged in to delete a book
        self.client.login(username="reviewuser", password="testpass123")
        self.user.user_permissions.add(self.special_permission)  # 🚨 Assigning permission
        response = self.client.post(reverse("book_delete", kwargs={"pk": self.book.pk}))
        self.assertEqual(response.status_code, 302)  # Should redirect after successful post
        self.assertEqual(Book.objects.count(), 0)  # Check if the book was deleted
```

Run the tests:

```bash
docker-compose exec web python manage.py test  # 🧪 Run Tests
```

## 📘 Explanation of Each Test Case 

### 1. **Setup Test Data (`setUpTestData`)** 🚀

This method sets up the initial data that will be used throughout all test cases. It runs once before any test is executed.

```python
@classmethod
def setUpTestData(cls):
    # 🧑‍💻 Creating a test user
    cls.user = get_user_model().objects.create_user(
        username="reviewuser",
        email="reviewuser@email.com",
        password="testpass123",
    )
```

- **📝 What it does**: Creates a user named `reviewuser` for testing purposes.
- **🔍 Why it's important**: This user will be used in multiple tests to simulate actions like logging in, creating, updating, and deleting books and reviews.

```python
    # 🛡️ Assigning special permission to the user
    cls.special_permission = Permission.objects.get(
        codename="special_status"
    )  # 🚨 New
```

- **📝 What it does**: Retrieves a special permission named `special_status` that some views require.
- **🔍 Why it's important**: This permission is needed for accessing specific views (like `book_detail`). We'll assign it to the user when needed in the tests.

```python
    # 📚 Creating a test book with the creator field set
    cls.book = Book.objects.create(
        title="Python Deep Dive",
        author="Muhammad Hashim",
        price="69.00",
        creator=cls.user,  # Set the creator to the test user
    )
```

- **📝 What it does**: Creates a `Book` titled "Python Deep Dive" authored by "Muhammad Hashim," priced at "69.00," and assigns `creator` to `reviewuser`.
- **🔍 Why it's important**: This book is the primary object for most tests. The `creator` field helps ensure only the user who created the book can edit or delete it.

```python
    # 🖊️ Creating a test review for the book
    cls.review = Review.objects.create(
        book=cls.book,
        author=cls.user,
        review="An excellent review",
    )
```

- **📝 What it does**: Creates a `Review` for the `Book` created earlier. The review content is "An excellent review," authored by `reviewuser`.
- **🔍 Why it's important**: This review will be used to test displaying reviews, creating new ones, and validating that only authorized users can interact with reviews.

### 2. **Test: Book Listing Details (`test_book_listing`)** 📚

```python
def test_book_listing(self):
    # ✅ Test if the book listing details are correct
    self.assertEqual(f"{self.book.title}", "Python Deep Dive")
    self.assertEqual(f"{self.book.author}", "Muhammad Hashim")
    self.assertEqual(f"{self.book.price}", "69.00")
```

- **📝 What it does**: Checks if the book's title, author, and price are stored and returned correctly by the `Book` model.
- **🔍 Why it's important**: Ensures that the `Book` model works as expected and the data integrity is maintained.

### 3. **Test: Book List View for Logged-In User (`test_book_list_view_for_logged_in_user`)** 🔓

```python
def test_book_list_view_for_logged_in_user(self):
    # 🔓 Test if the book list view is accessible for logged-in users and uses the correct template
    self.client.login(username="reviewuser", password="testpass123")
    response = self.client.get(reverse("book_list"))
    self.assertEqual(response.status_code, 200)
    self.assertContains(response, "Python Deep Dive")
    self.assertTemplateUsed(response, "books/book_list.html")
```

- **📝 What it does**:
  1. Logs in as `reviewuser`.
  2. Requests the `book_list` view.
  3. Checks if the page loads (`200 OK`), contains "Python Deep Dive," and uses the correct template (`books/book_list.html`).
- **🔍 Why it's important**: Confirms that logged-in users can view the book list and the page loads correctly with the right template.

### 4. **Test: Book List View for Logged-Out User (`test_book_list_view_for_logged_out_user`)** 🚫

```python
def test_book_list_view_for_logged_out_user(self):
    # 🚫 Test if the book list view redirects logged-out users to the login page
    self.client.logout()
    response = self.client.get(reverse("book_list"))
    self.assertEqual(response.status_code, 302)
    self.assertRedirects(response, "%s?next=/books/" % (reverse("account_login")))
    response = self.client.get("%s?next=/books/" % (reverse("account_login")))
    self.assertContains(response, "Log In")
```

- **📝 What it does**:
  1. Logs out the user.
  2. Tries to access `book_list` view.
  3. Verifies that it redirects to the login page.
  4. Checks that the login page contains "Log In."
- **🔍 Why it's important**: Ensures that only authenticated users can access the book list view.

### 5. **Test: Book Detail View with Permissions (`test_book_detail_view_with_permissions`)** 🛡️

```python
def test_book_detail_view_with_permissions(self):
    # 🛡️ Test if the book detail view is accessible and displays the correct content for users with permission
    self.client.login(username="reviewuser", password="testpass123")
    self.user.user_permissions.add(self.special_permission)  # 🚨 Assigning permission
    response = self.client.get(self.book.get_absolute_url())
    no_response = self.client.get("/books/12345/")
    self.assertEqual(response.status_code, 200)
    self.assertEqual(no_response.status_code, 404)
    self.assertContains(response, "Python Deep Dive")
    self.assertContains(response, "An excellent review")
    self.assertTemplateUsed(response, "books/book_detail.html")
```

- **📝 What it does**:
  1. Logs in as `reviewuser` and assigns `special_status` permission.
  2. Requests the book detail view.
  3. Checks if a non-existent book returns a `404 Not Found`.
  4. Verifies that the book detail page displays the correct content and uses the right template.
- **🔍 Why it's important**: Confirms that only users with the necessary permissions can access the book detail view.

### 6. **Test: Review Form Display (`test_review_form_display`)** 📝

```python
def test_review_form_display(self):
    # 📝 Test if the review form is displayed on the book detail page
    self.client.login(username="reviewuser", password="testpass123")
    self.user.user_permissions.add(self.special_permission)  # 🚨 Ensure user has permission
    response = self.client.get(self.book.get_absolute_url())
    self.assertEqual(response.status_code, 200)  # Ensure the page loads correctly
    self.assertContains(response, "Leave a Review")
    self.assertContains(response, "Submit Review")
```

- **📝 What it does**:
  1. Logs in as `reviewuser` and assigns the `special_status` permission.
  2. Requests the book detail page.
  3. Checks that the review form is displayed with "Leave a Review" and "Submit Review."
- **🔍 Why it's important**: Ensures that the review form is correctly displayed for users who have the right permissions.

### 7. **Test: Create a Review (`test_create_review`)** 🖊️

```python
def test_create_review(self):
    # 🖊️ Test if a review can be successfully created for a book
    self.client.login(username="reviewuser", password="testpass123")
    self.user.user_permissions.add(self.special_permission)  # 🚨 Ensure user has permission
    response = self.client.post(
        reverse("review_create", kwargs={"pk": self.book.pk}),
        {"review": "A very informative and deep knowledge book!"},
    )
    self.assertEqual(response.status_code, 302)  # Should redirect after successful post
    self.assertEqual(Review.objects.count(), 2)  # Check if a new review was added
    self.assertEqual(Review.objects.last().review, "A very informative and deep knowledge book!")
    self.assertEqual(Review.objects.last().author, self.user)  # Ensure the review author is correct
    self.assertRedirects(response, reverse("book_detail", kwargs={"pk": self.book.pk}))
```

- **📝 What it does**:
  1. Logs in as `reviewuser` and assigns the required permission.
  2. Posts a new review for the book.
  3. Checks if the review was created and the user is redirected.
  4. Verifies that the review content and author are correct.
- **🔍 Why it's important**: Confirms that users with the correct permissions can add reviews, and reviews are correctly stored.

### 8. **Test: Create a New Book (`test_create_book`)** 📘

```python
def test_create_book(self):
    # 📘 Ensure the user is logged in to create a book
    self.client.login(username="reviewuser", password="testpass123")
    response = self.client

.post(
        reverse("book_create"),
        {
            "title": "Django Unleashed",
            "author": "Andrew Pinkham",
            "price": "59.00",
            "cover": "",  # Set cover to an empty string to simulate no file being uploaded
        },
    )
    self.assertEqual(response.status_code, 302)  # Should redirect after successful post
    self.assertEqual(Book.objects.count(), 2)  # Check if a new book was added
```

- **📝 What it does**:
  1. Logs in as `reviewuser`.
  2. Posts a request to create a new book.
  3. Checks that the request is successful and a new book is created.
- **🔍 Why it's important**: Ensures that book creation works for authenticated users.

### 9. **Test: Update a Book (`test_update_book`)** 🛠️

```python
def test_update_book(self):
    # 🛠️ Ensure the user is logged in to update a book
    self.client.login(username="reviewuser", password="testpass123")
    self.user.user_permissions.add(self.special_permission)  # 🚨 Assigning permission
    response = self.client.post(
        reverse("book_update", kwargs={"pk": self.book.pk}),
        {
            "title": "Advanced Python Programming",
            "author": "Muhammad Hashim",
            "price": "79.00",
        },
    )
    self.book.refresh_from_db()  # Refresh from database to get updated values
    self.assertEqual(response.status_code, 302)  # Should redirect after successful post
    self.assertEqual(self.book.title, "Advanced Python Programming")  # Ensure the book title was updated
```

- **📝 What it does**:
  1. Logs in as `reviewuser` and assigns the `special_status` permission.
  2. Posts a request to update the book.
  3. Refreshes the book instance and checks if it was updated correctly.
- **🔍 Why it's important**: Verifies that the book update functionality works as expected for users with the necessary permissions.

### 10. **Test: Delete a Book (`test_delete_book`)** ❌

```python
def test_delete_book(self):
    # ❌ Ensure the user is logged in to delete a book
    self.client.login(username="reviewuser", password="testpass123")
    self.user.user_permissions.add(self.special_permission)  # 🚨 Assigning permission
    response = self.client.post(reverse("book_delete", kwargs={"pk": self.book.pk}))
    self.assertEqual(response.status_code, 302)  # Should redirect after successful post
    self.assertEqual(Book.objects.count(), 0)  # Check if the book was deleted
```

- **📝 What it does**:
  1. Logs in as `reviewuser` and assigns the necessary permission.
  2. Posts a request to delete the book.
  3. Verifies that the book is deleted from the database.
- **🔍 Why it's important**: Ensures that only authorized users can delete books and that deletion works as expected.
😊
## 📝 Conclusion

Permissions and groups can vary greatly depending on the project's needs. The basic approach is to **restrict access** and then **gradually allow it** as needed. In our case, we restricted access to logged-in users and then added more specific permissions for certain actions. 🎯

In the next section, we will add **search functionality** to our Bookstore site. Stay tuned! 🔍📚
