from typing import Any
from django.contrib import admin
from django.db.models.query import QuerySet
from django.http.request import HttpRequest
from store.models import Collection, Product, Customer, Order
from django.db.models import Count


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ['title', 'description', 'price',
                    'inventory', 'inventory_status', 'collection']
    list_editable = ['price']
    list_per_page = 10
    list_select_related = ['collection']

    @admin.display(ordering='inventory')
    def inventory_status(self, Product):
        if Product.inventory < 3:
            return 'Low'
        else:
            return 'High'


@admin.register(Customer)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ['first_name', 'last_name',
                    'email', 'phone', 'membership', 'points']
    list_editable = ['membership']
    ordering = ['first_name', 'last_name']
    list_per_page = 10


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ['id', 'place_at', 'customer',
                    'payment_status', 'customer_email']
    # list_editable=['payment_status']
    list_per_page = 10

    def customer_email(self, Order):
        return Order.customer.email

# admin.site.register(Collection)
# admin.site.register(Product)


@admin.register(Collection)
class CollectionAdmin(admin.ModelAdmin):
    list_display = ['id', 'title', 'products_count']

    @admin.display(ordering='products_count')
    def products_count(self, Collection):
        return Collection.products_count

    def get_queryset(self, request: HttpRequest) -> QuerySet[Any]:
        return super().get_queryset(request).annotate(
            products_count=Count('product')
        )
