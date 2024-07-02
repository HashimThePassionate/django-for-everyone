from django.shortcuts import render
from .models import Product


def index(request):
    products = Product.objects.values('id', 'title', 'collection__title') # QuerySet as dictionary
    products = Product.objects.values_list('id', 'title', 'collection__title') # QuerySet as tuple
    return render(request, 'store/index.html', context={'products': products})
