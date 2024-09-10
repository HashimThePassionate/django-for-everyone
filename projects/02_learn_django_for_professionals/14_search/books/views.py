# books/views.py

from django.views.generic import ListView, DetailView, CreateView, UpdateView, DeleteView
from django.urls import reverse_lazy
from django.shortcuts import get_object_or_404
from django.contrib.auth.mixins import UserPassesTestMixin, LoginRequiredMixin, PermissionRequiredMixin  # new
from .models import Book, Review
from .forms import ReviewForm, BookForm
from django.db.models import Q  # new
# 📚 List View for displaying all books


class BookListView(LoginRequiredMixin, ListView):
    model = Book
    context_object_name = "book_list"
    template_name = "books/book_list.html"
    login_url = 'account_login'  # new

# 📖 Detail View for displaying a specific book's details and reviews


class BookDetailView(LoginRequiredMixin, PermissionRequiredMixin, DetailView):
    model = Book
    context_object_name = "book"
    template_name = "books/book_detail.html"
    login_url = 'account_login'  # new
    permission_required = "books.special_status"  # 🔑 New

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        # Add an empty review form to the context
        context['form'] = ReviewForm()
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


class SearchResultsListView(ListView):  # new
    model = Book
    context_object_name = "book_list"
    template_name = "books/search_results.html"

    def get_queryset(self):  # new
        query = self.request.GET.get("q")
        return Book.objects.filter(
            Q(title__icontains=query) | Q(author__icontains=query)
        )
