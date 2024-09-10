# 📦 Using `django-storages` for Media File Management with AWS S3

For production environments, it's better to store user-uploaded media files on a scalable and secure storage solution like Amazon S3 rather than the local server. This approach provides better **security**, **scalability**, **reliability**, and **cost-effectiveness**.

## 🚀 Why Use Amazon S3 with `django-storages`?

- **Scalability**: S3 can handle large amounts of data without needing to manage storage capacity.
- **Security**: Features like encryption and access control ensure secure storage of data.
- **Reliability**: Offers high durability and availability for stored data.
- **Cost-Effective**: You only pay for the storage and bandwidth you use.

### 🛠️ Steps to Configure `django-storages` with AWS S3

1. **Install `django-storages` and `boto3`**:
   ```bash
   pip install django-storages boto3
   ```
   - `django-storages` provides support for storing Django's media files on cloud storage services like AWS S3.
   - `boto3` is the AWS SDK for Python that allows Python developers to interact with AWS services.

2. **Add to `requirements.txt`**:
   ```text
   django-storages==1.13.1
   boto3==1.28.0
   ```
   - Adding these dependencies ensures they are installed whenever the project is set up or built using Docker.

3. **Update `settings.py`**:

   ```python
   # settings.py

   INSTALLED_APPS = [
       ...
       'storages',  # Add this line for django-storages
   ]

   # AWS S3 settings
   AWS_ACCESS_KEY_ID = 'your-access-key-id'  # Replace with your AWS Access Key ID
   AWS_SECRET_ACCESS_KEY = 'your-secret-access-key'  # Replace with your AWS Secret Access Key
   AWS_STORAGE_BUCKET_NAME = 'your-bucket-name'  # Replace with your S3 bucket name
   AWS_S3_REGION_NAME = 'your-region'  # Replace with your AWS region, e.g., 'us-east-1'
   AWS_S3_CUSTOM_DOMAIN = f'{AWS_STORAGE_BUCKET_NAME}.s3.amazonaws.com'

   # Media settings
   DEFAULT_FILE_STORAGE = 'storages.backends.s3boto3.S3Boto3Storage'
   MEDIA_URL = f'https://{AWS_S3_CUSTOM_DOMAIN}/media/'

   # Local development media settings
   if DEBUG:
       MEDIA_URL = "/media/"
       MEDIA_ROOT = BASE_DIR / "media"
   ```

   - **`storages.backends.s3boto3.S3Boto3Storage`**: Specifies the storage backend for handling media files using Amazon S3.
   - **`AWS_ACCESS_KEY_ID`** and **`AWS_SECRET_ACCESS_KEY`**: Credentials for accessing your AWS account. Keep these secure.
   - **`AWS_STORAGE_BUCKET_NAME`**: Name of the S3 bucket where media files will be stored.
   - **`AWS_S3_CUSTOM_DOMAIN`**: Custom domain for serving files from the S3 bucket.
   - **`MEDIA_URL`**: URL to access media files stored in the S3 bucket.
   - **`MEDIA_ROOT` and `MEDIA_URL` for DEBUG**: Local settings to serve media files in development mode.

4. **Create an AWS S3 Bucket**:
   - Go to the AWS S3 console.
   - Click on **Create Bucket**.
   - Enter a unique name for your bucket.
   - Choose a region.
   - Set appropriate permissions and settings.
   - Click **Create Bucket**.

5. **Configure AWS Credentials**:
   - Ensure you have your AWS credentials set in your environment variables or use AWS IAM roles for better security.

### 🔄 Next Steps

To further secure and manage your file uploads:

1. **Add Extra Validation for Image Uploads**:
   - Use libraries like `python-magic` to detect file types and validate images securely.

2. **Create Dedicated Forms for CRUD Operations**:
   - Implement forms for creating, editing, and deleting books and cover images, ensuring proper validation.

3. **Write Tests for Form Validation**:
   - Write test cases focusing on the validation logic to prevent malicious uploads.

4. **Use `django-cleanup`**:
   - Install `django-cleanup` to automatically delete old files when a new file is uploaded or a model instance is deleted. Install it using:
   ```bash
   pip install django-cleanup
   ```
   - Add to `requirements.txt`:
   ```text
   django-cleanup==6.0.1
   ```
   - Add to `INSTALLED_APPS` in `settings.py`:
   ```python
   INSTALLED_APPS = [
       ...
       'django_cleanup.apps.CleanupConfig',  # Add this line
   ]
   ```

