from django.db import models
from django.utils import timezone
from django.conf import settings

class PublishedManager(models.Manager):
    def get_queryset(self):
        # Return only posts with PUBLISHED status
        return super().get_queryset().filter(status=Post.Status.PUBLISHED)

class Post(models.Model):
    class Status(models.TextChoices):
        DRAFT = 'DF', 'Draft'
        PUBLISHED = 'PB', 'Published'

    title = models.CharField(max_length=250)
    slug = models.SlugField(max_length=250)
    author = models.ForeignKey(
    settings.AUTH_USER_MODEL,
    on_delete=models.CASCADE,
    related_name='blog_posts'
    )
    body = models.TextField()
    publish = models.DateTimeField(default=timezone.now)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    status = models.CharField(
        max_length=2,
        choices=Status.choices,
        default=Status.DRAFT                         
    )

    # Managers
    objects = models.Manager()  # Default manager
    published = PublishedManager()  # Custom manager

    class Meta:
        ordering = ['-publish']
        indexes = [models.Index(fields=['-publish']),]

    def __str__(self):
        return self.title
