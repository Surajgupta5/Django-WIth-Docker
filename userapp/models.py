# -*- coding: utf-8 -*-
# from __future__ import unicode_literals

from django.db import models

# Create your models here.


class student(models.Model):
    firstname = models.CharField(max_length=10)
    lastname = models.CharField(max_length=10)
    mobno = models.CharField(max_length=10)

    class Meta:
        db_table = 'db_student'
        verbose_name = "Student"
        verbose_name_plural = "Student"

    def __str__(self):
        return str(self.firstname)
