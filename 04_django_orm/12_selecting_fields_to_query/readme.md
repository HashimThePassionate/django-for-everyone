# Selected fields to query

## Querying the Database

In this project, we often need to query the database to fetch specific data. Here's a simple guide on how to perform these queries and what each part means.

### Fetching Specific Fields

When you fetch data from the database, by default, Django retrieves all fields of an object. But sometimes, you only need a subset of these fields. For example, let's look at our `Product` table which has many fields. Some fields, like `description`, contain a lot of text. If you're not interested in these fields, you can optimize your query to fetch only what you need.

### Example: Fetching Specific Fields

Suppose you only care about the `title` of the `Product` and the `title` of the related `Collection`. You can do this as follows:

```python
products = Product.objects.values('id', 'title', 'collection__title')
```

In this example:
- `Product` is the model.
- `values` is a method that returns dictionaries.
- `'id'`, `'title'`, and `'collection__title'` are the fields we are interested in.

This query performs an inner join between the `Product` and `Collection` tables because we are accessing a related field (`collection__title`).

### Using `values_list`

If you prefer to get tuples instead of dictionaries, you can use `values_list`:

```python
products = Product.objects.values_list('id', 'title', 'collection__title')
```

With `values_list`, you get a list of tuples. Each tuple contains the values for the specified fields in the order they are listed.

