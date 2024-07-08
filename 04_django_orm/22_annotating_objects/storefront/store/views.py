from django.shortcuts import render
from .models import Customer
from django.db.models import Value, F


def index(request):
    customer = Customer.objects.annotate(is_new=Value(True))
    # customer = Customer.objects.annotate(
    #     is_new=Value(True), new_id=F('id') + 1)
    return render(request, 'store/index.html', context={'customer': customer})
