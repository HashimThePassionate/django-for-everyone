# adapters.py
from allauth.account.adapter import DefaultAccountAdapter
from django.urls import reverse


class NoRedirectLoginAdapter(DefaultAccountAdapter):
    def get_login_redirect_url(self, request):
        return reverse('account_login')
