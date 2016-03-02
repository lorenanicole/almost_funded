from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.

COLORS = ['orange', 'purple', 'green', 'blue', 'red']

def index(request):
  return render(request, 'jinja2/main.html',
                context={'platforms': ['CrowdRise', 'GiveForward', 'GoFundMe', 'Kickstarter'],
                         'title': 'Almost Funded',
                         'colors': COLORS},
                status=200, using='jinja2')