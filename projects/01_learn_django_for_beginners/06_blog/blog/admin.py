# blog/admin.py
from django.contrib import admin
from .models import Post

# admin.site.register(Post)
# blog/admin.py


class PostAdmin(admin.ModelAdmin):  # new
    list_display = (
        "title",
        "author",
        "body",
    )


admin.site.register(Post, PostAdmin)  # new
