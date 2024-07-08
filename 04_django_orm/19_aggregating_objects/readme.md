# Aggregate Objects

This section will guide you how to compute summaries like the maximum or average price of products using Django's aggregate methods. We'll cover how to use aggregate classes and provide examples of counting and summarizing product data.

#### Importing Aggregate Classes

First, you need to import the necessary aggregate classes from Django in your **views.py**:

```python
from django.db.models import Avg, Max, Sum, Count
```

#### Counting Total Number of Products

To count the total number of products, you can use the `Count` aggregate function. The correct way to count the total number of records is by using the `ID` or primary key field.

Example:
```python
from django.shortcuts import render
from .models import Product
from django.db.models import Avg, Max, Sum, Count, Min

def index(request):
    result = Product.objects.aggregate(total_records=Count('id'))
    return render(request, 'store/index.html', context={'result': result})

```

#### Calculating Multiple Summaries

You can calculate multiple summaries at once. For example, in addition to counting the total number of products, you can also calculate the minimum price, maximum price, average price and sum of price.

Example:
```python
from django.shortcuts import render
from .models import Product
from django.db.models import Avg, Max, Sum, Count, Min

def index(request):
    result = Product.objects.aggregate(avg_price=Avg('price'), max_price=Max(
        'price'), min_price=Min('price'), total_records=Count('id'), total_price=Sum('price'))
    return render(request, 'store/index.html', context={'result': result})

```

#### Filtering Before Aggregating

You can filter the products before calculating the summaries. For instance, to summarize products in a specific collection, you can use the `filter` method.

Example:
```python
from django.shortcuts import render
from .models import Product
from django.db.models import Avg, Max, Sum, Count, Min

def index(request):'))
    result = Product.objects.filter(collection__id=6).aggregate(avg_price=Avg('price'), max_price=Max(
        'price'), min_price=Min('price'), total_records=Count('id'), total_price=Sum('price'))
    return render(request, 'store/index.html', context={'result': result})
```
