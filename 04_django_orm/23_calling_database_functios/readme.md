#   Calling Database Functions

This section explains how to call database functions in Django to manipulate data. We'll cover how to use the `Func` class and the `Concat` class to create new fields by concatenating strings and referencing fields in the same or another table.

#### Importing Necessary Classes

To call database functions, you need to import the necessary classes from Django's models.

```python
from django.db.models import F, Value, Func
from django.db.models.functions import Concat
from myapp.models import Customer
```

#### Using the `Concat` Function

The `Concat` function allows you to concatenate strings. You can create a new field called `full_name` by concatenating the `first_name` and `last_name` fields.

##### Example: Using `Concat` with `Value` for Spaces

```python
# Annotate customers with a new field 'full_name' by concatenating 'first_name' and 'last_name'
from django.shortcuts import render
from .models import Customer
from django.db.models import Value, F, Func
from django.db.models.functions import Concat

def index(request):
    customer = Customer.objects.annotate(full_name=Func(
        F('first_name'), Value(' '), F('last_name'), function='CONCAT'))
    return render(request, 'store/index.html', context={'customer': customer})

```

In this example, `Concat` is used to concatenate `first_name`, a space (`Value(' ')`), and `last_name`. The `output_field` argument specifies the type of the resulting field, which is `CharField` in this case.

#### Performing Computations with `Func`

The `Func` class allows you to call custom database functions. Here, we demonstrate using `Func` to call a function
##### Example: Using `Func` for Custom Database Functions

```python
# Example of using Func to create a custom function call (hypothetical example)
from django.shortcuts import render
from .models import Customer
from django.db.models import Value, F, Func
from django.db.models.functions import Concat

def index(request):
    customer = Customer.objects.annotate(
        full_name=Concat('first_name', Value(' '), 'last_name'))
    return render(request, 'store/index.html', context={'customer': customer})

```

This example shows how you can create a custom function call by defining a new class that inherits from `Func`. Replace `'CUSTOM_FUNCTION'` with the actual function name you need to call.

#### Conclusion

By using Django's `Func` and `Concat` classes, you can perform various database operations such as concatenating fields and calling custom database functions. These tools provide flexibility and power for manipulating data directly within your Django models.

For more information on available functions and their usage, refer to Django's official documentation [Database Functions](https://docs.djangoproject.com/en/5.0/ref/models/database-functions/).
