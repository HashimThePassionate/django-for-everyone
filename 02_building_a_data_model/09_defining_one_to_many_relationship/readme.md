## One-to-Many Relationship

### Steps and Solution

1. **Update Address Model**:
   - Change the `OneToOneField` in the `Address` model to `ForeignKey` to allow multiple addresses for the same customer.
   - This change allows a customer to have multiple addresses.

2. **Update ForeignKey in Address Model**:
   - Modify the `customer` field in the `Address` model to use `models.ForeignKey` instead of `models.OneToOneField`.
   - Set `on_delete=models.CASCADE` to ensure that addresses are deleted when the associated customer is deleted.

3. **Define Product, Order, OrderItem, and Cart Models**:
   - Define new fields and classes to manage products, orders, order items, and shopping carts.

### Example Code

```python
from django.db import models
class Address(models.Model):
    street = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
```

### Explanation

- **Address Model**: The `customer` field is now a `ForeignKey`, allowing multiple addresses per customer.
