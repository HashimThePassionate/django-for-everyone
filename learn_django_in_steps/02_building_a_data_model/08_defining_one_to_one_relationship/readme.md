## Implementing One-to-One Relationship Between Models

### Steps and Solution

1. **Create Model Classes**:
   - Define a new class `Address` in your models.
   - Assume that each customer should have one and only one address, and each address should belong to one and only one customer.

2. **Define One-to-One Relationship**:
   - To establish a one-to-one relationship between `Customer` and `Address`, the `Customer` should exist before we can create an `Address`.

3. **Add Field in Child Class**:
   - In the `Address` class, add a new field `customer` and set it to `models.OneToOneField`.
   - This field has a couple of required arguments:
     - **Type of the Parent Model**: Specify the parent model (e.g., `Customer`).
     - **Database Specification**: The `customer` field column should not accept null values, so it doesn't make sense to use `null=True`. Instead, set a default value using `default` or prevent deletion using `on_delete=models.PROTECT` or used CASCADE `on_delete=models.CASCADE` when parent record deleted than associated child will also be deleted.

4. **Primary Key Consideration**:
   - If you want to ensure each customer has only one address, you can make this field a primary key. This prevents duplicate values since primary keys do not allow duplicates.

5. **Automatic Reverse Relationship**:
   - Django automatically creates a reverse relationship in the `Customer` class when a `OneToOneField` is defined in the `Address` class. This allows you to access the `Address` from a `Customer` instance.
   - You can customize this relationship using the `related_name` attribute, or you can use the default naming convention provided by Django.
   - **Reverse Relationship**: By default, Django provides a reverse relationship using the lowercase name of the model with `_set` appended. You can customize this using `related_name`.

### Example Code

```python
from django.db import models
class Address(models.Model):
    street = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    customer = models.OneToOneField(Customer, on_delete=models.CASCADE,primary_key=True)
```

### Explanation

- **One-to-One Relationship**: By using `models.OneToOneField`, we ensure that each `Customer` has only one `Address` and vice versa.
- **On Deletion**: The `on_delete=models.CASCADE` ensures that if a `Customer` is deleted, the associated `Address` is also deleted.
- **Database Integrity**: The `customer` field in the `Address` model cannot be null, ensuring database integrity.

### Conclusion

By following these steps, you can successfully implement a one-to-one relationship between two models in Django. This ensures that each customer has a unique address and maintains database integrity.
