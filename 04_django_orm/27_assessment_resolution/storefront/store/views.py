from django.shortcuts import render
from .models import Customer, Collection, Product
from django.db.models import Max, Count, Sum, F


def index(request):
    customer = Customer.objects.annotate(last_order_id=Max(
        'order__id')).values('id', 'first_name', 'last_order_id')
    collection = Collection.objects.annotate(product_count=Count(
        'product')).values('id', 'title', 'product_count')
    customer_more = Customer.objects.annotate(order_count=Count('order')).filter(
        order_count__gt=5).values('id', 'first_name', 'last_name', 'order_count')
    customer_spend = Customer.objects.annotate(total_spent=Sum(
        F('order__orderitem__quantity') * F('order__orderitem__price'))).values('id', 'first_name', 'total_spent')
    product = Product.objects.annotate(total_quantity=Sum('orderitem__quantity'), total_sales=Sum(
        F('orderitem__quantity') * F('orderitem__price'))).order_by('-total_quantity')[:5].values('id', 'title', 'total_quantity', 'total_sales')
    return render(request, 'store/index.html', context={'customer': customer, 'collection': collection, 'customer_more': customer_more, 'customer_spend': customer_spend, 'product': product})
