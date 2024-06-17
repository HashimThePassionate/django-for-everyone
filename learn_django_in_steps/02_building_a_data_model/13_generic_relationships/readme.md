# Generic Relationships 

<pre>
+-----------------+                 +-----------------+
|      STORE      |                 |      TAGS       |
+-----------------+                 +-----------------+
|    Product      |                 |       Tag       |
|    Collection   |                 |   TaggedItem    |
|    Customer     |                 +-----------------+
|      Cart       |
|    CartItem     |
|      Order      |
|   OrderItem     |
+-----------------+
</pre>

## Introduction
In Django, generic relationships allow us to create reusable models that can be associated with any other model. This is particularly useful for features like tagging, where you want to tag different types of items such as products, videos, or articles. We'll discuss how to set up generic relationships in Django, using the example of a tags app designed to be reusable across various projects.

## Tags App Overview
Our tags app consists of two models:
1. **Tag**: Represents an actual tag.
2. **TagItem**: Represents a tag applied to a particular item, which can be a product, video, audio, or literally anything.

### Tag Model
The `Tag` model is straightforward, consisting of a name field to store the tag's name.

```python
from django.db import models

class Tag(models.Model):
    name = models.CharField(max_length=255)
```

### TagItem Model
The `TagItem` model is where things get interesting. It needs to store:
1. The tag being applied (foreign key to the `Tag` model).
2. The object to which the tag is applied.

To identify the object to which a tag is applied, we need a generic way to reference any model. This is achieved using Django's content type system.

### Content Type System
Django's content type system provides a way to create generic relationships between models. The `ContentType` model, which comes with Django, represents the type of an object in the application.

### Setting Up Generic Relationships
1. **Import ContentType and GenericForeignKey**:
    ```python
    from django.contrib.contenttypes.fields import GenericForeignKey
    from django.contrib.contenttypes.models import ContentType
    from django.db import models
    ```

2. **Define TagItem Model**:
    ```python
    class TagItem(models.Model):
        tag = models.ForeignKey(Tag, on_delete=models.CASCADE)
        content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
        object_id = models.PositiveIntegerField()
        content_object = GenericForeignKey('content_type', 'object_id')]
    ```

### Explanation
- `tag`: Foreign key to the `Tag` model. If a tag is deleted, we want to remove it from all associated objects, hence `on_delete=models.CASCADE`.
- `content_type`: Foreign key to the `ContentType` model, representing the type of the object being tagged.
- `object_id`: Stores the primary key of the object being tagged.
- `content_object`: Generic foreign key combining `content_type` and `object_id` to create a generic relationship.

### Usage
With the generic relationship set up, you can now tag any model instance. For example, tagging a product:

```python
from store.models import Product
from tags.models import Tag, TagItem
from django.contrib.contenttypes.models import ContentType

# Create a new tag
tag = Tag.objects.create(name="New Arrival")

# Get the content type for the Product model
product_content_type = ContentType.objects.get_for_model(Product)
product_instance = Product.objects.get(id=1)
# Create a TagItem for a specific product
tag_item = TagItem.objects.create(
    tag=tag,
    content_type=product_content_type,
    object_id=product_instance.id,
)
```

## Additional Example: Likes App
Suppose you have a new app called "likes" with a model `LikeItem` to represent likes on various objects.

### LikeItem Model
```python
from django.contrib.auth.models import User
from django.contrib.contenttypes.fields import GenericForeignKey
from django.contrib.contenttypes.models import ContentType
from django.db import models

class LikeItem(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    content_type = models.ForeignKey(ContentType, on_delete=models.CASCADE)
    object_id = models.PositiveIntegerField()
    content_object = GenericForeignKey('content_type', 'object_id')
```

This model allows users to like any object in the application, providing flexibility and reusability.

## Conclusion
By using Django's content type system, we can create generic relationships between models, making our applications more modular and reusable. Whether you are creating a tags app, likes app, or any other feature that needs to interact with various models, generic relationships provide a robust solution.