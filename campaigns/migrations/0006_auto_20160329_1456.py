# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-03-29 14:56
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('campaigns', '0005_auto_20160329_1232'),
    ]

    operations = [
        migrations.AlterField(
            model_name='campaign',
            name='deadline',
            field=models.DateField(db_index=True, null=True),
        ),
        migrations.AlterField(
            model_name='campaign',
            name='description',
            field=models.TextField(null=True),
        ),
        migrations.AlterField(
            model_name='campaign',
            name='location',
            field=models.CharField(max_length=200, null=True),
        ),
        migrations.AlterField(
            model_name='campaign',
            name='recipient',
            field=models.CharField(max_length=200, null=True),
        ),
    ]
