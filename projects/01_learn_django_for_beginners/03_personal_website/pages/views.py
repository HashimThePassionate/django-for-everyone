from django.shortcuts import render
from django.http import HttpResponse
# Create your views here.


def home_page_view(request):
    return HttpResponse("Homepage")


def about_page_view(request):  # new
    # context = {"name": "Hashim"}  # new
    context = {"name": "Hashim", "age": 24}  # new
    return render(request, "pages/about.html", context)
