# todos/urls.py
from django.urls import path
from .views import ListTodo, DetailTodo, ListCreateTodo, RetrieveUpdateDestroyTodo

urlpatterns = [
    path("<int:pk>/", DetailTodo.as_view(), name="todo_detail"),
    path("", ListTodo.as_view(), name="todo_list"),
    path("create/", ListCreateTodo.as_view(), name="todo_list_create"),
    path("<int:pk>/delete/", RetrieveUpdateDestroyTodo.as_view(), name="todo_detail_update_delete"),
]
