# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Campaign',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=100, db_index=True)),
                ('deadline', models.DateField(db_index=True)),
                ('goal', models.IntegerField(db_index=True)),
                ('raised', models.IntegerField(db_index=True)),
                ('url', models.CharField(max_length=100)),
                ('description', models.CharField(max_length=200)),
                ('last_updated', models.DateField()),
                ('recipient', models.CharField(max_length=200)),
                ('creator', models.CharField(max_length=200)),
                ('location', models.CharField(max_length=200)),
            ],
        ),
        migrations.CreateModel(
            name='Category',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('category', models.CharField(max_length=100)),
            ],
        ),
        migrations.AddField(
            model_name='campaign',
            name='category',
            field=models.ForeignKey(to='campaigns.Category'),
        ),
    ]
