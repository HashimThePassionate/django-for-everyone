# Retrieving Objects

## Open store app views.py module  

### Retrieving all Objects `views.py`
The `all()` method retrieves all objects from a given table. For example, to get all products:
The `views.py` file contains the logic for rendering the product list and a specific product.

```python
from django.shortcuts import render
from .models import Product
from django.core.exceptions import ObjectDoesNotExist

def index(request):
    product = Product.objects.all()  # Select all products from the database
    return render(request, 'store/index.html', context={'product': product})
```

### Method 2: `get()`
The `get()` method retrieves a single object based on given parameters. If the object does not exist, it raises a `DoesNotExist` exception.

Example:
```python
from django.shortcuts import render
from .models import Product
from django.core.exceptions import ObjectDoesNotExist

def index(request):
    product = Product.objects.all()  # Select all products from the database
    sp = Product.objects.get(pk=1)  # Select a specific product from
    try:
# any object that does not exists will crash the server to solve this  we need import ObjectDoestNotExists 
# and  use try and except block and wrap it 
        sp = Product.objects.get(pk=0)
    except ObjectDoesNotExist:
        sp = None
    return render(request, 'store/index.html', context={'product': product, 'sp': sp})
```

### Method 3: `filter()`
The `filter()` method returns a QuerySet of objects that match the given parameters. You can chain it with `first()` to get the first object or check if any object exists.

Example:
```python
def index(request):
    product = Product.objects.all()  # Select all products from the database
    sp = Product.objects.get(pk=1)  # Select a specific product from
    fp = Product.objects.filter(id=21).first()
    if product:
        print("Product found")
    else:
        print("Product not found")
    try:
# any object that does not exists will crash the server to solve this  we need import ObjectDoestNotExists 
# and  use try and except block and wrap it 
        sp = Product.objects.get(pk=0)
    except ObjectDoesNotExist:
        sp = None
    return render(request, 'store/index.html', context={'product': product, 'sp': sp})
```
## URL Configurations

### Store App URLs

The `urls.py` file in the store app contains the URL configuration for the index view.

```python
from django.urls import path
from .views import index

urlpatterns = [
    path('', index, name='index'),
]
```

### Project URLs

The project's `urls.py` file includes the store app URLs and sets up the admin interface.

```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('store.urls')),
    path("__debug__/", include("debug_toolbar.urls")),
]
```

## Templates

### index.html

The `index.html` template displays the list of products and a specific product using Bootstrap for styling.

```html
<!-- store/templates/store/index.html -->
<!DOCTYPE html>
{% load static %}
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Django Template Example</title>
    <link rel="stylesheet" href="{% static 'css/bootstrap.css' %}">
</head>
<body>
    <div class="container mt-5">
    {% if product %}
    <h1 class="mb-4">Product List</h1>
    <table class="table table-bordered table-hover">
        <thead class="thead-dark">
            <tr>
                <th>id</th>
                <th>Title</th>
                <th>Description</th>
                <th>Price</th>
                <th>Inventory</th>
                <th>Last Update</th>
                <th>Collection</th>
            </tr>
        </thead>
        <tbody>
            {% for p in product %}
            <tr>
                <td>{{ p.id }}</td>
                <td>{{ p.title }}</td>
                <td>{{ p.description }}</td>
                <td>{{ p.price }}</td>
                <td>{{ p.inventory }}</td>
                <td>{{ p.last_update }}</td>
                <td>{{ p.collection_id }}</td>
            </tr>
            {% endfor %}
        </tbody>
    </table>
    {% else %}
    <h1 class="mb-4">Product Not Exists</h1>
    {% endif %}
    </div>
<div class="container">
    <h1 class="mb-4">Single Product</h1>
    {% if sp %}
    <table class="table table-bordered table-hover">
        <thead class="thead-dark">
            <tr>
                <th>id</th>
                <th>Title</th>
                <th>Description</th>
                <th>Price</th>
                <th>Inventory</th>
                <th>Last Update</th>
                <th>Collection</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>{{ sp.id }}</td>
                <td>{{ sp.title }}</td>
                <td>{{ sp.description }}</td>
                <td>{{ sp.price }}</td>
                <td>{{ sp.inventory }}</td>
                <td>{{ sp.last_update }}</td>
                <td>{{ sp.collection_id }}</td>
            </tr>
        </tbody>
    </table>
    {% else %}
    <h1 class="mb-4">No Single Data</h1>
    {% endif %}
</div>

    <script src="{% static 'js/bootstrap.js' %}"></script>
</body>
</html>
```

## Running the Application
1. Ensure you have Django installed.
2. Run the development server:
   ```bash
   python manage.py runserver
   ```
3. Access the application at `http://127.0.0.1:8000`.
