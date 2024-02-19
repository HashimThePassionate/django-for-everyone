# Wellcome to Django-for-absolute-biginners repositry
In this repostry,  we learn to make website without  virtualenv

# To use this repo please clone first
```
https://github.com/HashimThePassionate/django-for-absolute-beginners.git
```

## If you learn and get started follow step by step
### install django
Enter this command
```
pip install django
```
See the installing process
<pre>
Collecting django
  Using cached Django-5.0.1-py3-none-any.whl.metadata (4.2 kB)
Collecting asgiref<4,>=3.7.0 (from django)
  Using cached asgiref-3.7.2-py3-none-any.whl.metadata (9.2 kB)
Collecting sqlparse>=0.3.1 (from django)
  Using cached sqlparse-0.4.4-py3-none-any.whl (41 kB)
Collecting tzdata (from django)
  Using cached tzdata-2023.4-py2.py3-none-any.whl.metadata (1.4 kB)
Using cached Django-5.0.1-py3-none-any.whl (8.1 MB)
Using cached asgiref-3.7.2-py3-none-any.whl (24 kB)
Using cached tzdata-2023.4-py2.py3-none-any.whl (346 kB)
Installing collected packages: tzdata, sqlparse, asgiref, django
Successfully installed asgiref-3.7.2 django-5.0.1 sqlparse-0.4.4 tzdata-2023.4
</pre>
- asgiref, sqlparse, tzdata are installed with django, these are must used to create website.

## Step-02
### ckeck pip list, you see output;
<pre>
Package  Version
-------- -------
asgiref  3.7.2
Django   5.0.1
pip      23.3.2
sqlparse 0.4.4
tzdata   2023.4
</pre>

## Step-03
### Then install mysqlclient

Enter this Command
```bash
pip install mysqlclient
```
See the installing process
<pre>
Collecting mysqlclient
  Using cached mysqlclient-2.2.1-cp311-cp311-win_amd64.whl.metadata (4.6 kB)
Using cached mysqlclient-2.2.1-cp311-cp311-win_amd64.whl (202 kB)
Installing collected packages: mysqlclient
Successfully installed mysqlclient-2.2.1
</pre>

## Step-04
### After installing mysqlclient, create startproject

Enter this Command
```bash
django-admin startproject storefront
```
See folder;
<pre>
storefront
        |___ storefront
        |           |___ __init__.py
        |           |___ asgi.py
        |           |___ settings.py
        |           |___ urls.py
        |           |___ wsgi.py
        |
        |___ manage.py

</pre>

## Step-05
### Enter cd command
Enter cd command to go inside storefront
command
```bash
cd storefront
```
See path 
<pre>
PS E:\Django\E-Comerase\storefront>
</pre>
- You must use this command.

## Step-06
### Create app
Enter this Command
```bash
django-admin startapp store
```
See folder;
<pre>
storefront
        |___ store
        |
        |___ storefront
        |           |___ __init__.py
        |           |___ asgi.py
        |           |___ settings.py
        |           |___ urls.py
        |           |___ wsgi.py
        |
        |___ manage.py

</pre>
- The store app is created

## Step-07
### Create another app
command
```bash
django-admin startapp tags
```
See folder;
<pre>
storefront
        |___ store    
        |___ storefront
        |           |___ __init__.py
        |           |___ asgi.py
        |           |___ settings.py
        |           |___ urls.py
        |           |___ wsgi.py
        |
        |___ tags
        |___ manage.py

</pre>
 - The tags app is created.
 
 ## Step-8
### Install apps in project
- Open project folder (storefront) and settings.py file.
- Go to INSTALLED_APPS
<pre>
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
</pre>
Add this Code
```bash
'store',
'tags',
```
See again
<pre>
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'store',
    'tags',
]
</pre>
 - The 'store', and 'tags', are installed.

