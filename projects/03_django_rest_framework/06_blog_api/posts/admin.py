# posts/admin.py
from django.contrib import admin
from .models import Post

admin.site.register(Post)
