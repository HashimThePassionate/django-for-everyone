from django.shortcuts import render
from .models import Product, OrderItem, Order, Customer
from django.db.models import Avg, Max, Sum, Count, Min


def index(request):
    # How many units of product I have sold?
    result1 = OrderItem.objects.aggregate(total_units_sold=Sum('quantity'))
    # How many orders has Customer 1 placed?
    result2 = Order.objects.filter(
        customer_id=1).aggregate(total_orders=Count('id'))
    # What is the min, max and avg price of products in collectinn 3?
    result3 = Product.objects.filter(collection_id=3).aggregate(
        min_price=Min('price'), max_price=Max('price'), avg_price=Avg('price'))
    return render(request, 'store/index.html', context={'result1': result1, 'result2': result2, 'result3': result3})