## Step-9  
### Create templatesfolder inside and inside index.html
See folder;
<pre>
storefront
        |___ store    
        |___ storefront
        |           |___ __init__.py
        |           |___ asgi.py
        |           |___ settings.py
        |           |___ urls.py
        |           |___ wsgi.py
        |
        |___ tags
        |___ Templates
        |           |___index.html
        |___ manage.py

</pre>

## Step-10
### Write code in setting.py
- Go to TEMPLATES.
<pre>
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
</pre>

write code in Templates
```python
import os
TEMPLATE_DIR = os.path.join(BASE_DIR, 'templates')
```

See again 
<pre>
import os
TEMPLATE_DIR = os.path.join(BASE_DIR, 'templates')
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [TEMPLATE_DIR],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
</pre>

## Step-11
### Go to views.py inside store
In views.py  write this code.
```python
from django.shortcuts import render
def home(request):
return render(request, 'index.html', )
```

## Step-12
### Then open urls.py inside storefront
In urls.py write this code
```python
from django.contrib import admin
from django.urls import path, include
from store import views
urlpatterns = [
    path('admin/', admin.site.urls),
    path('',views.home ),
]
```

## Step-13
### Then open index.html inside Templates folder and write simple code
Code
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Models</title>
</head>
<body>
    <div class="container bg-success opacity-50 p-4 mb-3">
    <h1 class="text-light">Welcome to Models in Django</h1>

</body>
</html>
```

## Step-14
### Install debug toolbar
command
```bash
pip install django-debug-toolbar==4.2.0
```
See the installing process
<pre>
Collecting django-debug-toolbar==4.2.0
  Using cached django_debug_toolbar-4.2.0-py3-none-any.whl.metadata (3.8 kB)
Requirement already satisfied: django>=3.2.4 in c:\users\hp\appdata\local\programs\python\python311\lib\site-packages (from django-debug-toolbar==4.2.0) (5.0.1)
Requirement already satisfied: sqlparse>=0.2 in c:\users\hp\appdata\local\programs\python\python311\lib\site-packages (from django-debug-toolbar==4.2.0) (0.4.4)     
Requirement already satisfied: asgiref<4,>=3.7.0 in c:\users\hp\appdata\local\programs\python\python311\lib\site-packages (from django>=3.2.4->django-debug-toolbar==4.2.0) (3.7.2)
Requirement already satisfied: tzdata in c:\users\hp\appdata\local\programs\python\python311\lib\site-packages (from django>=3.2.4->django-debug-toolbar==4.2.0) (2023.4)
Using cached django_debug_toolbar-4.2.0-py3-none-any.whl (223 kB)
Installing collected packages: django-debug-toolbar
Successfully installed django-debug-toolbar-4.2.0
</pre>
- After installing debug toolbar,you must add inside project(storefront).
See the processing

## Step-15
#### Processing/Setting 
**1. Install the App**
Inside this code
<pre>
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'store',
    'tags',
    
]
</pre>

Add in this code, behind 'tags'
```python
 "debug_toolbar",
```
See this
<pre>
INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'store',
    'tags',
    'debug_toolbar',
]
</pre>

**2. Add the URL IN urls.py**
Inside this code
<pre>
from django.contrib import admin
from django.urls import path
from store import views
urlpatterns = [
    path('admin/', admin.site.urls),
]
</pre>

Add this code
```python
 path("__debug__/", include("debug_toolbar.urls")),
```
<pre>
from django.contrib import admin
from django.urls import path, include
from store import views
urlpatterns = [
    path('admin/', admin.site.urls),
  path("__debug__/", include("debug_toolbar.urls")),
]
</pre>

**3. Add the Middleware**
Inside this code
<pre>
MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
  
</pre>


In this code add this
```python
 "debug_toolbar.middleware.DebugToolbarMiddleware",
