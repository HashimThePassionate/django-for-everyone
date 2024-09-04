# books/tests.py
from django.test import TestCase  # Import TestCase for testing
from django.urls import reverse  # Import reverse to generate URLs for views
from .models import Book, Review  # Import Book and Review models to test with
from django.contrib.auth import get_user_model  # Import user model utility

class BookTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        # 🧑‍💻 Create a user for testing purposes
        cls.user = get_user_model().objects.create_user(
            username="reviewuser",
            email="reviewuser@email.com",
            password="testpass123",
        )
        # 📚 Create a book object for testing
        cls.book = Book.objects.create(
            title="Python Deep Dive",
            author="Muhammad Hashim",
            price="69.00",
        )
        # 📝 Create a review linked to the book and user for testing
        cls.review = Review.objects.create(
            book=cls.book,
            author=cls.user,
            review="An excellent review",
        )

    # 🔍 Test case to verify that book data is stored correctly
    def test_book_listing(self):
        self.assertEqual(f"{self.book.title}", "Python Deep Dive")
        self.assertEqual(f"{self.book.author}", "Muhammad Hashim")
        self.assertEqual(f"{self.book.price}", "69.00")

    # 📄 Test case to verify that the book list view is displayed correctly
    def test_book_list_view(self):
        response = self.client.get(reverse("book_list"))
        self.assertEqual(response.status_code, 200)  # Check if status code is 200 (OK)
        self.assertContains(response, "Python Deep Dive")  # Ensure book title is displayed
        self.assertTemplateUsed(response, "books/book_list.html")  # Verify the correct template is used

    # 📖 Test case to verify that the book detail view is displayed correctly
    def test_book_detail_view(self):
        response = self.client.get(self.book.get_absolute_url())  # Access the book detail view
        no_response = self.client.get("/books/12345/")  # Access a non-existing URL to test 404
        self.assertEqual(response.status_code, 200)  # Check if status code is 200 (OK)
        self.assertEqual(no_response.status_code, 404)  # Check if status code is 404 (Not Found)
        self.assertContains(response, "Python Deep Dive")  # Ensure book title is displayed
        self.assertTemplateUsed(response, "books/book_detail.html")  # Verify the correct template is used

    # 🖊️ Test case to check if the review form is present on the book detail page
    def test_review_form_display(self):
        response = self.client.get(self.book.get_absolute_url())
        self.assertContains(response, "Leave a Review")  # Check if the form is rendered on the page
        self.assertContains(response, "Submit Review")  # Check if the submit button is present

    # ✍️ Test case for successfully creating a new review
    def test_create_review(self):
        self.client.login(username="reviewuser", password="testpass123")  # Log in the test user
        response = self.client.post(
            reverse("review_create", kwargs={"pk": self.book.pk}),
            {"review": "A very informative and deep knowledge book!"},  # New review data
        )
        # ✅ Verify that the review was created successfully
        self.assertEqual(response.status_code, 302)  # Should redirect after successful post
        self.assertEqual(Review.objects.count(), 2)  # Check if a new review has been added
        self.assertEqual(Review.objects.last().review, "A very informative and deep knowledge book!")  # Verify content of the new review
        self.assertEqual(Review.objects.last().author, self.user)  # Verify the author is the logged-in user
        self.assertRedirects(response, reverse("book_detail", kwargs={"pk": self.book.pk}))  # Verify redirection to the book detail page
