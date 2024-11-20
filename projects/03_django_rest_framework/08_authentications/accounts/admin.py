# accounts/admin.py
from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .forms import CustomUserCreationForm, CustomUserChangeForm
from .models import CustomUser

class CustomUserAdmin(UserAdmin):
    add_form = CustomUserCreationForm
    form = CustomUserChangeForm
    model = CustomUser
    list_display = ["email", "username", "name", "is_staff"]
    
    # Resetting fieldsets to avoid the usable_password error
    fieldsets = (
        (None, {"fields": ("username", "password", "name", "email")}),
        ("Permissions", {"fields": ("is_staff", "is_active")}),
    )
    add_fieldsets = (
        (None, {
            "classes": ("wide",),
            "fields": ("username", "name", "email", "password1", "password2"),
        }),
    )

admin.site.register(CustomUser, CustomUserAdmin)
