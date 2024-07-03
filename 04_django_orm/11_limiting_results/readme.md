# Limiting Results and Implement Paginations

When dealing with large datasets, it's often impractical to display all records at once. Instead, we can implement pagination to show a limited number of records per page. This guide demonstrates how to paginate a product table with a thousand products, displaying five products per page.

## Python List Slicing for Pagination

We can use Python's list slicing syntax to implement pagination. 

### Example

To show the first five products (page 1):

```python
# Get the first 5 products (indexes 0 to 4)
from django.shortcuts import render
from .models import Product
def index(request):
    product = Product.objects.all()[:5]
    return render(request, 'store/index.html', {'product': product})
```

### Explanation

- `[:5]`: This slice returns the first five objects in the queryset, corresponding to indexes 0, 1, 2, 3, and 4.

To show the products on the second page (indexes 5 to 9):

```python
# Get products for the second page (indexes 5 to 9)
from django.shortcuts import render
from .models import Product
def index(request):
    # product = Product.objects.all()[:5]
    product = Product.objects.all()[5:10]
    return render(request, 'store/index.html', {'product': product})
```

### Explanation

- `[5:10]`: This slice returns the next five objects in the queryset, corresponding to indexes 6, 7, 8, 9 and 10.

### Implementation Details

When you slice a queryset in Django, it generates an SQL query with `LIMIT` and `OFFSET` clauses to retrieve the appropriate records from the database.

## Implementing Dynamic Pagination with a "Next" Button

To create dynamic pagination and show records across different pages, you can calculate the appropriate slice based on the current page number and handle navigation with a "Next" button.

### Example in a Django View

To implement pagination in a Django view, calculate the appropriate slice based on the current page number and handle navigation with a "Next" button.

```python
from django.shortcuts import render
from .models import Product
from django.core.paginator import Paginator

def index(request):
    page_number = request.GET.get('page', 1)
    page_size = 5
    products = Product.objects.all()
    paginator = Paginator(products, page_size)
    page_obj = paginator.get_page(page_number)

    context = {
        'products': page_obj.object_list,
        'page_obj': page_obj,
    }
    return render(request, 'store/index.html', context)
```
## How Pagination Works in Django

Pagination in Django involves breaking up a large set of data into smaller chunks, or pages, and allowing users to navigate through these pages. Django provides a built-in `Paginator` class to handle this functionality efficiently.

### Components of Pagination

1. **Paginator Class**:
   - This class handles the division of the data into pages.
   - It requires two parameters: the dataset (usually a queryset) and the number of items per page.

2. **Page Object**:
   - A `Page` object represents a single page of data from the paginator.
   - It provides various methods and properties to access the items on the page and information about the page, such as whether it has a previous or next page.
   - The items on the current page are accessible via the `object_list` attribute of the `Page` object.


### Step-by-Step Explanation

#### 1. Import Required Modules

In the view, we import the necessary modules:

```python
from django.shortcuts import render
from .models import Product
from django.core.paginator import Paginator
```

#### 2. Fetch and Paginate Data

In the `index` view, we fetch all products and then use the `Paginator` class to divide them into pages:

```python
def index(request):
    page_number = request.GET.get('page', 1)  # Get the current page number from the request, default to 1
    page_size = 5  # Define the number of items per page
    products = Product.objects.all()  # Fetch all products
    paginator = Paginator(products, page_size)  # Create a Paginator object
    page_obj = paginator.get_page(page_number)  # Get the Page object for the current page
```

#### 3. Pass Data to the Template

We pass the paginated data and the page object to the template:

```python
    context = {
        'products': page_obj.object_list,  # Items on the current page
        'page_obj': page_obj,  # Page object for navigation
    }
    return render(request, 'store/index.html', context)
```

### URL Configuration

Add a URL pattern to handle pagination in your `urls.py`:

```python
from django.urls import path
from .views import index

urlpatterns = [
    path('', index, name='index'),
]
```

### Example Template

Create a template to display the paginated products (`index.html`):

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
    {% if products %}
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
            {% for p in products %}
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
    <div class="mt-3">
        {% if page_obj.has_previous %}
            <a href="?page={{ page_obj.previous_page_number }}" class="btn btn-secondary">Previous</a>
        {% endif %}
        {% if page_obj.has_next %}
            <a href="?page={{ page_obj.next_page_number }}" class="btn btn-primary">Next</a>
        {% endif %}
    </div>
    {% else %}
    <h1 class="mb-4">No Products Available</h1>
    {% endif %}
    </div>

    <script src="{% static 'js/bootstrap.js' %}"></script>
</body>
</html>

```
### Explanation of Template Components

- **Displaying Products**:
  - The products are displayed in a Bootstrap-styled table using a for loop.
  - Each product's details (id, title, description, price, inventory, last update, and collection id) are shown in table rows.

- **Pagination Buttons**:
  - The `page_obj.has_previous` and `page_obj.has_next` properties are used to conditionally display the "Previous" and "Next" buttons.
  - These buttons link to the same view but pass a different `page` parameter in the URL query string to navigate to the previous or next page.
  
### Explanation of Pagination Controls

#### Previous Button

```html
{% if page_obj.has_previous %}
    <a href="?page={{ page_obj.previous_page_number }}" class="btn btn-secondary">Previous</a>
{% endif %}
```

- **`page_obj.has_previous`**:
  - This property is `True` if there are pages before the current page.
  - If `True`, the "Previous" button is displayed.
  - The button's `href` attribute uses the `previous_page_number` property to generate the correct URL for the previous page.
  - **`?page={{ page_obj.previous_page_number }}`**:
    - This creates a query parameter in the URL to specify the page number to navigate to.
    - For example, if the previous page number is 2, the URL will be `?page=2`.

#### Next Button

```html
{% if page_obj.has_next %}
    <a href="?page={{ page_obj.next_page_number }}" class="btn btn-primary">Next</a>
{% endif %}
```

- **`page_obj.has_next`**:
  - This property is `True` if there are pages after the current page.
  - If `True`, the "Next" button is displayed.
  - The button's `href` attribute uses the `next_page_number` property to generate the correct URL for the next page.
  - **`?page={{ page_obj.next_page_number }}`**:
    - This creates a query parameter in the URL to specify the page number to navigate to.
    - For example, if the next page number is 4, the URL will be `?page=4`.