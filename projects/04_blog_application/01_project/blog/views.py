# from django.http import Http404
from django.shortcuts import render,  get_object_or_404
from .models import Post

def post_list(request):
    posts = Post.published.all()  # Retrieve all posts with status=PUBLISHED
    return render(
        request, 
        'blog/post/list.html',  # Specify the template
        {'posts': posts}  # Pass the posts as context
    )


# def post_detail(request, id):
#     try:
#         post = Post.published.get(id=id)
#     except Post.DoesNotExist:
#         raise Http404("No Post found.")
#     return render(
#     request,
#     'blog/post/detail.html',
#     {'post': post}
#     )

def post_detail(request, id):
    post = get_object_or_404(
        Post,
        id=id,
        status=Post.Status.PUBLISHED  # Ensure the post is published
    )
    return render(
        request, 
        'blog/post/detail.html', 
        {'post': post}
    )