# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('campaigns', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='campaign',
            name='source',
            field=models.IntegerField(default=0, choices=[(0, b'kickstarter'), (1, b'gofundme'), (2, b'crowdrise'), (3, b'giveforward')]),
        ),
    ]
