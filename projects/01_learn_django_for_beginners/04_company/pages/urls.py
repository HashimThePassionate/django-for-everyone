# pages/urls.py
from django.urls import path
from .views import home_page_view, AboutPageView
# urlpatterns = [
#     path("", home_page_view),
#     path("about/", AboutPageView.as_view()),  # new
# ]
urlpatterns = [
    path("about/", AboutPageView.as_view(), name="about"),  # new
    path("", home_page_view, name="home"),  # new
]
