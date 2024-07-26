# pages/urls.py
from django.urls import path
from .views import home_page_view,about_page_view
urlpatterns = [
path("", home_page_view),
path("about/", about_page_view), # new
]
