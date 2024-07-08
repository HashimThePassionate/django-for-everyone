# Grouping Data

This section explains how to count the number of orders each customer has placed using Django's annotation and aggregation features. We will annotate our customers with a new field called `orders_count`.

#### Importing Necessary Classes

To perform the aggregation, you need to import the necessary classes from Django's models.

```python
from django.db.models import Count
from store.models import Customer, Order
```

#### Annotating Customers with Order Count

We will annotate the `Customer` model with a new field called `orders_count`, which will count the number of orders each customer has placed. This is done using the `Count` class.

```python
# Annotate customers with the number of orders they have placed
from django.shortcuts import render
from .models import Customer
from django.db.models import Count

def index(request):
    customer = Customer.objects.annotate(order_counts=Count('order'))
    return render(request, 'store/index.html', context={'customer': customer})
```
#### Explanation

1. **Count Class**:
   - The `Count` class is used to count the number of related objects. In this case, it counts the number of `Order` objects related to each `Customer`.

2. **Reverse Relationship**:
   - Django automatically creates a reverse relationship from the `Order` model to the `Customer` model because `Customer` is a foreign key in the `Order` model. The reverse relationship is accessed using `order_set` (the lowercase name of the target model followed by `_set`) but in this case we use `order` instead of `order_set` i don't why i get exception when using Count class with `_set`.

3. **Left Join**:
   - Django uses a LEFT JOIN between the `Customer` and `Order` tables to include all customers, even those without any orders. This ensures that every customer appears in the result, with a count of 0 if they have no orders.

