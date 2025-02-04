from django.core.paginator import Paginator, EmptyPage, PageNotAnInteger
from django.shortcuts import render, get_object_or_404
from .models import Post
from django.http import Http404
from django.views.generic import ListView

def post_list(request):
    post_list = Post.published.all()
    paginator = Paginator(post_list, 3)
    page_number = request.GET.get('page', 1)
    try:
        posts = paginator.page(page_number)  # Fetch requested page
    except PageNotAnInteger:  # Handle non-integer page numbers
        # If page_number is not an integer, return the first page
        posts = paginator.page(1)
    except EmptyPage:
        # If requested page is out of range, return the last page
        posts = paginator.page(paginator.num_pages)
    
    return render(
        request,
        'blog/post/list.html',
        {'posts': posts}
    )

class PostListView(ListView):
    """
    Alternative post list view
    """
    queryset = Post.published.all()  
    context_object_name = 'posts'  
    paginate_by = 3 
    template_name = 'blog/post/list.html' 

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
