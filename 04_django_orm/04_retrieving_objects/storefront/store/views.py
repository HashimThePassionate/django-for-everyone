from django.shortcuts import render
from .models import Product
# Import the ObjectDoesNotExist exception from the django.core.exceptions module
from django.core.exceptions import ObjectDoesNotExist


def index(request):
    product = Product.objects.all()  # Select all products from the database
    sp = Product.objects.get(pk=1)  # Select a specific product from
    try:
        # any object that does not exists will crash the server to solve this  we need import ObjectDoestNotExists and  use try and except block
        sp = Product.objects.get(pk=0)
    except ObjectDoesNotExist:
        sp = None
    return render(request, 'store/index.html', context={'product': product, 'sp': sp})
