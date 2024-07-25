from django.shortcuts import render
from django.http import HttpResponse
# pages/views.py

def home_page_view(request):
    return HttpResponse("Hello, World!")

