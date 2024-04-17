from django.contrib import admin
from store.admin import ProductAdmin
from tags.models import Tagitem
from store.models import Product
from django.contrib.contenttypes.admin import GenericStackedInline
from django.contrib.auth.admin import UserAdmin as UserBaseAdmin
from core.models import User


@admin.register(User)
class UserAdmin(UserBaseAdmin):
    add_fieldsets = (
        (
            None,
            {
                "classes": ("wide",),
                "fields": ("username", "password1", "password2", 'email', 'first_name', 'last_name'),
            },
        ),
    )


class TagInline(GenericStackedInline):
    model = Tagitem
    extra = 0
    autocomplete_fields = ['tag']


class CustomProductAdmin(ProductAdmin):
    inlines = [TagInline]


admin.site.unregister(Product)
admin.site.register(Product, CustomProductAdmin)
