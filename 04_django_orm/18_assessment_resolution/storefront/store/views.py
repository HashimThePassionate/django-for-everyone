from django.shortcuts import render
from .models import Order


def index(request):
    # orders = Order.objects.order_by('-placed_at')[:5] # Get the 5 most recent orders
    # orders = Order.objects.select_related('customer').order_by('-placed_at')[:5]
    # orders = Order.objects.select_related('customer').prefetch_related('orderitem_set').order_by('-placed_at')[:5]
    orders = Order.objects.select_related('customer').prefetch_related(
        'orderitem_set__product').order_by('-placed_at')[:5]
    return render(request, 'store/index.html', context={'orders': orders})
