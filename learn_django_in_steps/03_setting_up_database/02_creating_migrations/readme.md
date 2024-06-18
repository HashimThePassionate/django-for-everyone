## Creating Migrations in MYSQL

### Introduction

This guide covers setting up MySQL for a Django project, configuring the database in `settings.py`, and understanding Django migrations.

## Setting Up MySQL

1. **Install MySQL**: Make sure MySQL is installed on your system.
2. **Open MySQL Workbench**: Create a new database named `store`.
3. In our case password is root and username is root
   - **Username**: root
   - **Password**: root
4. Make sure you have mysqlclient for connecting mysql with django if not then install
```python
    pipenv install mysqlclient
```

## Configuring Django to Use MySQL

Edit your `settings.py` file to include the following database configurations:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'store',
        'USER': 'root',
        'PASSWORD': 'root',
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```

## Migrations in Django

Django uses migrations to create or update database tables based on the models defined in your project. With Django, you do not need to manually create or modify database tables; Django handles it for you. Here's how it works:

1. **Creating Migrations**: 
   - Run `python manage.py makemigrations` to create migration files. Each migration file has a sequence number.

2. **Running Migrations**: 
   - Run `python manage.py migrate` to apply migrations and update the database schema.

3. **Understanding Migration Files**:
   - Migration files are Python modules with a sequence number and a series of operations.
   - Example operation: Creating a model with fields.

4. **Example Migration File**:
   ```python
   from django.db import migrations, models

   class Migration(migrations.Migration):

       initial = True

       dependencies = [
       ]

       operations = [
           migrations.CreateModel(
               name='Cart',
               fields=[
                   ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                   # other fields...
               ],
           ),
       ]
   ```

5. **Renaming Fields**:
   - To rename a field in a model, create a new migration.
   - Example: Renaming `price` to `unit_price` in the `Product` model.

6. **Adding New Fields**:
   - To add a new field, update the model and run `makemigrations`.
   - Example: Adding a `slug` field to the `Product` model.
