from wsgiref.util import request_uri
from django.shortcuts import render

def index(request):
    return render(request, 'core/index.html')