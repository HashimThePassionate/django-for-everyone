# posts/urls.py
from django.urls import path
from .views import PostList, PostDetail

urlpatterns = [
    path("<int:pk>/", PostDetail.as_view(), name="post_detail"),  # View a single post by its ID
    path("", PostList.as_view(), name="post_list"),  # View all posts
]
