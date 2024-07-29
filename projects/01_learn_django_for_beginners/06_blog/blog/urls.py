# blog/urls.py
from django.urls import path
from .views import post_list

urlpatterns = [
    path("", post_list, name="home"),
]
