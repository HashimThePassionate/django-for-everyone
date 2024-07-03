from django.shortcuts import render
from .models import Customer, Collection, Product, Order, OrderItem
from django.core.exceptions import ObjectDoesNotExist


def get_com_customers():
    try:
        return Customer.objects.filter(email__endswith='.com')
    except ObjectDoesNotExist:
        return Customer.objects.none()


def get_collections_without_featured_product():
    try:
        return Collection.objects.filter(featured_product__isnull=True)
    except ObjectDoesNotExist:
        return Collection.objects.none()


def get_low_inventory_products():
    try:
        return Product.objects.filter(inventory__lt=10)
    except ObjectDoesNotExist:
        return Product.objects.none()


def get_orders_by_customer(customer_id):
    try:
        return Order.objects.filter(customer_id=customer_id)
    except ObjectDoesNotExist:
        return Order.objects.none()


def get_order_items_for_collection(collection_id):
    try:
        return OrderItem.objects.filter(product__collection_id=collection_id)
    except ObjectDoesNotExist:
        return OrderItem.objects.none()


def index(request):
    context = {
        'com_customers': get_com_customers(),
        'collections_without_featured_product': get_collections_without_featured_product(),
        'low_inventory_products': get_low_inventory_products(),
        'customer_orders': get_orders_by_customer(1),
        'order_items_for_collection': get_order_items_for_collection(3),
    }
    return render(request, 'store/index.html', context)
