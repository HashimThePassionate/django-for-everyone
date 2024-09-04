# books/views.py
from django.views.generic import ListView, DetailView, CreateView
from django.urls import reverse_lazy  # Used to generate URL after form submission
from django.shortcuts import get_object_or_404  # Used to safely retrieve book objects
from .models import Book, Review  # Import Book and Review models
from .forms import ReviewForm  # Import the form created for reviews

# 📚 List View for displaying all books
class BookListView(ListView):
    model = Book
    context_object_name = "book_list"  # Context variable name for template
    template_name = "books/book_list.html"  # Template to render

# 📖 Detail View for displaying a specific book's details and reviews
class BookDetailView(DetailView):
    model = Book
    context_object_name = "book"  # Context variable name for template
    template_name = "books/book_detail.html"  # Template to render

    def get_context_data(self, **kwargs):
        # 🧠 Adding form to the context to render it on the template
        context = super().get_context_data(**kwargs)  # Retrieve the existing context data
        context['form'] = ReviewForm()  # Add an empty review form to the context
        return context

# 🖊️ Create View for handling the creation of a new review
class ReviewCreateView(CreateView):
    model = Review  # Model associated with this view
    form_class = ReviewForm  # Form class to use for creating reviews
    template_name = 'books/book_detail.html'  # Template to render form errors (same as book detail)

    def form_valid(self, form):
        # 🛠️ Set additional fields not provided by the user in the form
        form.instance.author = self.request.user  # Automatically set the author to the logged-in user
        form.instance.book = get_object_or_404(Book, pk=self.kwargs['pk'])  # Link the review to the correct book using the book's primary key (pk)
        return super().form_valid(form)  # Call the parent class's form_valid method to save the form

    def get_success_url(self):
        # 🔄 Redirect back to the book detail page after successfully creating a review
        return reverse_lazy('book_detail', kwargs={'pk': self.kwargs['pk']})  # Use reverse_lazy to avoid URL reversing issues
