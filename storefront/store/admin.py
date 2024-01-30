from django.contrib import admin
from store.models import Collection, Product,Customer

@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ['title','description','price','inventory','inventory_status','collection']
    list_editable = ['price']
    list_per_page = 10
    @admin.display(ordering='inventory')
    def inventory_status(self,Product):
        if Product.inventory < 3:
            return 'Low'
        else:
            return 'High'

@admin.register(Customer)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ['first_name','last_name','email','phone','membership','points']
    list_editable = ['membership']
    ordering = ['first_name','last_name']
    list_per_page = 10

admin.site.register(Collection)
# admin.site.register(Product)
