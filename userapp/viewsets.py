from __future__ import unicode_literals
from rest_framework import viewsets
from .models import *
from django.shortcuts import render
from  . import serializers

# Create your views here.

class studentViewSet(viewsets.ModelViewSet):
    queryset = student.objects.all()
    serializer_class = serializers.studentSerializer