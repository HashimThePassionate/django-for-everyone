from django.shortcuts import render
from django.views.generic import TemplateView  # new
import logging
logger = logging.getLogger(__name__)
# Create your views here.


def home_page_view(request):  # new
    context = {  # new
        "inventory_list": ["Widget 1", "Widget 2", "Widget 3"],
        "greeting": "THAnk you FOR visitING.",
    }
    return render(request, "home.html", context)


class AboutPageView(TemplateView):  # new
    template_name = "about.html"

    def get_context_data(self, **kwargs):  # new
        context = super().get_context_data(**kwargs)
        context["address"] = "Azad Chaiwla Institute 5th Road, Rawalpindi"
        context["phone_number"] = "555-555-5555"
        logger.debug("Context: %s", context)
        return context
     # Log the context to the terminal
