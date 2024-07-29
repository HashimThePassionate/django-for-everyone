# blog/views.py
from django.shortcuts import render
from .models import Post


def post_list(request):
    posts = Post.objects.all()
    return render(request, 'home.html', {'posts': posts})
