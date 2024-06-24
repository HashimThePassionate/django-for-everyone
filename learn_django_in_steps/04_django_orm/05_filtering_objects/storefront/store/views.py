from django.shortcuts import render
from .models import Product
# Import the ObjectDoesNotExist exception from the django.core.exceptions module
from django.core.exceptions import ObjectDoesNotExist


def index(request):
    products = Product.objects.filter(price=73.47)
    # products = Product.objects.filter(price__gt=20.00)
    # products = Product.objects.filter(price__gte=20.00, price__lte=30.00)
    # products = Product.objects.filter(collection_id=1)
    # products = Product.objects.filter(title__contains="coffee")
    return render(request, 'store/index.html', context={'product': products})
