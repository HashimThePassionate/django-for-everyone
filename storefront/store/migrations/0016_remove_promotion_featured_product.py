# Generated by Django 5.0.3 on 2024-04-16 00:47

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('store', '0015_alter_caritem_cart_alter_cart_id_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='promotion',
            name='featured_product',
        ),
    ]