## 🖊️ CRUD Operations for Books

### 1. **Create Book**

Update your views to handle creating, editing, and deleting books. Only the author who created the book can edit or delete it. All authenticated users can create new books.

```python
# books/views.py

from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from django.urls import reverse_lazy
from django.shortcuts import get_object_or_404
from django.http import HttpResponseForbidden
from .models import Book, Review
from .forms import ReviewForm, BookForm

# 📚 List View for displaying all books
class BookListView(ListView):
    model = Book
    context_object_name = "book_list"
    template_name = "books/book_list.html"

# 📖 Detail View for displaying a specific book's details and reviews
class BookDetailView(DetailView):
    model = Book
    context_object_name = "book"
    template_name = "books/book_detail.html"

    def get_context_data(self, **kwargs):
        # Add an empty review form to the context
        context = super().get_context_data(**kwargs)
        context['form'] = ReviewForm()
        return context

# 🖊️ Create View for handling the creation of a new book
class BookCreateView(CreateView):
    model = Book
    form_class = BookForm
    template_name = 'books/book_form.html'
    success_url = reverse_lazy('book_list')

    def form_valid(self, form):
        # Automatically set the creator to the logged-in user
        form.instance.creator = self.request.user
        return super().form_valid(form)

# ✏️ Update View for handling the editing of a book
class BookUpdateView(UpdateView):
    model = Book
    form_class = BookForm
    template_name = 'books/book_form.html'
    success_url = reverse_lazy('book_list')

    def dispatch(self, request, *args, **kwargs):
        # Ensure only the creator can update the book
        book = self.get_object()
        if book.creator != self.request.user:
            return HttpResponseForbidden("You are not allowed to edit this book.")
        return super().dispatch(request, *args, **kwargs)

# ❌ Delete View for handling the deletion of a book
class BookDeleteView(DeleteView):
    model = Book
    template_name = 'books/book_confirm_delete.html'
    success_url = reverse_lazy('book_list')

    def dispatch(self, request, *args, **kwargs):
        # Ensure only the creator can delete the book
        book = self.get_object()
        if book.creator != self.request.user:
            return HttpResponseForbidden("You are not allowed to delete this book.")
        return super().dispatch(request, *args, **kwargs)

# 🖊️ Create View for handling the creation of a new review
class ReviewCreateView(CreateView):
    model = Review
    form_class = ReviewForm
    template_name = 'books/book_detail.html'

    def form_valid(self, form):
        # Automatically set the author to the logged-in user
        form.instance.author = self.request.user
        form.instance.book = get_object_or_404(Book, pk=self.kwargs['pk'])
        return super().form_valid(form)

    def get_success_url(self):
        # Redirect back to the book detail page after creating a review
        return reverse_lazy('book_detail', kwargs={'pk': self.kwargs['pk']})
```

#### Explanation:
- **`BookListView`**: Displays a list of all books.
- **`BookDetailView`**: Displays details for a specific book and its reviews.
- **`BookCreateView`**: Handles creating a new book. The creator is set to the currently logged-in user.
- **`BookUpdateView`**: Handles editing an existing book. Only the creator of the book can edit it.
- **`BookDeleteView`**: Handles deleting a book. Only the creator of the book can delete it.
- **`ReviewCreateView`**: Handles creating a new review for a book. The review author is set to the currently logged-in user.

### 2. **Create `BookForm` for Creating/Editing Books**

```python
# books/forms.py

from django import forms
from .models import Book, Review
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit

# 🖊️ Form for creating and editing books
class BookForm(forms.ModelForm):
    class Meta:
        model = Book
        fields = ['title', 'author', 'price', 'cover']

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.helper = FormHelper()
        self.helper.form_method = 'post'
        self.helper.add_input(Submit('submit', 'Save Book'))
```

#### Explanation:
- **`BookForm`**: A Django form used for creating and editing books.
- **`FormHelper`**: Used by `crispy_forms` for styling the form and adding a submit button.

### 3. **Create Templates for Creating, Editing, and Deleting Books**

