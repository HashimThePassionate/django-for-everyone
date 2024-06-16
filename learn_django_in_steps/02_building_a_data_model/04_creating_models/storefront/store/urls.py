from django.urls import path
from .views import index, dummy_calculation

urlpatterns = [
    path('', index, name='index'),
    path('dummy/', dummy_calculation, name='dummy_calculation'),
]
