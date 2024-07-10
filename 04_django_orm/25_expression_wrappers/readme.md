# Expression Wrapper Class
The `Expression` class is the base class for all types of expressions in our system. It is used to represent various types of values and operations, such as:

- Simple values (Boolean, number, string)
- Field references (`F`)
- Function calls (`Func`)
- Aggregates (base class for all aggregate classes)
- Expresswrapper (For complex computing)

Here's a textual diagram similar to the image you provided:

<pre>
+-------------------+
|    Expression     | ----------------+
+-------------------+                 |
                                      |
                                      |
                            +-------------------+
                            |      Value        |
                            +-------------------+
                                      |
                                      |
                            +-------------------+
                            |        F          |
                            +-------------------+
                                      |
                                      |
                            +-------------------+
                            |      Func         |
                            +-------------------+
                                      |
                                      |
                            +-------------------+
                            |   Aggregate       |
                            +-------------------+
                                      |
                                      |
                            +-------------------+
                            | ExpressionWrapper |
                            +-------------------+
</pre>

## Example Usage

We have a field called `price` which is a decimal field. We need to create an expression that multiplies this `price` by 5.8 and stores the result in a new computed column.

### Problem

The area requires setting the output field type explicitly. To solve this problem, we need to use the `ExpressionWrapper` class from the same model.

### Solution

1. **Import the ExpressionWrapper Class**
   
   Import the `ExpressionWrapper` class from the models module.

2. **Create an Expression Object**
   
   Wrap the expression inside an `ExpressionWrapper` object, specifying the type of the output field.

### Step-by-Step Guide

1. **Import the Required Classes**
   ```python
   from django.db.models import F, ExpressionWrapper, DecimalField
   ```

2. **Create the Expression**
   
   Here, we create an expression that multiplies the `price` by 5.8.

```python
discounted_price = ExpressionWrapper(
        F('price') * 0.8, output_field=DecimalField())
```

3. **Use the Computed Expression**

   Store the result in a new field, `discounted_price`, and use it in a query.

### Complete example **views.py**
```python
from django.shortcuts import render
from .models import Product
from django.db.models import F, ExpressionWrapper, DecimalField

def index(request):
    discounted_price = ExpressionWrapper(
        F('price') * 0.8, output_field=DecimalField())
    product = Product.objects.annotate(
        discounted_price=discounted_price)
    return render(request, 'store/index.html', context={'product': product})

```
### Explanation

- **F('price')**: This is a field reference that points to the `price` field in the database.
- **ExpressionWrapper(price * 5.8, output_field=DecimalField())**: This wraps the multiplication expression and specifies that the output will be a decimal field.
- **product = Product.objects.annotate(discounted_price=discounted_price)**: This uses the annotated expression to create a new field called `discounted_price` in the query result.

This is how you can use expression objects to create complex queries with computed columns.

