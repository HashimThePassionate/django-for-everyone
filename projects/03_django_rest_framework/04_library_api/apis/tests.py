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