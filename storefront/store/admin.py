from typing import Any
from django.contrib import admin
from django.db.models.query import QuerySet
from django.http.request import HttpRequest
from store.models import Collection, Product, Customer, Order
from django.db.models import Count
from django.utils.html import format_html, urlencode
from django.urls import reverse


class InventoryFilter(admin.SimpleListFilter):
    title = 'Inventory'
    parameter_name = 'inventory'

    def lookups(self, request: Any, model_admin: Any) -> list[tuple[Any, str]]:
        return [
            ('<10', 'Low'),
            ('>=10', 'High')
        ]

    def queryset(self, request: Any, queryset: QuerySet[Any]) -> QuerySet[Any] | None:
        if self.value() == '<10':
            return queryset.filter(inventory__lt=10)
        elif self.value() == '>=10':
            return queryset.filter(inventory__gte=10)
        else:
            return None


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    # fields = ['title','description']
    exclude = ['promotions']
    actions = ['clear_inventory']
    list_display = ['id', 'title', 'price',
                    'inventory', 'inventory_status', 'collection']
    list_per_page = 10
    list_editable = ['price']
    list_select_related = ['collection']
    list_filter = ['collection', 'last_update', InventoryFilter]
    # def collection_title(self,Product):
    #     return Product.collection.title

    @admin.display(ordering='inventory')
    def inventory_status(self, Product):
        if Product.inventory < 3:
            return 'Low'
        else:
            return 'OK'

    @admin.action(description='Update Inventory to low')
    def clear_inventory(self, request, queryset):
        updated_count = queryset.update(inventory=0)
        self.message_user(
            request,
            f'{updated_count} products were updated successfully'
        )


@admin.register(Customer)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ['first_name', 'last_name', 'membership', 'orders']
    list_editable = ['membership']
    list_per_page = 10
    ordering = ['first_name', 'last_name']
    search_fields = ['first_name__istartswith', 'last_name__istartswith']

    def orders(self, Order):
        return str(Order.order_set.count())+' ORDERS'


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
        url = (
            reverse('admin:store_product_changelist')
            + '?'
            + urlencode({
                'collection__id': str(Collection.id)
            })

        )
        return format_html('<a href="{}">{}</a>', url,
                           Collection.products_count)
        # return Collection.products_count

    def get_queryset(self, request: HttpRequest) -> QuerySet[Any]:
        return super().get_queryset(request).annotate(
            products_count=Count('product')
        )
