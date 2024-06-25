from django.shortcuts import render
from .models import Product
from django.db.models import Q


def index(request):
    product = Product.objects.filter(inventory__lt=10, price__lt=20)
    # product = Product.objects.filter(inventory__lt=10).filter(price__lt=20)
    # product = Product.objects.filter(Q(inventory__lt=10) | Q(price__lt=20))
    # product = Product.objects.filter(Q(inventory__lt=10) | ~Q(price__lt=20))
    # product = Product.objects.filter(Q(inventory__lt=10) & (Q(price__lt=20) | Q(price__gt=50)))
    return render(request, 'store/index.html', {'product': product})
