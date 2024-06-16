# Organizing Models in Apps

A Django project contains one or more apps. Just like the apps on your phone, each app in a Django project provides a specific piece of functionality. This means each app is going to have its own data model.

## Organizing Apps

There are a few different ways to organize apps in a Django project:

### Single App Approach

One way is to have a single app called `store` and place all models and functionality within it. While this method allows anyone to install the app and get all models and functionality, it has its drawbacks:

- **Monolithic Design**: This approach can lead to a monolithic structure, making the application hard to understand, maintain, and use. It becomes like a remote control with too many buttons.
<pre>
      +-----------------+
      |      STORE      |
      +-----------------+
      |    Product      |
      |    Collection   |
      |    Cart         |
      |    CartItem     |
      |    Order        |
      |    OrderItem    |
      |    Customer     |
      +-----------------+
</pre>

### Unix Philosophy

When designing apps, follow the Unix philosophy: each app should do one thing and do it well. 

### Multiple Apps Approach

A better solution is to break down the project into smaller, focused apps:

1. **Products App**: Manages products.
2. **Customers App**: Manages customers.
3. **Shopping Cart App**: Adds shopping cart functionality.
4. **Orders App**: Manages orders.

By organizing apps this way, each app is self-contained, making it easy to drop into a new project. However, this approach also has potential issues:

- **Dependency Management**: If a new version of the products app is released, it might cause breaking changes in the shopping cart and orders apps. Users have to upgrade all these apps together.

<pre>
      +-----------------+         +-----------------+         +-----------------+         +-----------------+
      |    PRODUCTS     |         |    CUSTOMERS    |         |      CARTS      |         |     ORDERS      |
      +-----------------+         +-----------------+         +-----------------+         +-----------------+
      |    Product      |         |    Customer     |         |      Cart       |         |      Order      |
      |    Collection   |         |                 |         |    CartItem     |         |   OrderItem     |
      |      Tag        |         |                 |         |                 |         |                 |
      +-----------------+         +-----------------+         +-----------------+         +-----------------+
</pre>

### Balanced Approach

The ideal approach balances between monolithic and highly fragmented structures. For example, the `tags` app is optional and has zero coupling with other apps, allowing independent changes and deployments.

## Key Takeaways

1. **Large Boundaries**: Large boundaries result in a bloated monolithic structure that's hard to reuse.
2. **Small Boundaries**: Small, fine-grained boundaries result in high coupling between apps.

A good design has minimal coupling and high cohesion, meaning each app includes everything needed for its functionality.

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

## Next Steps

In the next lesson, we will create the model classes for these apps.
