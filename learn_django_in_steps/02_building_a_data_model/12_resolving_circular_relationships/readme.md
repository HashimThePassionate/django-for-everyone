# Circular Dependencies in Django Models

## Introduction
In Django, it is common to have multiple relationships between two models. For example, in our project, we have two relationships between `Collection` and `Product`. However, we have only implemented the one-to-many relationship. Implementing the other relationship can lead to a situation called a circular dependency.

## What is Circular Dependency?
A circular dependency occurs when two classes depend on each other simultaneously. In our case, the `Product` class depends on the `Collection` class, and at the same time, the `Collection` class depends on the `Product` class. This can cause issues during model definition and database migrations.

```
+----------------+   				+----------------+  
|    Product     |   				|   Collection   |
+----------------+ 		     		+----------------+ 
| title          | * ---------- 1   |     title      |
| description    | products			|                |
| price          |					|                |
| inventory      |					|                |
+----------------+-	 0--1 			+----------------+	
                    -        		                 -
						-						-
							-				-	
								-		-		
									-
					featured_product
```

## Handling Circular Dependency

### Scenario
We want to add a new feature called `featured_product` to the `Collection` class. This field will be a foreign key to the `Product` class. If a product is deleted and that product happens to be the featured product for a collection, we want to set this field to `null`. This means the field should allow null values. However, defining this directly can cause a circular dependency issue because the `Product` class is defined after the `Collection` class.

### Solution
To handle this circular dependency, we need to wrap the class reference in a string.

1. **Define `Collection` Class First:**
    ```python
    from django.db import models

    class Collection(models.Model):
        name = models.CharField(max_length=255)
        # other fields...
    ```

2. **Define `Product` Class with Foreign Key to `Collection`:**
    ```python
    class Product(models.Model):
        name = models.CharField(max_length=255)
        collection = models.ForeignKey(Collection, on_delete=models.CASCADE,related_name='products')
        # other fields...
    ```

3. **Add `featured_product` Field to `Collection` Class:**
    ```python
    class Collection(models.Model):
        name = models.CharField(max_length=255)
        featured_product = models.ForeignKey('Product', null=True,on_delete=models.SET_NULL, related_name='collections')
        # other fields...
    ```

### Potential Issues
While this solution resolves the circular dependency, it introduces a new problem. If we decide to rename the `Product` class in the future, the string reference in the `Collection` class will not automatically update, leading to errors.

### Reverse Relationship Conflict
In the `Product` class, we have a field called `collection`, representing the other end of the relationship. Django cannot create the reverse relationship because of the name clash. We have two choices to handle this:

1. **Set `related_name` to Something Other Than `collection`:**
    ```python
    collection = models.ForeignKey(Collection, on_delete=models.CASCADE, related_name='collections')
    ```

2. **Disable Reverse Relationship:**
    If you don't need the reverse relationship, you can add a `+` to the `related_name`:
    ```python
    feature_product = models.ForeignKey('Product', on_delete=models.CASCADE, related_name='+')
    ```
