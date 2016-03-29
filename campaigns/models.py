from django.db import models

# Create your models here.

class Category(models.Model):
    category = models.CharField(max_length=100)

class Campaign(models.Model):
    SOURCESCHOICE = (
        (0, 'kickstarter'),
        (1, 'gofundme'),
        (2, 'crowdrise'),
        (3, 'giveforward'),
    )

    name = models.CharField(db_index=True, max_length=200)
    deadline = models.DateField(db_index=True)
    goal = models.IntegerField(db_index=True)
    raised = models.IntegerField(db_index=True)
    url = models.CharField(max_length=200)
    description = models.TextField()
    last_updated = models.DateField()
    recipient = models.CharField(max_length=200)
    creator = models.CharField(max_length=200)
    location = models.CharField(max_length=200)
    category = models.ForeignKey(Category)
    source = models.IntegerField(choices=SOURCESCHOICE, default=0)
