from django.db import models

# Create your models here.
class Product(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField()
    price = models.DecimalField(max_digits=6, decimal_places=2)
    inventory = models.IntegerField()
    last_update = models.DateTimeField(auto_now=True)

class Customer(models.Model):
    MEMBERSHIP_SILVER = 'S'
    MEMBERSHIP_GOLD = 'G'
    MEMBERSHIP_DIAMOND = 'D' 

    MEMBERSHIP_CHOICES = [
        (MEMBERSHIP_SILVER,'SILVER'),
        (MEMBERSHIP_GOLD,'GOLD'),
        (MEMBERSHIP_DIAMOND,'DIAMOND'),
    ]
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    email = models.EmailField(max_length=254,unique=True)
    phone = models.CharField(max_length=255)
    birth_date = models.DateField(null=True)
    membership = models.CharField(max_length=1, choices=MEMBERSHIP_CHOICES, default=MEMBERSHIP_SILVER)

class Order(models.Model):
    PAYMENT_PENDING = 'P'
    PAYMENT_COMPLETE = 'C'
    PAYMENT_FAILED = 'F'
    PAYMENT_CHOICES = [
        (PAYMENT_PENDING,'PENDING'),
        (PAYMENT_COMPLETE,'COMPLETE'),
        (PAYMENT_FAILED,'FAILED'),
    ]
    place_at = models.DateField(auto_now_add=True)
    payment_status = models.CharField(max_length=1,choices=PAYMENT_CHOICES,default=PAYMENT_PENDING)

class Address(models.Model):
    street = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    customer = models.OneToOneField(Customer,on_delete=models.CASCADE,primary_key = True)

