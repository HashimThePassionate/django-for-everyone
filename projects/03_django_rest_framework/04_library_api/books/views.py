# books/views.py
from django.views.generic import ListView
from django.shortcuts import render
from books.models import Book

class BookListView(ListView):
    model = Book
    context_object_name = 'books'
    template_name = 'books/book_list.html'  # Full page template

    def render_to_response(self, context, **response_kwargs):
        # Check if the request is from HTMX (only return partial HTML)
        if self.request.headers.get('HX-Request'):
            return render(self.request, 'books/book_list_partial.html', context)  # Return partial template

        # For normal requests, render the full page template
        return super().render_to_response(context, **response_kwargs)
