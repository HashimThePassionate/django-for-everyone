# Support Database Engines

Django supports a variety of database management systems. By default, Django is set up with SQLite, which is a lightweight and basic database engine. While SQLite is suitable for development or low-traffic websites, it is not recommended for serious projects.

For more robust and scalable applications, you should consider using one of the following officially supported databases:
- **PostgreSQL**
- **MySQL**
- **MariaDB**
- **Oracle Database**

There are also numerous third-party libraries available for other database management systems, allowing for even greater flexibility.

We will setup mysql as a default database, but we will not cover any mysql fancy feature, all magic happens with Django ORM 