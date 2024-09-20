# fileuploadapp/urls.py

from django.urls import path
from .views import DocumentCreateView, DocumentListView, DocumentDeleteView

urlpatterns = [
    path('', DocumentCreateView.as_view(), name='upload_file'),  # Default homepage for uploading files
    path('documents/', DocumentListView.as_view(), name='document_list'),  # URL to list uploaded documents
    path('documents/delete/<int:pk>/', DocumentDeleteView.as_view(), name='document_delete'),  # URL to delete a document
]
