from django.shortcuts import render
from store.models import Product

# Create your views here.


def home(request):
    query_set = Product.objects.all()
    for p in query_set:
        print(p)
    return render(request, 'index.html')
