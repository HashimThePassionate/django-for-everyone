from django.shortcuts import render
from .models import Product
from django.core.paginator import Paginator
# def index(request):
# product = Product.objects.all()[:5]
# product = Product.objects.all()[5:10]
# return render(request, 'store/index.html', {'product': product})


def index(request):
    page_number = request.GET.get('page', 1)
    page_size = 5
    products = Product.objects.all()
    paginator = Paginator(products, page_size)
    page_obj = paginator.get_page(page_number)

    context = {
        'products': page_obj.object_list,
        'page_obj': page_obj,
    }
    return render(request, 'store/index.html', context)
