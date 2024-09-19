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
