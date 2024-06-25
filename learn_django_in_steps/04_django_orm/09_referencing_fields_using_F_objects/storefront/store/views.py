from django.shortcuts import render
from .models import Product
from django.db.models import Q, F


def index(request):
    product = Product.objects.filter(inventory=F('collection__id'))
    products = Product.objects.filter(inventory=F('collection__id'))
    return render(request, 'store/index.html', {'product': product})
