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

def post_detail(request, year, month, day, post):
    post = get_object_or_404(
        Post,
        status=Post.Status.PUBLISHED,
        slug=post,
        publish__year=year,
        publish__month=month,
        publish__day=day
    )
    return render(
        request,
        'blog/post/detail.html',
        {'post': post}
    )