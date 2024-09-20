# accounts/views.py
from django.urls import reverse_lazy
from django.views import generic
from .forms import CustomUserCreationForm
from allauth.account.views import LoginView, SignupView
from django.contrib.auth.models import Permission
from django.contrib.contenttypes.models import ContentType


class SignupPageView(generic.CreateView):
    form_class = CustomUserCreationForm
    success_url = reverse_lazy("login")
    template_name = "registration/signup.html"

class CustomLoginView(LoginView):
    def form_valid(self, form):
        response = super().form_valid(form)
        user = self.request.user
        self.assign_special_status_permission(user)  # Assign permission after login
        return response

    def assign_special_status_permission(self, user):
        # Assign 'books.special_status' permission to the user if not already assigned
        content_type = ContentType.objects.get(app_label='books', model='book')
        special_permission = Permission.objects.get(codename='special_status', content_type=content_type)

        if not user.has_perm('books.special_status'):
            user.user_permissions.add(special_permission)


class CustomSignupView(SignupView):
    def form_valid(self, form):
        response = super().form_valid(form)
        user = self.user
        self.assign_special_status_permission(user)  # Assign permission after signup
        return response

    def assign_special_status_permission(self, user):
        # Assign 'books.special_status' permission to the user if not already assigned
        content_type = ContentType.objects.get(app_label='books', model='book')
        special_permission = Permission.objects.get(codename='special_status', content_type=content_type)

        if not user.has_perm('books.special_status'):
            user.user_permissions.add(special_permission)
