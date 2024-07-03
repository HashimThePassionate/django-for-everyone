from django.shortcuts import render
from django.http import HttpResponse


def index(request):
    context = {
        'name': 'Django Learner',
        'items': ['Learn Django', 'Build Projects', 'Deploy Applications']
    }
    return render(request, 'store/index.html', context)


def dummy_calculation(request):
    x = 10
    y = 20
    result = x + y
    return HttpResponse(f"The result of the calculation is: {result}")