- **`book_form.html`** for creating and editing:
  
```html
<!-- templates/books/book_form.html -->
{% extends "_base.html" %}
{% load crispy_forms_tags %}
{% block content %}
<h2>{{ form.instance.pk|yesno:"Edit,Add" }} Book</h2>
<form method="post" enctype="multipart/form-data">
    {% csrf_token %}
    {{ form|crispy }}
    <button type="submit" class="btn btn-primary">Save Book</button>
</form>
{% endblock %}
```

#### Explanation:
- **`{% csrf_token %}`**: CSRF protection for forms.
- **`{{ form|crispy }}`**: Uses `crispy_forms` to render the form beautifully.

- **`book_confirm_delete.html`** for deleting:
  
```html
<!-- templates/books/book_confirm_delete.html -->
{% extends "_base.html" %}
{% load crispy_forms_tags %}
{% block content %}
<h2>Delete Book: {{ book.title }}</h2>
<form method="post">
    {% csrf_token %}
    <p>Are you sure you want to delete this book?</p>
    <button type="submit" class="btn btn-danger">Confirm Delete</button>
</form>
{% endblock %}
```

#### Explanation:
- Provides a confirmation page for deleting a book.

### 4. **Update `urls.py` for New Views**

```python
# books/urls.py

from django.urls import path
from .views import (
    BookListView, BookDetailView, BookCreateView, BookUpdateView, BookDeleteView, ReviewCreateView
)

urlpatterns = [
    path('', BookListView.as_view(), name='book_list'),
    path('<uuid:pk>/', BookDetailView.as_view(), name='book_detail'),
    path('create/', BookCreateView.as_view(), name='book_create'),
    path('<uuid:pk>/update/', BookUpdateView.as_view(), name='book_update'),
    path('<uuid:pk>/delete/', BookDeleteView.as_view(), name='book_delete'),
    path('<uuid:pk>/review/', ReviewCreateView.as_view(), name='review_create'),
]
```

#### Explanation:
- **`path()`**: Defines URL patterns for CRUD operations and review creation.

### 5. 📝 **Update the Book Detail Page to Include CRUD Operations**

To display the **Create**, **Edit**, and **Delete** buttons for books on the book detail page, we need to add these buttons to the `book_detail.html` template and ensure they are visible to users with the appropriate permissions.

### Updated `book_detail.html` Template

```html
<!-- templates/books/book_detail.html -->
{% extends "_base.html" %}
{% load crispy_forms_tags %}
{% block title %}{{ book.title }}{% endblock title %}
{% block content %}
<div class="book-detail">
  {% if book.cover %}
  <img class="bookcover" src="{{ book.cover.url }}" alt="{{ book.title }}" />
  {% endif %}
  <h2>{{ book.title }}</h2>
  <p>Author: {{ book.author }}</p>
  <p>Price: {{ book.price }}</p>

  <!-- 🖊️ Edit and Delete buttons (visible only to the book creator) -->
  <div class="book-actions">
    {% if user.is_authenticated %}
      <a href="{% url 'book_create' %}" class="btn btn-success">Create New Book</a>
      {% if book.creator == user %}
        <a href="{% url 'book_update' book.pk %}" class="btn btn-warning">Edit Book</a>
        <a href="{% url 'book_delete' book.pk %}" class="btn btn-danger">Delete Book</a>
      {% endif %}
    {% endif %}
  </div>

  <!-- 📄 Reviews Section -->
  <div>
    <h3>Reviews</h3>
    <ul>
      {% for review in book.reviews.all %}
      <li>{{ review.review }} ({{ review.author }})</li>
      {% empty %}
      <li>No reviews yet. Be the first to review this book!</li>
      {% endfor %}
    </ul>
  </div>

  <!-- 📝 Review Form -->
  <div>
    <h3>Leave a Review</h3>
    <form method="post" action="{% url 'review_create' book.pk %}">
      {% csrf_token %}
      {{ form|crispy }}
      <!-- Render the form with Crispy Forms for styling -->
      <button type="submit" class="btn btn-primary">Submit Review</button>
    </form>
  </div>
</div>
{% endblock content %}
```

#### Explanation:
- **`{% if book.creator == user %}`**: Checks if the current user is the creator of the book to show the "Edit" and "Delete" buttons.

