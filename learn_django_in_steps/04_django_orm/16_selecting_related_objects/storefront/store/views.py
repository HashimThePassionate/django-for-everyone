from django.shortcuts import render
from .models import Product
def index(request):
    products = Product.objects.all()
    # products = Product.objects.select_related('collection').all()
    # products = Product.objects.select_related('collection').prefetch_related('promotions').all()
    return render(request, 'store/index.html', context={'products': products})