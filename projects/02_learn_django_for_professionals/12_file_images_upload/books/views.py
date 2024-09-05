# books/views.py

from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from django.urls import reverse_lazy
from django.shortcuts import get_object_or_404
from django.contrib.auth.mixins import UserPassesTestMixin, LoginRequiredMixin
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
        context = super().get_context_data(**kwargs)
        context['form'] = ReviewForm()  # Add an empty review form to the context
        return context

# 🖊️ Create View for handling the creation of a new book
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