```
See this
<pre>
MIDDLEWARE = [
    'debug_toolbar.middleware.DebugToolbarMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]
</pre>

**4.  Then add INTERNAL_IPS**
Code
```python
 INTERNAL_IPS = [
    # ...
    "127.0.0.1",
    # ...
]
```

## Step-16
### Simple test
Before testing, you mush indise your project
Enter this command to test
```bash
python manage.py runserver
```
Watching for file changes with StatReloader
<pre>
Performing system checks...

System check identified no issues (0 silenced).

You have 18 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
Run 'python manage.py migrate' to apply them.
January 27, 2024 - 08:34:04
Django version 5.0.1, using settings 'storefront.settings'
Starting development server at http://127.0.0.1:8000/
Quit the server with CTRL-BREAK.
</pre>
- Second last line,see the link and (ctrl+click) click the link.
- Your django server is running.

## Step-17
### Setup my SQL DBMS


In setting.py go to database
<pre>
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
    }
}
</pre>

add setup
```python
DATABASES = {
    'default': {
        
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'store',         
        'USER': 'root',       
        'PASSWORD': '',   
        'HOST': 'localhost',
        'PORT': '3306', 
    }
}
```
- Install XAMPP
- Create New DateBase 
- Go to Previliges
- Inside Previliges, go to last option, edit  Previliges
- Edit privileges: User account 'root'@'localhost'
- copy 'root' and 'localhost'
- Paste  it in User and Host.

## Step-18
### Create DBMS tables/models in models.py inside store
In django, DBMS tables are also called models
Lets Start;
Write code
```python
from django.db import models


class Promotion(models.Model):
    description = models.CharField(max_length=255)
    discount = models.FloatField()
    featured_product = models.ForeignKey(
        'Product', on_delete=models.SET_NULL, null=True, related_name='product_f')


class Collection(models.Model):
    title = models.CharField(max_length=255)


class Product(models.Model):
    title = models.CharField(max_length=255)
    slug = models.SlugField(default='-')
    description = models.TextField()
    price = models.DecimalField(max_digits=6, decimal_places=2)
    inventory = models.IntegerField()
    last_update = models.DateTimeField(auto_now=True)
    collection = models.ForeignKey(Collection, on_delete=models.PROTECT)
    promotions = models.ManyToManyField(Promotion)


class Customer(models.Model):
    MEMBERSHIP_SILVER = 'S'
    MEMBERSHIP_GOLD = 'G'
    MEMBERSHIP_DIAMOND = 'D'

    MEMBERSHIP_CHOICES = [
        (MEMBERSHIP_SILVER, 'SILVER'),
        (MEMBERSHIP_GOLD, 'GOLD'),
        (MEMBERSHIP_DIAMOND, 'DIAMOND'),
    ]
    first_name = models.CharField(max_length=255)
    last_name = models.CharField(max_length=255)
    email = models.EmailField(max_length=254, unique=True)
    phone = models.CharField(max_length=255)
    birth_date = models.DateField(null=True)
    membership = models.CharField(
        max_length=1, choices=MEMBERSHIP_CHOICES, default=MEMBERSHIP_SILVER)


class Order(models.Model):
    PAYMENT_PENDING = 'P'
    PAYMENT_COMPLETE = 'C'
    PAYMENT_FAILED = 'F'
    PAYMENT_CHOICES = [
        (PAYMENT_PENDING, 'PENDING'),
        (PAYMENT_COMPLETE, 'COMPLETE'),
        (PAYMENT_FAILED, 'FAILED'),
    ]
    place_at = models.DateField(auto_now_add=True)
    payment_status = models.CharField(
        max_length=1, choices=PAYMENT_CHOICES, default=PAYMENT_PENDING)
    customer = models.ForeignKey(Customer, on_delete=models.PROTECT)


class Address(models.Model):
    street = models.CharField(max_length=255)
    city = models.CharField(max_length=255)
    customer = models.OneToOneField(
        Customer, on_delete=models.CASCADE, primary_key=True)

class Orderitem(models.Model):
    order = models.ForeignKey(Order, on_delete=models.PROTECT)
    product = models.ForeignKey(Product, on_delete=models.PROTECT)
    quantity = models.PositiveSmallIntegerField()
    unit_price = models.DecimalField(max_digits=6, decimal_places=2)


