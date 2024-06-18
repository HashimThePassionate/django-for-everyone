# Custom SQL in Migrations

## Creating an Empty Migration

### Step 1: Create an Empty Migration

First, create an empty migration for the `store` app. In the terminal, run the following command:

```sh
python manage.py makemigrations store --empty --name new
```

This command creates an empty migration file named `0006_new.py` in the `store/migrations` directory.

### Step 2: Edit the Migration File

Open the newly created migration file (`store/migrations/0006_new.py`) in a text editor. The file will look like this:

```python
from django.db import migrations

class Migration(migrations.Migration):

    dependencies = [
        ('store', '0004_XXX.py'),
    ]

    operations = [
    ]
```

### Step 3: Add Custom SQL Statements

You can add custom SQL statements for upgrading and downgrading the database schema using the `migrations.RunSQL` operation. Here is an example where we insert a new record into the `collection` table:

```python
from django.db import migrations

class Migration(migrations.Migration):

    dependencies = [
        ('store', 'previous_migration_file'),
    ]

    operations = [
        migrations.RunSQL(
            """
            INSERT INTO store_collection (title)
            VALUES ('Collection 1');
            """,
            """
            DELETE FROM store_collection
            WHERE title = 'Collection 1';
            """
        ),
    ]
```

- The first triple-quoted string is the SQL statement for upgrading the database.
- The second triple-quoted string is the SQL statement for downgrading the database.

### Step 4: Apply the Migration

Save the changes to the migration file. Back in the terminal, apply the migration by running:

```sh
python manage.py migrate store
```

This command applies the migration, executing the custom SQL statement to insert the new record into the `collection` table.

### Step 5: Verify the Changes

To verify that the changes have been applied, you can use your database management tool to check the `collection` table. The new record should be present.

