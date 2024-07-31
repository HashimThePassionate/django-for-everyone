# blog/views.py
from django.views.generic import ListView, DetailView
from .models import Post
from django.views.generic.edit import CreateView  # new


class BlogListView(ListView):
    model = Post
    template_name = "home.html"
    # context_object_name = 'posts'


class BlogDetailView(DetailView):
    model = Post
    template_name = "post_detail.html"


class BlogCreateView(CreateView):  # new
    model = Post
    template_name = "post_new.html"
    fields = ["title", "author", "body"]
