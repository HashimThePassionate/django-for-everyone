# Many-to-Many Relationship

In this example, we are going to introduce a new class called `Promotion` and define a many-to-many relationship between `Promotion` and `Product`. This will allow a product to have multiple promotions and a promotion to apply to multiple products.

## Models

### Promotion Model

First, we define the `Promotion` model:

```python
from django.db import models

class Promotion(models.Model):
    description = models.CharField(max_length=255)
    discount = models.FloatField()
```

- `description`: A character field with a maximum length of 255 characters.
- `discount`: A float field to represent the discount amount.

### In Product Model

Next, we define the `promotions` in `Product` model and establish a many-to-many relationship

```python
class Product(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField()
    price = models.DecimalField(max_digits=7, decimal_places=2, db_default=50)
    inventory = models.IntegerField()
    last_update = models.DateTimeField(auto_now=True)
    collection = models.ForeignKey(Collection, on_delete=models.CASCADE
    promotions = models.ManyToManyField(Promotion)
```
## Explanation

The many-to-many relationship between `Product` and `Promotion` is established using `ManyToManyField` in the `Product` model.
