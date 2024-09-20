"""
URL configuration for django_project project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.conf import settings  # 🆕 Import settings
from django.conf.urls.static import static  # 🆕 Import static
from django.contrib import admin
from django.urls import path, include  # new

urlpatterns = [
    path("myadmin/", admin.site.urls),
    path("accounts/", include("allauth.urls")),  # new
    path("", include("pages.urls")),  # new
    path("books/", include("books.urls")),  # new
    path('accounts/', include('accounts.urls')), 
]+static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)  # 🆕 New addition

if settings.DEBUG:
    import debug_toolbar
    urlpatterns = [
        path("__debug__/", include(debug_toolbar.urls)),
    ] + urlpatterns