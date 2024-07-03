## Retrieving Objects with Filters

### Finding Products by Price with filter

To find all products that are 73.47
```python
from django.shortcuts import render
from .models import Product
def index(request):
    product = Product.objects.filter(price=73.47)
    return render(request, 'store/index.html', context={'product': product})
```

### Finding Products Greater Than a Certain Price

To find all products that are more expensive than price 73.47, use the `gt` (greater than) lookup why we use lookups `gt` `lt` etc instead of >,>=,<=,< because  these operator return boolean value
```python
from django.shortcuts import render
from .models import Product
def index(request):
    products = Product.objects.filter(price__gt=20.00)
    return render(request, 'store/index.html', context={'product': product})
```

### Finding Products in a Price Range

To find products with prices between $20 and $30:

```python
from django.shortcuts import render
from .models import Product
def index(request):
    products = Product.objects.filter(price__gte=20.00, price__lte=30.00)
    return render(request, 'store/index.html', context={'product': product})
```

### Filtering Across Relationships

To find all products in collection number one:

```python
products = Product.objects.filter(collection_id=1)
```

### Using String Lookups

To find products that contain "coffee" in the title, use the `contains` lookup:

```python
products = Product.objects.filter(title__contains="coffee")
```

Note: The `contains` lookup is case-sensitive. For a case-insensitive search, use `icontains`:

```python
products = Product.objects.filter(title__icontains="coffee")
```

### Filtering by Date

To find products that were updated in 2021:

```python
from datetime import datetime

products = Product.objects.filter(last_update__year=2021)
```

### Checking for Null Values

To get all products without a description:

```python
products = Product.objects.filter(description__isnull=True)
```

## Tips for Effective Querying

- Use descriptive variable names that reflect the type of value being stored.
- Convert QuerySets to lists if you need to store them in a dictionary or another data structure.
- Utilize Django's extensive field lookups to perform various types of queries on your models.

## Running the Application
1. Ensure you have Django installed.
2. Run the development server:
   ```bash
   python manage.py runserver
   ```
3. Access the application at `http://127.0.0.1:8000`.


[Lookup Reference](https://docs.djangoproject.com/en/5.0/ref/models/querysets/)