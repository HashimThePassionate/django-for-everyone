from django.contrib import admin
from .models import Profile  # import Profile 

@admin.register(Profile)  # register and create ModelAdmin 
class ProfileAdmin(admin.ModelAdmin):
    list_display = ['user', 'date_of_birth', 'photo']
    raw_id_fields = ['user']