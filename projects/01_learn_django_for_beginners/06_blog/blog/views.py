# blog/views.py
from django.shortcuts import render, get_object_or_404  # new,
from django.http import Http404
from .models import Post


def post_list(request):
    posts = Post.objects.all()
    return render(request, 'home.html', {'posts': posts})


def post_detail(request, pk):
    try:
        post = get_object_or_404(Post, pk=pk)
    except Http404:
        return render(request, "post_not_found.html", {"message": f"No post available with the primary key {pk}"})

    return render(request, "post_detail.html", {"post": post})
