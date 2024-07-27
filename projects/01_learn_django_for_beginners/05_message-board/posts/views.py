# posts/views.py
# from django.shortcuts import render
from .models import Post
from django.views.generic import ListView  # new


# def post_list(request):
#     posts = Post.objects.all()
#     return render(request, "post_list.html", {"posts": posts})


class PostList(ListView):  # new
    model = Post
    template_name = "post_list.html"
