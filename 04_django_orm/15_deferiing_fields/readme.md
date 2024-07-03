# Deferring fields

## Optimizing Database Queries

When working with databases, it's essential to optimize your queries to avoid unnecessary data fetching. Here are two methods to help with optimization:

### Using the `only` Method

The `only` method allows you to specify which fields you want to read from the database. This can help reduce the amount of data loaded into memory.

**Example:**

```python
# views.py
from django.shortcuts import render
from .models import Product


def index(request):
    # Fetching only the 'id' and 'title' fields
    products = Product.objects.only('id', 'title'))
    return render(request, 'store/index.html', context={'products': products})

```

**Explanation:**

- We use the `only` method to fetch only the `id` and `title` fields from the `Product` table.
- This reduces the amount of data loaded into memory, making the query more efficient.

**Be Careful:**

If you try to access a field that is not included in the `only` method (e.g., `price`), Django will execute an additional query to fetch that field, which can lead to inefficiencies.

### Using the `defer` Method

The `defer` method allows you to delay the loading of certain fields until they are accessed.

**Example:**

```python
# Fetching all fields except the 'title' field
from django.shortcuts import render
from .models import Product
def index(request):
    products = Product.objects.defer('title')
    return render(request, 'store/index.html', context={'products': products})
```

**Explanation:**

- We use the `defer` method to exclude the `title` field from the initial query.
- The `title` field will only be loaded when it is accessed, reducing the initial data load.

**Be Careful:**

If you access a deferred field within a loop (e.g., rendering the `title` in a template), Django will execute additional queries for each access, which can lead to inefficiencies.
