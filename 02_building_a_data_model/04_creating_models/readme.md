# Creating Models

## Step 1: Download and Install MySQL Server and Workbench

1. Download MySQL Server from the [official MySQL website](https://dev.mysql.com/downloads/mysql/).
2. Download MySQL Workbench from the [official MySQL Workbench page](https://dev.mysql.com/downloads/workbench/).
3. Install both MySQL Server and MySQL Workbench on your machine.

## Step 2: Install `mysqlclient`

1. Install `mysqlclient` within your project environment:
   ```bash
   pipenv install mysqlclient
   ```

## Step 3: Create a Database

1. Open MySQL Workbench.
2. Connect to your local MySQL server.
3. Create a new database called `store`:
   ```sql
   CREATE DATABASE store;
   ```

## Step 4: Update `settings.py` Database Configuration

In your Django project's `settings.py` file, update the `DATABASES` setting to use MySQL:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'store',
        'USER': 'your_mysql_username',
        'PASSWORD': 'your_mysql_password',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```

Replace `your_mysql_username` and `your_mysql_password` with your actual MySQL username and password.

## Creating Your First Model Class in Django

In this lesson, we will create our first model class. Let's go to the `store` app and open the `models.py` file.

### Importing Required Modules

First, we need to import the necessary modules from Django:

```python
from django.db import models
```

### Understanding Django Model Classes

The `models` module provides a bunch of useful classes. As we go through this section, you will learn about various built-in field types. For example:

- **BooleanField**: For storing boolean values.
- **CharField**: For storing a sequence of characters or medium-size strings.
- **DateField**: For storing dates.
- **DateTimeField**: For storing date and time.
- **DecimalField**: For storing decimal numbers.

Each field type has additional options, such as creating a database index, setting a default value, etc.

### Defining the Product Model

Let's define a model class for `Product`:

```python
class Product(models.Model):
    title = models.CharField(max_length=255)
    description = models.TextField()
    price = models.DecimalField(max_digits=7, decimal_places=2,db_default=50.00)
    inventory = models.IntegerField()
    last_update = models.DateTimeField(auto_now=True)
```

#### Field Details

- **title**: A `CharField` with a maximum length of 255 characters.
- **description**: A `TextField` for storing long text.
- **price**: A `DecimalField` with a maximum of 7 digits and 2 decimal places and a default value of 50.00.
- **inventory**: An `IntegerField` for storing the number of items in stock.
- **last_update**: A `DateTimeField` that automatically records the current date and time whenever the product is updated.

### Primary Keys and Custom Fields

By default, Django creates an `id` field for each model as a primary key. If you want a custom primary key, you can define it explicitly. For example, in the `Product` class, we can add an `SKU` field as a primary key:

```python
class Product(models.Model):
    sku = models.CharField(max_length=20, primary_key=True)
    title = models.CharField(max_length=255)
    description = models.TextField()
    price = models.DecimalField(max_digits=7, decimal_places=2)
    inventory = models.IntegerField()
    last_update = models.DateTimeField(auto_now=True)
```

#### Field Details

- **sku**: A `CharField` with a maximum length of 20 characters and set as the primary key.
.
