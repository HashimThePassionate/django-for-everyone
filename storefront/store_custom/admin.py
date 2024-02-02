from django.contrib import admin
from store.admin import ProductAdmin
from tags.models import Tagitem
from store.models import Product
from django.contrib.contenttypes.admin import GenericStackedInline

class TagInline(GenericStackedInline):
    model = Tagitem
    extra = 0
    autocomplete_fields = ['tag']

class CustomProductAdmin(ProductAdmin):
        inlines = [TagInline]
    
admin.site.unregister(Product)
admin.site.register(Product,CustomProductAdmin)

