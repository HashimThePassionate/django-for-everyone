from django.db import models
from django.utils import timezone

class Post(models.Model):
    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    body = models.TextField()
    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(auto_now_add=True)  # Field added
    updated = models.DateTimeField(auto_now=True)      # Another field added

    class Meta:  # new class meta
        ordering = ['-publish']  # add default ordering


    def __str__(self):
        return self.title