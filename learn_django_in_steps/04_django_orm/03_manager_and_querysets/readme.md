# Managers and QuerySets

## Introduction

In this section, we will cover the concepts of managers and query sets in Django ORM. Managers are like remote control buttons that we can use to interact with a database, providing methods for querying or updating data.

## Key Concepts

### Managers and QuerySets

- **Managers**: Provide methods to interact with the database, such as retrieving or updating data.
- **QuerySets**: Return sets of objects from the database based on the applied filters and methods.

### Common QuerySet Methods

- `all()`: Retrieves all objects.
- `get()`: Retrieves a single object.
- `filter()`: Filters data based on given parameters.

These methods do not return lists directly; instead, they return QuerySets, which are evaluated lazily.

### Lazy Evaluation

- QuerySets are not evaluated until they are specifically called for (e.g., iterated over, converted to a list, etc.).
- This allows for the application of additional filters or sorts before the final evaluation, optimizing database queries.

### Debugging with Django Debug Toolbar

- Open the Django Debug Toolbar to see the actual SQL statements Django sends to the database.
- You can see the SQL queries and their results, helping to understand the data interactions better.

## Examples

### Retrieving Data

1. **Retrieving All Products**
   ```python
   products = Product.objects.all()
   ```

2. **Filtering Data**
   ```python
   cheap_products = Product.objects.filter(price__lt=10)
   ```

3. **Getting a Single Object**
   ```python
   single_product = Product.objects.get(id=1)
   ```

### Lazy Evaluation in Practice

- Using slicing to get the first five elements:
  ```python
  first_five_products = Product.objects.all()[:5]
  ```

- Applying additional filters:
  ```python
  filtered_products = Product.objects.all()[:5].filter(collection='grocery')
  ```

### Counting Records

- Counting the number of products:
  ```python
  product_count = Product.objects.count()
  ```

  This method returns a number immediately and is not lazily evaluated because it doesn't make sense to filter or sort a single number.