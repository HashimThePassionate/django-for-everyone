from django.shortcuts import render
from store.models import Product

# Create your views here.


def home(request):
    query_set = Product.objects.all() 
    #objects is manager that is a interface of database
    # for p in query_set:
    #     print(p)
    product = Product.objects.get(pk=5) 
    print(product)
    #get only specific record using where clause
    return render(request, 'index.html')
