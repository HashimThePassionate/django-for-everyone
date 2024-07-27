# posts/urls.py
from django.urls import path
from .views import PostList
urlpatterns = [
    path("", PostList.as_view(), name="home"),
]
