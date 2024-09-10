from django.urls import path
from .views import SignupPageView
from .views import CustomLoginView, CustomSignupView 

urlpatterns = [
    path("signup/", SignupPageView.as_view(), name="signup"),
    path('accounts/login/', CustomLoginView.as_view(), name='account_login'),
    path('accounts/signup/', CustomSignupView.as_view(), name='account_signup'),
]