# Selecting Related Objects

## Rendering a Collection of Products

Sometimes, we need to display a list of objects, like all products, on a template. Here’s how to do it:

1. **Fetch All Products**:
```python
   from django.shortcuts import render
   from .models import Product
   def index(request):
       products = Product.objects.all()
       return render(request, 'store/index.html', context={'products': products})
```

2. **Render Products in a Template**:
   In your template, you can loop through the products and display them:
```html
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
            <th>Collection Title</th>
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
            <td>{{ p.collection.title }}</td>
          </tr>
          {% endfor %}
        </tbody>
      </table>
      {% else %}
      <h1 class="mb-4">No Products Available</h1>
      {% endif %}
    </div>
```
### To many extra queries
Why too many extra queries? this is because you did not select collection related objects, so django send extra queries to read from database.

### Understanding SQL Queries in Django

When you fetch products and their related collections, Django performs SQL queries behind the scenes. Here’s a simple explanation:

1. **Fetching Products and Collections**:
```python
from django.shortcuts import render
from .models import Product
def index(request):
    # products = Product.objects.all()
    products = Product.objects.select_related('collection').all()
    return render(request, 'store/index.html', context={'products': products})
```
   - `select_related('collection')` is used to join the `Product` table with the `Collection` table, reducing the number of database queries.

**Render Products in a Template**:
   In your template, you can loop through the products and display them:
```html
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
            <th>Collection Title</th>
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
            <td>{{ p.collection.title }}</td>
          </tr>
          {% endfor %}
        </tbody>
      </table>
      {% else %}
      <h1 class="mb-4">No Products Available</h1>
      {% endif %}
    </div>
```
2. **SQL Query Explanation**:
   - This query selects all fields from the `Product` table and some fields from the `Collection` table, joining them based on their relationship.

### Prefetching Related Objects

Sometimes a product has many related objects, like promotions. Use `prefetch_related` to efficiently fetch them:

1. **Fetch Products with Promotions**:
```python
from django.shortcuts import render
from .models import Product
def index(request):
    # products = Product.objects.all()
    # products = Product.objects.select_related('collection').all()
    products = Product.objects.prefetch_related('promotions').all()
    return render(request, 'store/index.html', context={'products': products})
```
   - `prefetch_related('promotions')` fetches all promotions related to each product in a single query.
**Render Products in a Template**:
   In your template, you can loop through the products and display them:
```html
<!-- store/templates/store/index.html -->
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
       {% comment %}
       <th>Collection Title</th>
       {% endcomment %}
       <th>Promotion Discount</th>
     </tr>
   </thead>
   <tbody>
     {% for p in products %} 
     {% for promotion in p.promotions.all %}
     <tr>
       <td>{{ p.id }}</td>
       <td>{{ p.title }}</td>
       <td>{{ p.description }}</td>
       <td>{{ p.price }}</td>
       <td>{{ p.inventory }}</td>
       {% comment %}
       <td>{{ p.collection.title }}</td>
       {% endcomment %}
       <td>{{ promotion.discount }}</td>
     </tr>
     {% endfor %} {% endfor %}
   </tbody>
 </table>
 {% else %}
 <h1 class="mb-4">No Products Available</h1>
 {% endif %}
</div>
```

### Complex Queries

You can chain methods to build complex queries. The order of methods usually doesn’t matter.

1. **Example Query**:
   ```python
   products = Product.objects.select_related('collection').prefetch_related('promotions').all()
   ```
**Render Products in a Template**:
   In your template, you can loop through the products and display them:
```html
<!-- store/templates/store/index.html -->
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
       {% comment %}
       <th>Collection Title</th>
       {% endcomment %}
       <th>Promotion Discount</th>
     </tr>
   </thead>
   <tbody>
     {% for p in products %} 
     {% for promotion in p.promotions.all %}
     <tr>
       <td>{{ p.id }}</td>
       <td>{{ p.title }}</td>
       <td>{{ p.description }}</td>
       <td>{{ p.price }}</td>
       <td>{{ p.inventory }}</td>
       <td>{{ p.collection.title }}</td>
       <td>{{ promotion.discount }}</td>
     </tr>
     {% endfor %} {% endfor %}
   </tbody>
 </table>
 {% else %}
 <h1 class="mb-4">No Products Available</h1>
 {% endif %}
</div>
```