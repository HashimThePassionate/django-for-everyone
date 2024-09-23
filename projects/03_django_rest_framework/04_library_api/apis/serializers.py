# apis/serializers.py
from rest_framework import serializers
from books.models import Book


class BookSerializer(serializers.ModelSerializer):
    class Meta:
        model = Book  # 🏛️ Define the model to use
        fields = ("title", "subtitle", "author", "isbn")
