# Sorting Data

In this guide, we will explore how to sort data in Django using the `order_by` method, and other convenience methods like `reverse` and `earliest`. We will cover sorting by multiple fields, reversing the sort order, and combining sorting with filtering.

## Using the `order_by` Method

The `order_by` method allows us to sort query results by one or more fields.

### Example

To sort products by their title in ascending order:

```python
# Sorting products by title in ascending order
from django.shortcuts import render
from .models import Product
def index(request):
    product = Product.objects.order_by('title')
    return render(request, 'store/index.html', {'product': product})
```

### Sorting by Multiple Fields

You can sort by multiple fields by passing multiple arguments to the `order_by` method.

```python
# Sorting products by price in ascending order and then by title in descending order
from django.shortcuts import render
from .models import Product
def index(request):
     product = Product.objects.order_by('price', '-title')
    return render(request, 'store/index.html', {'product': product})
```

### Explanation

- `order_by('price')`: Sorts products by price in ascending order.
- `order_by('-title')`: Sorts products by title in descending order.

With this implementation, products are first sorted by price from the cheapest to the most expensive. If multiple products have the same price, they are then sorted by their title in descending order.

## Reversing the Sort Order

The `order_by` method returns a queryset object. We can call the `reverse` method on this queryset to reverse the sort order.

### Example

To sort products by unit price in descending order:

```python
# Sorting products by price in descending order
from django.shortcuts import render
from .models import Product
def index(request):
     product = Product.objects.order_by('price').reverse()
    return render(request, 'store/index.html', {'product': product})
```

### Explanation

- `reverse()`: Reverses the direction of the sort. If the original order is ascending, it will be changed to descending and vice versa.

## Combining Sorting with Filtering

You can also call the `order_by` method after filtering data since the `filter` method returns a queryset.

### Example

To filter products in collection 1 and sort them by unit price:

```python
# Filtering products in collection 6 and sorting by price
from django.shortcuts import render
from .models import Product
def index(request):
     product = Product.objects.filter(collection_id=6).order_by('price')
    return render(request, 'store/index.html', {'product': product})
```

## Using the `earliest` Method

Django provides a convenience method called `earliest` to sort the results by a specified field and get the first object.

### Example

To get the product with the earliest (lowest) unit price:

```python
# Getting the product with the lowest price
from django.shortcuts import render
from .models import Product
def index(request):
    p = Product.objects.earliest('price')
    return render(request, 'store/index.html', {'p': p})
```

### Explanation

- `earliest('price')`: Sorts the products by price in ascending order and returns the first product.

## Summary

- Use the `order_by` method to sort query results by one or more fields.
- Use the `reverse` method to reverse the sort order of a queryset.
- Combine the `filter` and `order_by` methods to filter and sort data.
- Use the `earliest` method to get the first object in a sorted queryset.

By understanding and utilizing these techniques, you can effectively sort and manage data in Django, allowing for more flexible and dynamic queries.
