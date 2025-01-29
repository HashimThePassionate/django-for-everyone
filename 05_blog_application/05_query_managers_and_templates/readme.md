# **Working with QuerySets and Managers** 🛠️✨

Now that we have a fully functional administration site to manage blog posts, it's time to learn how to **read and write content to the database programmatically**. Django provides an **Object-Relational Mapper (ORM)** that allows seamless interaction with the database using Python. ✨

---

## What is Django ORM? 🗄️
- A **powerful database abstraction API** that enables creating, retrieving, updating, and deleting objects easily.
- Converts Python **object-oriented code** into SQL queries.
- Allows interaction with the database in a **Pythonic way** instead of writing raw SQL.
- Supports multiple databases, including:
  - ✅ **MySQL**
  - ✅ **PostgreSQL**
  - ✅ **SQLite**
  - ✅ **Oracle**
  - ✅ **MariaDB**

### Defining the Database 🎯
- You can configure the database settings in the `DATABASES` setting inside `settings.py`.
- Django supports **multiple databases** and allows the use of **database routers** for custom data routing schemes.

For more details, refer to Django’s [Model API Reference](https://docs.djangoproject.com/en/5.0/ref/models/). 📖

---

## Understanding QuerySets 🔍
A **QuerySet** is a collection of **database queries** used to retrieve objects from the database. Key characteristics:
- **QuerySets map directly to SQL SELECT statements**.
- **Filters can be applied** to refine the results, similar to SQL `WHERE` and `LIMIT` clauses.
- **Lazy evaluation**: QuerySets are only executed when their values are needed.


<div align="center">

# `New Section Creating Objects with Django ORM`

</div>

# **Creating Objects with Django ORM** 🛠️✨

Creating and managing objects in Django's ORM is straightforward. In this section, you will learn how to create objects and persist them to the database programmatically. ✨✨✨

---

## Step 1: Open the Python Shell
Run the following command in your shell prompt:
```bash
python manage.py shell
```

This opens an interactive Python shell connected to your Django project.

---

## Step 2: Create a `Post` Object
### Example Code:
```python
>>> from django.contrib.auth.models import User
>>> from blog.models import Post
>>> user = User.objects.get(username='admin')
>>> post = Post(title='Another post',
...             slug='another-post',
...             body='Post body.',
...             author=user)
>>> post.save()
```

### Detailed Explanation:
1. **Retrieve a User Object**:
   ```python
   user = User.objects.get(username='admin')
   ```
   - **What it does**:
     - Retrieves the user object with the username `admin`.
     - Executes a `SELECT` SQL query behind the scenes.
   - **Possible Exceptions**:
     - **`DoesNotExist`**: Raised if no matching object is found.
     - **`MultipleObjectsReturned`**: Raised if multiple objects match the query.

2. **Create a `Post` Instance**:
   ```python
   post = Post(title='Another post', slug='another-post', body='Post body.', author=user)
   ```
   - **What it does**:
     - Creates a `Post` object in memory with the provided attributes (`title`, `slug`, `body`, and `author`).
     - This object is **not yet saved** to the database.

3. **Save the Object to the Database**:
   ```python
   post.save()
   ```
   - **What it does**:
     - Persists the object to the database.
     - Executes an `INSERT` SQL query behind the scenes.

---

## Step 3: Use the `create()` Method
You can create and persist an object to the database in a single step using the `create()` method:
```python
>>> Post.objects.create(title='One more post',
...                     slug='one-more-post',
...                     body='Post body.',
...                     author=user)
```

### Benefits of `create()`:
- Combines object creation and database persistence into one operation.
- Automatically calls the `save()` method internally.

---

## Step 4: Use the `get_or_create()` Method
In scenarios where you need to **fetch an object from the database or create it if it doesn’t exist**, use the `get_or_create()` method.

### Example Code:
```python
>>> user, created = User.objects.get_or_create(username='user2')
```

### Detailed Explanation:
- **What it does**:
  - Attempts to retrieve a `User` object with the username `user2`.
  - If no object is found, it creates a new one.
- **Return Value**:
  - A tuple containing:
    1. The retrieved or created object.
    2. A Boolean indicating whether a new object was created.

### Example Output:
```python
(<User: user2>, True)
```
- **`True`**: Indicates that a new object was created.
- **`False`**: Indicates that an existing object was retrieved.

---

<div align="center">

# `New Section Updating Objects`

</div>

# **Updating Objects** 🔄✨

Once you have created objects in Django's ORM, you can modify their attributes and update them in the database. In this section, we will learn how to **update objects and persist changes**. ✨✨✨

---

## Updating an Existing `Post` Object 📝

### Example Code:
```python
>>> post.title = 'New title'  # Modify the title
>>> post.save()  # Save the changes
```

### Explanation:
1. **Modify an Attribute**:
   ```python
   post.title = 'New title'
   ```
   - This updates the `title` attribute **in memory** but **does not persist the change to the database** yet.

2. **Persist Changes with `save()`**:
   ```python
   post.save()
   ```
   - This method triggers an **UPDATE SQL statement** behind the scenes.
   - Only after calling `save()`, the changes are stored in the database.

---

## Important Notes 🛠️
- Changes made to a model object are **not automatically saved** to the database.
- You **must call** the `save()` method to persist modifications.
- The **`save()` method determines** whether to run an `INSERT` (for new objects) or an `UPDATE` (for existing objects).

<div align="center">

# `New Section Retrieving Objects from the Database`

</div>


# **Retrieving Objects from the Database** 🛠️✨

Django provides multiple ways to retrieve objects from the database using its powerful ORM. In this section, we will explore how to retrieve objects efficiently. ✨✨✨

---

## Retrieving a Single Object 🔍
- Use the **`get()`** method to retrieve a single object from the database.
- Example:
  ```python
  >>> post = Post.objects.get(id=1)  # Retrieve the post with ID 1
  ```
- **Key Points**:
  - Executes a `SELECT` SQL query behind the scenes.
  - Raises the following exceptions:
    - **`DoesNotExist`**: If no matching object is found.
    - **`MultipleObjectsReturned`**: If multiple matching objects are found.

### Filtering for a Specific Record:
To retrieve a single record using a filter condition:
```python
>>> post = Post.objects.get(slug='another-post')  # Retrieve the post with the slug 'another-post'
```

- **Common Usage**:
  - Use unique fields like `id`, `slug`, or any other field guaranteed to have unique values.

---

## Retrieving All Objects 📋
- Use the **`all()`** method to retrieve all objects from a table.
- Example:
  ```python
  >>> all_posts = Post.objects.all()
  ```

### Detailed Explanation:
1. **QuerySet Creation**:
   - `Post.objects.all()` returns a **QuerySet** that contains all objects in the database.
   - **QuerySets are lazy**: They are not executed until needed.

2. **Efficiency**:
   - QuerySets don’t execute the SQL statement immediately.
   - If you assign the QuerySet to a variable (e.g., `all_posts`), no SQL is executed yet.
   - QuerySets are only evaluated when forced (e.g., by iterating over them or printing their output).

3. **Forcing QuerySet Evaluation**:
   - If you don’t assign the QuerySet to a variable and write it directly in the shell, the SQL statement is executed:
     ```python
     >>> Post.objects.all()
     <QuerySet [<Post: Muhammad Hashim>, <Post: Django For Everyone>, <Post: 'Another post>, <Post: Python Deep Dive>]>
     ```
   - In this example, the QuerySet retrieves and prints all `Post` objects from the database.

---

## Summary 🌟
- **`get()`**: Retrieves a single object. Use unique fields for filtering (e.g., `id`, `slug`). Raises exceptions if no match or multiple matches are found.
- **`all()`**: Retrieves all objects in the database.
- **Lazy Evaluation**: QuerySets are only executed when their data is needed, ensuring efficiency.

<div align="center">

# `New Section Filtering Objects in Django ORM`

</div>

# **Filtering Objects in Django ORM** 🔍✨

Filtering objects in Django ORM is an essential operation that allows you to retrieve specific records from the database based on conditions. The `filter()` method provides an efficient way to apply **SQL WHERE clauses** using Django’s **field lookups**. ✨✨✨

---

## Using the `filter()` Method 📋
- The `filter()` method is used to **retrieve a subset of objects** that match certain conditions.
- Example: Filtering `Post` objects by **title**:
  ```python
  >>> Post.objects.filter(title='Python Deep Dive')
  ```
  - This QuerySet returns all `Post` objects **where the title is exactly** 'Python Deep Dive'.
  - The result is a QuerySet containing the matching records.

---

## Viewing the SQL Query Generated 🛠️
To inspect the SQL statement executed by Django ORM, use the `query` attribute:
```python
>>> posts = Post.objects.filter(title='Python Deep Dive?')
>>> print(posts.query)
```
### Expected SQL Output:
```sql
SELECT "blog_post"."id", "blog_post"."title", "blog_post"."slug", "blog_post"."author_id", "blog_post"."body", "blog_post"."publish", "blog_post"."created", "blog_post"."updated", "blog_post"."status" FROM "blog_post" WHERE "blog_post"."title" = Python Deep Dive ORDER BY "blog_post"."publish" DESC
```

### Explanation:
1. **WHERE Clause**:
   - The `WHERE` condition ensures that only posts with a title **exactly matching** 'Who was Django Reinhardt?' are retrieved.

2. **ORDER BY Clause**:
   - Since we haven't specified an explicit ordering, Django applies the default sorting **defined in the `ordering` attribute** of the `Meta` class in the `Post` model.

---

## Important Notes 📝
- **QuerySets are lazy**:
  - The `filter()` method **does not immediately execute the query**.
  - It only runs the SQL query when the QuerySet is **iterated over, printed, or explicitly evaluated**.

- **QuerySet API**:
  - The `.query` attribute is a helpful debugging tool but is **not part of Django’s public API**.
  - Use it only for inspecting the raw SQL generated.

---

## Summary 🌟
- **`filter()`**: Retrieves objects matching specified conditions.
- **SQL Inspection**: Use `.query` to see the generated SQL.
- **Lazy Evaluation**: QuerySets execute SQL **only when needed**, improving efficiency.

<div align="center">

# `New Section Starts here`

</div>