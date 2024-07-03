# Filtering Data with Field References in Django

In this guide, we will explore how to filter data by referencing particular fields in Django. Specifically, we will look at how to compare two fields within a query.

## Comparing Two Fields in a Filter

Sometimes, we need to filter data based on a comparison between two fields. For example, let's say we want to find all products where the inventory equals the unit price. Although this might not make sense from a business perspective, it serves as a good example for comparing fields.

### Example

To compare two fields, we use the `F` object from `django.db.models`.

```python
# Filtering products where inventory equals the unit price
from django.shortcuts import render
from .models import Product
from django.db.models import Q, F
def index(request):
    product = Product.objects.filter(inventory=F('price'))
    return render(request, 'store/index.html', {'product': product})
```

### Explanation

- `F('price')`: Creates an `F` object that references the `price` field.
- `filter(inventory=F('price'))`: Compares the `inventory` field to the `price` field within the database.

### Handling No Results

In the example above, we might not have any products that meet the criteria of having the same inventory and unit price. This is expected, but let's check the SQL query generated to understand how Django constructs it.

By examining the SQL query, you can understand how Django references and compares the fields.


## Filtering with Related Fields

You can also compare a field with a related field using the `F` object. For example, to filter products where the inventory is equal to the collection ID:

### Example

```python
from django.shortcuts import render
from .models import Product
from django.db.models import Q, F
def index(request):
    product = Product.objects.filter(inventory=F('collection__id'))
    products = Product.objects.filter(inventory=F('collection__id'))
    return render(request, 'store/index.html', {'product': product})
```

### Explanation

- `F('collection__id')`: References the `id` field of the related `collection` model.
- `filter(inventory=F('collection__id'))`: Compares the `inventory` field with the `id` field of the related `collection`.

### Usage

In this example, the view filters products based on a comparison between the `inventory` field and the `id` field of the related `collection`. The results are then passed to the template for rendering.
