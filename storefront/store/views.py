from django.shortcuts import render
# from django.core.exceptions import ObjectDoesNotExist
from store.models import Product
from django.db.models import Q, F
# Create your views here.


def home(request):
    query_set = Product.objects.all()
    # objects is manager that is a interface of database
    # for p in query_set:
    #     print(p)
    # product = Product.objects.get(pk=5)
    # print(product)
    # get only specific record using where clause
    # try:
    #     product = Product.objects.get(pk=0)
    # except ObjectDoesNotExist:
    #     pass

    # product = Product.objects.filter(pk=0).exists()
    # Filtering Data
    # find those dollars who have unit_price = 20
    # product = Product.objects.filter(price=20)
    # for p in product:
    #         print(p)

    # Filter using
    # keyword argument
    # query_set api
    # product = Product.objects.filter(price__gte=23.29)
    # for p in product:
    #     print(p)

    # product = Product.objects.filter(title__contains='Wine')
    # product = Product.objects.filter(inventory__lt=10,price__lt=20)
    # product = Product.objects.filter(inventory__lt=10).filter(price__lt=20)
    # Q object to make complex lookups
    # product = Product.objects.filter(Q(inventory__lt=10)& ~Q(price__lt=40))
    # We can compare related fields with F class Object
    # product = Product.objects.filter(inventory=price)
    # Sort in Ascending order
    product = Product.objects.order_by('price')
    return render(request, 'index.html', {'product': product})
