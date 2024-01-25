from django.shortcuts import render
from django.core.exceptions import ObjectDoesNotExist
from store.models import Product

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

    product = Product.objects.filter(title__contains='Wine')
    return render(request, 'index.html', {'product': product})
