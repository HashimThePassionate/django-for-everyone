from rest_framework.generics import ListAPIView
from books.models import Book
from .serializers import BookSerializer


class BookAPIView(ListAPIView):
    queryset = Book.objects.all()  # 📚 Fetch all books
    serializer_class = BookSerializer
