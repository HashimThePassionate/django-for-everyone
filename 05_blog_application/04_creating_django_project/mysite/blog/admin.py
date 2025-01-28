from django.contrib import admin
from .models import Post

@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ['title', 'slug', 'author', 'publish', 'status']
    list_filter = ['status', 'created', 'publish', 'author']  # Add filters
    search_fields = ['title', 'body']  # Add search fields
    prepopulated_fields = {'slug': ('title',)}  # Prepopulate slugs
    raw_id_fields = ['author']  # Raw ID fields
    date_hierarchy = 'publish'  # Date hierarchy
    ordering = ['status', 'publish']  # Default ordering']
    show_facets = admin.ShowFacets.ALWAYS 