# Advanced Data Modeling for an E-commerce Application

## Introduction

In this lesson, we explore more complex relationships in our Django models. Building on the previous lesson where we had a one-to-many relationship between collections and products, we now look at many-to-many relationships and relationships with additional attributes.

### Entities and Relationships

1. **Product**
   - **Attributes**: title, description, price, inventory
   - **Description**: Represents an item available for sale in the e-commerce application.

2. **Category (Collection)**
   - **Attributes**: title
   - **Description**: Represents different groups or types of products, such as shoes, beauty products, fruits, etc.

### Relationships

1. **Many-to-Many Relationship**
   - **Description**: A product can belong to many collections, and a collection can have multiple products.
   - **Representation**: Many collections to many products.

2. **Relationships with Additional Attributes**
   - **Description**: For example, if a product is in a shopping cart, we need to know how many instances of the product are in the cart.
   - **Entities**: Cart, CartItem

3. **Customer and Orders Relationship**
   - **Description**: A customer can have many orders, and each order belongs to one customer.
   - **Entities**: Customer, Order

4. **Order Items Relationship**
   - **Description**: Each order item belongs to one order and references one product, but a product can be referenced by multiple order items.
   - **Entities**: Order, OrderItem, Product

### Diagram

Below is a graphical representation of the data model using CLI-style ASCII art:

```text
+-----------------+         *       *       +----------------+
|   Collection    |------------------------>|    Product     |
|-----------------|                         |----------------|
| - title         |                         | - title        |
+-----------------+                         | - description  |
                                            | - price        |
                                            | - inventory    |
                                            +----------------+

+-----------------+        1       *        +----------------+
|     Cart        |------------------------>|   CartItem     |
|-----------------|                         |----------------|
| - id            |                         | - quantity     |
+-----------------+                         | - product      |
                                            +----------------+
                                                    |
                                                    |
                                                    v
                                            +----------------+
                                            |    Product     |
                                            |----------------|
                                            | - title        |
                                            | - description  |
                                            | - price        |
                                            | - inventory    |
                                            +----------------+

+-----------------+        1       *        +----------------+
|   Customer      |------------------------>|     Order      |
|-----------------|                         |----------------|
| - name          |                         | - order_date   |
| - email         |                         +----------------+
+-----------------+

+-----------------+        1       *        +----------------+
|     Order       |------------------------>|   OrderItem    |
|-----------------|                         |----------------|
| - id            |                         | - quantity     |
+-----------------+                         | - product      |
                                            +----------------+
                                                    |
                                                    |
                                                    v
                                            +----------------+
                                            |    Product     |
                                            |----------------|
                                            | - title        |
                                            | - description  |
                                            | - price        |
                                            | - inventory    |
                                            +----------------+
```


