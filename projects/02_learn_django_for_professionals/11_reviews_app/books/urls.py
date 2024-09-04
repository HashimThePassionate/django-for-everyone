# books/urls.py
from django.urls import path
from .views import BookListView, BookDetailView, ReviewCreateView  # Import necessary views

urlpatterns = [
    path("", BookListView.as_view(), name="book_list"),  # URL for listing books
    path("<uuid:pk>/", BookDetailView.as_view(), name="book_detail"),  # URL for book details
    path("<uuid:pk>/review/", ReviewCreateView.as_view(), name="review_create"),  # URL for creating a review
]