## 🧪 Test Cases for CRUD Operations

Update `tests.py` to include tests for creating, editing, and deleting books, ensuring that only the creator can edit or delete.

```python
# books/tests.py
from django.test import TestCase
from django.urls import reverse
from .models import Book, Review
from django.contrib.auth import get_user_model

class BookTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        # Create two users: one for creating books and one for testing access restrictions
        cls.user = get_user_model().objects.create_user(
            username="reviewuser",
            email="reviewuser@email.com",
            password="testpass123",
        )
        cls.other_user = get_user_model().objects.create_user(
            username="otheruser",
            email="otheruser@email.com",
            password="otherpass123",
        )
        cls.book = Book.objects.create(
            title="Python Deep Dive",
            author="Muhammad Hashim",
            price="69.00",
            creator=cls.user  # Set creator to reviewuser
        )
        cls.review = Review.objects.create(
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

    def test_review_form_display(self):
        response = self.client.get(self.book.get_absolute_url())
        self.assertContains(response, "Leave a Review")
        self.assertContains(response, "Submit Review")

    def test_create_review(self):
        self.client.login(username="reviewuser", password="testpass123")
        response = self.client.post(
            reverse("review_create", kwargs={"pk": self.book.pk}),
            {"review": "A very informative and deep knowledge book!"},
        )
        self.assertEqual(response.status_code, 302)
        self.assertEqual(Review.objects.count(), 2)
        self.assertEqual(Review.objects.last().review, "A very informative and deep knowledge book!")
        self.assertEqual(Review.objects.last().author, self.user)
        self.assertRedirects(response, reverse("book_detail", kwargs={"pk": self.book.pk}))

    # 🚀 Test case to create a new book
    def test_create_book(self):
        self.client.login(username="reviewuser", password="testpass123")
        response = self.client.post(
            reverse("book_create"),
            {
                "title": "Django Unleashed",
                "author": "Andrew Pinkham",
                "price": "59.00",
                "cover": "",  # Fix for file field
            },
        )
        self.assertEqual(response.status_code, 302)  # Should redirect after successful post
        self.assertEqual(Book.objects.count(), 2) 

    # ✏️ Test case to update a book
    def test_update_book(self):
        self.client.login(username="reviewuser", password="testpass123")
        response = self.client.post(
            reverse("book_update", kwargs={"pk": self.book.pk}),
            {
                "title": "Advanced Python Programming",
                "author": "Muhammad Hashim",
                "price": "79.00",
            },
        )
        self.book.refresh_from_db()
        self.assertEqual(response.status_code, 302)
        self.assertEqual(self.book.title, "Advanced Python Programming")

    def test_update_book_for_non_creator(self):
        self.client.login(username="otheruser", password="otherpass123")
        response = self.client.post(
            reverse("book_update", kwargs={"

pk": self.book.pk}),
            {
                "title": "Advanced Python Programming",
                "author": "Muhammad Hashim",
                "price": "79.00",
            },
        )
        self.assertEqual(response.status_code, 403)  # Forbidden access

    # ❌ Test case to delete a book
    def test_delete_book(self):
        self.client.login(username="reviewuser", password="testpass123")
        response = self.client.post(reverse("book_delete", kwargs={"pk": self.book.pk}))
        self.assertEqual(response.status_code, 302)
        self.assertEqual(Book.objects.count(), 0)

    def test_delete_book_for_non_creator(self):
        self.client.login(username="otheruser", password="otherpass123")
        response = self.client.post(reverse("book_delete", kwargs={"pk": self.book.pk}))
        self.assertEqual(response.status_code, 403)  # Forbidden access
```

#### Explanation:
- **Test Cases**:
  - **`test_create_book`**: Ensures that authenticated users can create a book.
  - **`test_update_book`**: Ensures that only the creator can edit a book.
  - **`test_update_book_for_non_creator`**: Ensures that a non-creator cannot edit a book.
  - **`test_delete_book`**: Ensures that only the creator can delete a book.
  - **`test_delete_book_for_non_creator`**: Ensures that a non-creator cannot delete a book.

### 🎯 Conclusion

With these steps, you now have a fully functional Django project using AWS S3 with `django-storages`, complete CRUD operations for books, and comprehensive test cases to ensure everything works smoothly! 😊