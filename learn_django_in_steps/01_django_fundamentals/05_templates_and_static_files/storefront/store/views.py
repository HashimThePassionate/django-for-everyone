from django.shortcuts import render


def index(request):
    context = {
        'name': 'Django Learner',
        'items': ['Learn Django', 'Build Projects', 'Deploy Applications']
    }
    return render(request, 'store/index.html', context)
