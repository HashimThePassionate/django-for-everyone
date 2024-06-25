# Complex Lookups Using Q objects

In this guide, we will demonstrate how to apply multiple filters to find products based on specific conditions. We will cover how to use both the `and` and `or` operators to combine filter conditions.

## Combining Filters with the `and` Operator

To find all products with an inventory of less than 10 and a unit price of less than 20, we can pass multiple keyword arguments to the `filter` method.

### Example

```python
# Filtering products with inventory < 10 and unit price < 20
from django.shortcuts import render
from .models import Product
def index(request):
    product = Product.objects.filter(inventory__lt=10, price__lt=20)
    return render(request, 'store/index.html', {'product': product})
```

In this example, the conditions are combined using the `and` operator.

### Alternative Method

You can also chain the `filter` methods to achieve the same result.

```python
# Chaining filter methods to combine conditions with 'and' operator
from django.shortcuts import render
from .models import Product
def index(request):
    product = Product.objects.filter(inventory__lt=10).filter(price__lt=20)
    return render(request, 'store/index.html', {'product': product})
```

Both methods will return a queryset with products that satisfy both conditions.

## Combining Filters with the `or` Operator

To combine conditions using the `or` operator, we need to use Django's `Q` objects.

### Example

First, import the `Q` object from `django.db.models`.

```python
from django.db.models import Q
```

Next, use the `Q` objects to combine conditions.

```python
# Filtering products with inventory < 10 or unit price < 20
from django.shortcuts import render
from django.db.models import Q
from .models import Product
def index(request):
    product = Product.objects.filter(Q(inventory__lt=10) | Q(price__lt=20))
    return render(request, 'store/index.html', {'product': product})
```

### Explanation

- `Q(inventory__lt=10)`: Filters products with inventory less than 10.
- `|`: The `or` operator.
- `Q(price__lt=20)`: Filters products with unit price less than 20.

The resulting queryset will contain products that meet either of the conditions.

## Combining Filters with Negation

You can also use the `~` operator with `Q` objects to negate a condition.

### Example

```python
# Filtering products with inventory < 10 or unit price >= 20
from django.shortcuts import render
from django.db.models import Q
from .models import Product
def index(request):
    product = Product.objects.filter(Q(inventory__lt=10) | ~Q(price__lt=20))
    return render(request, 'store/index.html', {'product': product})
```

### Explanation

- `Q(inventory__lt=10)`: Filters products with inventory less than 10.
- `|`: The `or` operator.
- `~Q(price__lt=20)`: Negates the condition, effectively filtering products with a unit price greater than or equal to 20.

This queryset returns products that either have an inventory less than 10 or a unit price that is not less than 20.

## Building Complex Queries

Using `Q` objects, you can build complex queries with multiple conditions combined using both `and` and `or` operators.

### Example

```python
# Filtering products with inventory < 10 and (unit price < 20 or unit price > 50)
from django.shortcuts import render
from django.db.models import Q
from .models import Product
def index(request):
     product = Product.objects.filter(Q(inventory__lt=10) & (Q(price__lt=20) | Q(price__gt=50)))
    return render(request, 'store/index.html', {'product': product})
```

### Explanation

- `Q(inventory__lt=10)`: Filters products with inventory less than 10.
- `&`: The `and` operator.
- `(Q(price__lt=20) | Q(price__gt=50))`: Filters products with unit price less than 20 or greater than 50.

This queryset returns products that meet the inventory condition and either of the price conditions.

## Summary

- Use multiple keyword arguments or chain `filter` methods to combine conditions with the `and` operator.
- Use `Q` objects to combine conditions with the `or` operator.
- Use the `~` operator with `Q` objects to negate conditions.
- Combine `Q` objects with both `&` (and) and `|` (or) to build complex queries.

By mastering these techniques, you can efficiently filter data in Django based on various conditions.
