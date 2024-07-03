from django.shortcuts import render
from .models import Product


def index(request):
    product = Product.objects.order_by('title')
    # product = Product.objects.order_by('price', '-title')
    # product = Product.objects.order_by('price').reverse()
    # product = Product.objects.filter(collection_id=6).order_by('price')
    # p = Product.objects.earliest('price')
    return render(request, 'store/index.html', {'product': product})
    # return render(request, 'store/index.html', {'p': p})