class Cart(models.Model):
    created_at = models.DateTimeField(auto_now_add=True)


class CarItem(models.Model):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.PositiveSmallIntegerField()
```
#### Explaination
Here's a detailed explanation of the code, covering its structure, relationships, and key features:

**Models**:

**Promotion**:
- Stores details about promotions (description, discount).
- Can optionally feature a product (featured_product).
**Collection**:
- Organizes products into groups (title).
**Product**:
- Represents individual products with attributes like title, description, price, inventory, last update, and collection.
- Can have multiple promotions (promotions).
**Customer**:
- Represents customers with personal information and membership level.
**Order**:
- Represents orders with payment status, placement date, and associated customer.
**Address**:
- Stores customer addresses (street, city).
- Has a one-to-one relationship with Customer (one address per customer).

**Orderitem**:
- Represents individual items within an order, specifying product, quantity, and unit price.
**Cart**:
- Potentially used for temporary shopping cart storage (created at timestamp).
**CarItem**:
- Items within a cart, linked to a product and quantity.

**Relationships:**

**One-to-Many**:
- Collection to Product (one collection can have many products).
- Customer to Order (one customer can have many orders).
- Order to Orderitem (one order can have many order items).
- Cart to CarItem (one cart can have many items).
**Many-to-Many**:
 -Product to Promotion (many products can have many promotions).
**One-to-One**:
- Customer to Address (one customer has one primary address).

**Key Features**:

- Membership Levels: Customers have defined membership tiers (Silver, Gold, Diamond).
- Payment Statuses: Orders have distinct payment statuses (Pending, Complete, Failed).
- Inventory Tracking: Products have inventory levels.
- Last Update Tracking: Products have a last_update field.
- Product Slugs: Products have slug fields for URL generation.
- Cart Functionality: Potential for shopping cart implementation.

**Additional Notes**:

- The purpose of Address1 is unclear without further context.
- Consider clarifying the intended use of Cart and CarItem models.

## Step-19
### Create DBMS tables/models in models.py inside tags
Write code in tags 
```python
from django.db import models
from django.contrib.contenttypes.models import ContentType
from django.contrib.contenttypes.fields import GenericForeignKey
# Create your models here.
class Tag(models.Model):
    label = models.CharField(max_length=255)


