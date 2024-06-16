# Building a Data Model for an E-commerce Application

## Introduction

The first step in every Django project is figuring out the pieces of data we want to store. In an e-commerce application, we need to define entities or concepts and their attributes.

### Entities and Attributes

1. **Product**
   - **Attributes**: title, description, price, inventory
   - **Description**: Represents an item available for sale in the e-commerce application.

2. **Category (Collection)**
   - **Attributes**: title
   - **Description**: Represents different groups or types of products, such as shoes, beauty products, fruits, etc.

### Relationships

1. **One-to-Many Relationship**
   - **Description**: A product belongs to one and only one collection, but a collection can have multiple products.
   - **Representation**: One collection to many products.

2. **Optional Relationship**
   - **Description**: A collection can optionally have a featured product, which is the product whose picture we want to show to the user.
   - **Representation**: Zero to one relationship between collection and featured product.

### Diagram

Below is a graphical representation of the data model using CLI-style ASCII art:

<pre>
+--------------------+         1       *       +-------------------+
|   Collection       |------------------------>|    Product        |
|--------------------|                         |-------------------|
| - title            |                         | - title           |
| - featured_product |                         | - description     |
+--------------------+                         | - price           |
                                               | - inventory       |
                                               | - collection      |
                                               +-------------------+

                                 0..1
Collection --(featured_product)-----------------> Product
</pre>

### Explanation

- **Product**
  - The `Product` entity has attributes: title, description, price, and inventory.
  - Products are categorized into collections.

- **Category (Collection)**
  - The `Collection` entity has an attribute: title.
  - A collection can contain multiple products.
  - Each collection can optionally have a featured product.

### Example Code in Django

### Summary

- **ID Attribute**: Django automatically creates an ID attribute for each model, so it's not explicitly defined in the diagram.
- **Exercise**: Identify other essential entities needed in an e-commerce application. Aim for a minimum of five entities and their relationships.
