from django.shortcuts import render
from .models import Product
from django.db.models import F, ExpressionWrapper, DecimalField


def index(request):
    discounted_price = ExpressionWrapper(
        F('price') * 0.8, output_field=DecimalField())
    product = Product.objects.annotate(
        discounted_price=discounted_price)
    return render(request, 'store/index.html', context={'product': product})