class Tagitem(models.Model):
    tag = models.ForeignKey(Tag,on_delete=models.CASCADE)
    # type (product)
    # id table 
    content_type = models.ForeignKey(ContentType,on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey()
```

## Step-20
### Next step is Migrations
After write code in store and tags, open terminal and  enter this command
```bash
python manage.py makemigrations store
``` 
- Your store code is migrated.
Simillarly,
```bash
python manage.py makemigrations tags
```
- Your tags code is migrated.

## Step 21
### Then you open XAMPP
- Open storefront datebase your models is convert in to tables.
- Click any table like Customer to enter data 
- Go to import button and import Customer table

### Come into Vs code 

## Step-22
### Again Open index.html
write this code
```HTML
<!DOCTYPE html>
<html lang="en">
{% load static %}
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href='{% static "css/style.css" %}'>
    <title>Models</title>
</head>
<body>
    <div class="container bg-success opacity-50 p-4 mb-3">
    <h1 class="text-light">Welcome to Models in Django</h1>
</div>
    <div class="container">
    {% if product %}
    <table class="table table-bordered border-primary table-hover">
    <thead>
        <tr>
          <th scope="col">ID</th>
          <th scope="col">TITLE</th>
          <th scope="col">DESCRIPTION</th>
          <th scope="col">PRICE</th>
          <th scope="col">INVENTORY</th>
          <th scope="col">LAST_UPDATE</th>
        </tr>
    </thead>
    <tbody>
    {% for p in product %}
    <tr>
        <th scope="row">{{p.id}}</th>
        <td>{{p.title}}</td>
        <td>{{p.description}}</td>
        <td>{{p.price}}</td>
        <td>{{p.inventory}}</td>
        <td>{{p.collection__title}}</td>
    </tr>
    {% endfor %}
    </tbody>
    </table>
    {% else %}
    <p class="bg-danger">
        No Timing Available
    </p>
    {% endif %}
    {% if pl %}
    <div class="container">
    <div class="row alert alert-success">
    <div class="col">{{pl.id}}</div>
    <div class="col">{{pl.title}}</div>
    <div class="col">{{pl.description}}</div>
    <div class="col">{{pl.price}}</div>
    <div class="col">{{pl.inventory}}</div>
    <div class="col">{{pl.last_update}}</div>
    </div>
    </div>
    {% endif %}
    {% if pe %}
    <div class="container">
    <div class="row alert alert-danger">
    <div class="col">{{pe.id}}</div>
    <div class="col">{{pe.title}}</div>
    <div class="col">{{pe.description}}</div>
    <div class="col">{{pe.price}}</div>
    <div class="col">{{pe.inventory}}</div>
    <div class="col">{{pe.last_update}}</div>
    </div>
    </div>
    {% endif %}
</div>
</body>
</html>
```

## Step-23
### In views.py  inside store
Again write this code
```python
from django.shortcuts import render
# from django.core.exceptions import ObjectDoesNotExist
from store.models import Product
from django.db.models import Q, F
# Create your views here.


def home(request):
    query_set = Product.objects.all()
    # objects is manager that is a interface of database
    # for p in query_set:
    #     print(p)
    # product = Product.objects.get(pk=5)
    # print(product)
    # get only specific record using where clause
    # try:
    #     product = Product.objects.get(pk=0)
    # except ObjectDoesNotExist:
    #     pass

    # product = Product.objects.filter(pk=0).exists()
    # Filtering Data
    # find those dollars who have unit_price = 20
    # product = Product.objects.filter(price=20)
    # for p in product:
    #         print(p)

    # Filter using
    # keyword argument
    # query_set api
    # product = Product.objects.filter(price__gte=23.29)
    # for p in product:
    #     print(p)

    # product = Product.objects.filter(title__contains='Wine')
    # product = Product.objects.filter(inventory__lt=10,price__lt=20)
    # product = Product.objects.filter(inventory__lt=10).filter(price__lt=20)
    # Q object to make complex lookups
    # product = Product.objects.filter(Q(inventory__lt=10)& ~Q(price__lt=40))
    # We can compare related fields with F class Object
    # product = Product.objects.filter(inventory=price)
    # Sort in Ascending order
    # Order_by is a quert_set method so its return a query objects
    # product = Product.objects.filter(collection_id=5).order_by('price').reverse()
    # pl = Product.objects.latest('id')
    # pe = Product.objects.earliest('id')
    # product = Product.objects.all()[:5]
    # product = Product.objects.all()[4:10]
    product = Product.objects.values('id','title','description','price','inventory','collection__title')
    return render(request, 'index.html', {'product': product})
```

## Step-24
### Create static folder
<pre>
storefront
        |___ static
        |___ store    
        |___ storefront
        |           |___ __init__.py
        |           |___ asgi.py
        |           |___ settings.py
        |           |___ urls.py
        |           |___ wsgi.py
        |
        |___ tags
        |___ Templates
        |           |___index.html
        |___ manage.py

</pre>
- inside static folder create css folder 

- inside css folder create style.css file
<pre>
storefront
        |___ static
        |         |___ css
        |               |___ style.css
        |
        |___ store    
        |___ storefront
        |           |___ __init__.py
        |           |___ asgi.py
        |           |___ settings.py
        |           |___ urls.py
        |           |___ wsgi.py
        |
        |___ tags
        |___ Templates
        |           |___index.html
        |___ manage.py

</pre>

## Step-25
### In style.css we use boostrap cdn you can paste below link to new tab copy all css and paste your style.css file
```css
https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css
```
## Step-26
### Then Run Server
```bash
python manage.py runserver
```





