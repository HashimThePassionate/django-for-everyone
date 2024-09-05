from django.test import TestCase
from django.urls import reverse
from .models import Book, Review
from django.contrib.auth import get_user_model

class BookTests(TestCase):
    @classmethod
    def setUpTestData(cls):
        cls.user = get_user_model().objects.create_user(
            username="reviewuser",
            email="reviewuser@email.com",
            password="testpass123",
        )
        cls.book = Book.objects.create(
            title="Python Deep Dive",
            author="Muhammad Hashim",
            price="69.00",
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
        # Provide an empty string for 'cover' instead of None
        response = self.client.post(
            reverse("book_create"),
            {
                "title": "Django Unleashed",
                "author": "Andrew Pinkham",
                "price": "59.00",
                # Set cover to an empty string to simulate no file being uploaded
                "cover": "",
            },
        )
        self.assertEqual(response.status_code, 302)  # Should redirect after successful post
        self.assertEqual(Book.objects.count(), 2) 

    # ✏️ Test case to update a book
    def test_update_book(self):
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

    # ❌ Test case to delete a book
    def test_delete_book(self):
        response = self.client.post(reverse("book_delete", kwargs={"pk": self.book.pk}))
        self.assertEqual(response.status_code, 302)
        self.assertEqual(Book.objects.count(), 0)