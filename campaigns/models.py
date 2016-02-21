from django.db import models

# Create your models here.

class Category(models.Model):
    category = models.CharField(max_length=100)

class Campaign(models.Model):
    # artist = models.ForeignKey(Musician, on_delete=models.CASCADE)
    name = models.CharField(db_index=True, max_length=100)
    deadline = models.DateField(db_index=True)
    goal = models.IntegerField(db_index=True)
    raised = models.IntegerField(db_index=True)
    url = models.CharField(max_length=100)
    description = models.CharField(max_length=200)
    last_updated = models.DateField()
    recipient = models.CharField(max_length=200)
    creator = models.CharField(max_length=200)
    location = models.CharField(max_length=200)
    category = models.ForeignKey(Category)
