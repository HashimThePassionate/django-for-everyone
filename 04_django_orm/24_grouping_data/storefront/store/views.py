from django.shortcuts import render
from .models import Customer
from django.db.models import Value, F, Func, Count
from django.db.models.functions import Concat


def index(request):
    customer = Customer.objects.annotate(order_counts=Count('order'))
    return render(request, 'store/index.html', context={'customer': customer})
