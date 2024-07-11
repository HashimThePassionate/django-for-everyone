from django.shortcuts import render

# Create your views here.
# pages/views.py
from django.http import HttpResponse


def homePageView(request):
    return HttpResponse("Hello, World!")
