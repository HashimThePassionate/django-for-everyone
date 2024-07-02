from django.shortcuts import render
from .models import Product, OrderItem


def index(request):
    # orders = OrderItem.objects.values('id', 'product_id', 'price')
    orders = OrderItem.objects.values('product_id').distinct()
    products = Product.objects.filter(id__in=orders)
    return render(request, 'store/index.html', context={'products': products})
