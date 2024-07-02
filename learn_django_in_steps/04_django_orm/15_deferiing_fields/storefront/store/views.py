from django.shortcuts import render
from .models import Product


def index(request):
    products = Product.objects.only('id', 'title') 
    # products = Product.objects.defer('title')
    return render(request, 'store/index.html', context={'products': products})
