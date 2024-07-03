# Database Schema Customization

### Product

The `Product` model represents a product with various attributes like title, slug, description, price, inventory, last update timestamp, collection, and promotions.

```python
from django.db import models

class Product(models.Model):
    title = models.CharField(max_length=255)
    slug = models.SlugField(db_default='-')
    description = models.TextField()
    price = models.DecimalField(max_digits=7, decimal_places=2, db_default=50)
    inventory = models.IntegerField()
    last_update = models.DateTimeField(auto_now=True)
    collection = models.ForeignKey(Collection, on_delete=models.CASCADE)
    promotions = models.ManyToManyField(Promotion)

    class Meta:
        db_table = 'product'
        indexes = [
            models.Index(fields=['slug'], name='slug_idx'),
        ]
```

### Customer

The `Customer` model represents a customer with personal details and membership information.

```python
from django.db import models

class Customer(models.Model):
    MEMBERSHIP_BRONZE = 'B'
    MEMBERSHIP_SILVER = 'S'
    MEMBERSHIP_GOLD = 'G'

    MEMBERSHIP_CHOICES = [
        (MEMBERSHIP_BRONZE, 'Bronze'),
        (MEMBERSHIP_SILVER, 'Silver'),
        (MEMBERSHIP_GOLD, 'Gold'),
    ]

    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    email = models.EmailField(max_length=255, unique=True)
    phone = models.CharField(max_length=20)
    birth_date = models.DateField(null=True)
    membership = models.CharField(
        max_length=1, choices=MEMBERSHIP_CHOICES, default=MEMBERSHIP_BRONZE
    )

    class Meta:
        ordering = ['last_name', 'first_name']
        verbose_name = 'customer'
        verbose_name_plural = 'customers'
```

### Address

The `Address` model stores address details for customers.

```python
from django.db import models

class Address(models.Model):
    street = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)

    class Meta:
        unique_together = ['customer', 'street', 'city']
        index_together = ['city', 'street']
```

### Order

The `Order` model represents a customer's order with payment status and timestamp.

```python
from django.db import models

class Order(models.Model):
    PAYMENT_STATUS_PENDING = 'P'
    PAYMENT_STATUS_COMPLETE = 'C'
    PAYMENT_STATUS_FAILED = 'F'

    PAYMENT_STATUS_CHOICES = [
        (PAYMENT_STATUS_PENDING, 'Pending'),
        (PAYMENT_STATUS_COMPLETE, 'Complete'),
        (PAYMENT_STATUS_FAILED, 'Failed'),
    ]

    placed_at = models.DateTimeField(auto_now_add=True)
    payment_status = models.CharField(
        max_length=1, choices=PAYMENT_STATUS_CHOICES, default=PAYMENT_STATUS_PENDING
    )
    customer = models.ForeignKey(Customer, on_delete=models.PROTECT)

    class Meta:
        permissions = [
            ("can_cancel_order", "Can cancel order"),
        ]
```

### OrderItem

The `OrderItem` model represents items in an order, including the product, quantity, and unit price.

```python
from django.db import models

class OrderItem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.PROTECT)
    product = models.ForeignKey(Product, on_delete=models.PROTECT)
    quantity = models.PositiveSmallIntegerField()
    unit_price = models.DecimalField(max_digits=7, decimal_places=2)

    class Meta:
        db_table = 'order_item_table'
        verbose_name = 'order item'
        verbose_name_plural = 'order items'
```
### CartItem

The `CartItem` model represents items in a shopping cart, including the product and quantity.

```python
from django.db import models

class CartItem(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveSmallIntegerField()

    class Meta:
        unique_together = ['cart', 'product']
        index_together = ['cart', 'product']
```

## Customizing the Schema with Model Meta Options

### db_table

The `db_table` option allows you to specify a custom table name for the model.

```python
class Product(models.Model):
    # fields

    class Meta:
        db_table = 'product'
```

### indexes

The `indexes` option allows you to define database indexes to improve query performance.

```python
class Product(models.Model):
    # fields

    class Meta:
        indexes = [
            models.Index(fields=['slug'], name='slug_idx'),
        ]
```

### unique_together

The `unique_together` option enforces unique constraints on a combination of fields. It ensures that the combination of the specified fields is unique across the table.

```python
class Address(models.Model):
    # fields

    class Meta:
        unique_together = ['customer', 'street', 'city']
```
### Database Table Structure

Imagine your `Address` table looks like this:

| ID  | Customer ID | Street         | City         |
|-----|-------------|----------------|--------------|
| 1   | 1           | 123 Main St    | Springfield  |
| 2   | 1           | 456 Elm St     | Springfield  |
| 3   | 2           | 123 Main St    | Springfield  |

### unique_together = ['customer', 'street', 'city']

The `unique_together` constraint ensures that the combination of `Customer ID`, `Street`, and `City` must be unique across the table.

#### Valid Scenario

Let's say you want to add a new address for Customer 1 at "789 Oak St, Springfield":

| ID  | Customer ID | Street         | City         |
|-----|-------------|----------------|--------------|
| 1   | 1           | 123 Main St    | Springfield  |
| 2   | 1           | 456 Elm St     | Springfield  |
| 3   | 2           | 123 Main St    | Springfield  |
| 4   | 1           | 789 Oak St     | Springfield  |

This is valid because the combination (1, "789 Oak St", "Springfield") is unique.

#### Invalid Scenario

Now, let's say you attempt to add another address for Customer 1 at "123 Main St, Springfield":

| ID  | Customer ID | Street         | City         |
|-----|-------------|----------------|--------------|
| 1   | 1           | 123 Main St    | Springfield  |
| 2   | 1           | 456 Elm St     | Springfield  |
| 3   | 2           | 123 Main St    | Springfield  |
| 4   | 1           | 123 Main St    | Springfield  |

This is invalid because the combination (1, "123 Main St", "Springfield") already exists in the table.

### index_together

The `index_together` option creates a composite index on a combination of fields to optimize database queries involving these fields.

```python
class Address(models.Model):
    # fields

    class Meta:
        index_together = ['city', 'street']
```

### ordering

The `ordering` option specifies the default ordering for querysets. This ensures that the records are always returned in the specified order unless overridden in the query.

```python
class Customer(models.Model):
    # fields

    class Meta:
        ordering = ['last_name', 'first_name']
```

### verbose_name and verbose_name_plural

The `verbose_name` and `verbose_name_plural` options specify the human-readable names for the model. These names are used in the admin interface and other parts of Django where a readable name is required.

```python
class Customer(models.Model):
    # fields

    class Meta:
        verbose_name = 'customer'
        verbose_name_plural = 'customers'
```

### permissions

The `permissions` option defines custom permissions for the model. These permissions can be used to control access to different parts of the application.

```python
class Order(models.Model):
    # fields

    class Meta:
        permissions = [
            ("can_cancel_order", "Can cancel order"),
        ]
```

## Conclusion

By using these Model Meta options, you can customize the database schema to fit your specific requirements. This flexibility allows you to optimize your database design, improve query performance, and enforce data integrity constraints.

---

This detailed README file should provide clear and structured guidance on customizing your Django models using Model Meta options, with explanations for each option.