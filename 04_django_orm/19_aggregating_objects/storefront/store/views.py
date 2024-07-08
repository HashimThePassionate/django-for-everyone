from django.shortcuts import render
from .models import Product
from django.db.models import Avg, Max, Sum, Count, Min


def index(request):
    result = Product.objects.aggregate(avg_price=Avg('price'), max_price=Max(
        'price'), min_price=Min('price'), total_records=Count('id'), total_price=Sum('price'))
    # result = Product.objects.filter(collection__id=6).aggregate(avg_price=Avg('price'), max_price=Max(
    #     'price'), min_price=Min('price'), total_records=Count('id'), total_price=Sum('price'))
    return render(request, 'store/index.html', context={'result': result})
