
# Quiz Time

## Quiz: Selecting Ordered Products

Now, let's write a query to select products that have been ordered and sort them by the time they were ordered.

1. **Step 1: Import the Necessary Model**

   What model do you need to import to begin querying for ordered products?

   a) Product  
   b) Order  
   c) OrderItem  
   d) Collection

2. **Step 2: Select Product IDs**

   How do you select all the product IDs from the `_______` table?

   a) product_name  
   b) product_id  
   c) id  
   d) order_id

3. **Step 3: Remove Duplicates**

   Which method do you use to remove duplicates from the list of product IDs?

   a) filter  
   b) distinct  
   c) unique  
   d) remove_duplicates

4. **Step 4: Filter Products**

   How do you filter products whose IDs are in the list of ordered product IDs?

   a) ordered_product_ids  
   b) products  
   c) order_items  
   d) product_list

5. **Step 5: Sort by Order Time**

   How do you sort the filtered products by the time they were ordered? Assume `OrderItem` has a field `ordered_at`.

   a) product__ordered_at  
   b) order__ordered_at  
   c) orderitem__ordered_at  
   d) product_ordered_at
