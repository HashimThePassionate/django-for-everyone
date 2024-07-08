from django.shortcuts import render
from .models import Customer
from django.db.models import Value, F, Func
from django.db.models.functions import Concat


def index(request):
    customer = Customer.objects.annotate(full_name=Func(
        F('first_name'), Value(' '), F('last_name'), function='CONCAT'))
    # customer = Customer.objects.annotate(
    #     full_name=Concat('first_name', Value(' '), 'last_name'))
    return render(request, 'store/index.html', context={'customer': customer})
