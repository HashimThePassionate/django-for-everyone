# Generating a Dummy Data

How to populate your `storefront` project's database with dummy data using a tool like Mockaroo. This can be useful for testing and development purposes.

## Prerequisites

Before you begin, ensure you have the following:

- The `storefront` Django project set up with a MySQL database.
- Go to [Mockaroo](https://www.mockaroo.com/) or a similar data generation tool.
- MySQL Workbench installed on your computer.

## Steps to Populate the Database with Dummy Data

### Step 1: Generate Dummy Data using Mockaroo

1. **Go to Mockaroo:**
   Visit [Mockaroo](https://www.mockaroo.com/), one of the best tools for generating dummy data.

2. **Set Up the Data Schema:**
   - **First Name:** Add a column for `first_name` and select the `First Name` type.
   - **Last Name:** Add a column for `last_name` and select the `Last Name` type.
   - **Email:** Add a column for `email` and select the `Email Address` type.
   - **Phone:** Add a column for `phone` and select the `Phone` type.
   - **Birth Date:** Add a column for `birth_date` and select the `Date` type.
   - **Membership:** Add a column for `membership` and select the `Custom List` type. In the list values, add `B` (for Bronze), `S` (for Silver), and `G` (for Gold).
     - Alternatively, you can use a `Regular Expression` type to generate the membership values. Use the regular expression `[BSG]`.

3. **Specify the Number of Records:**
   Set the number of records to generate, e.g., `1000`.

4. **Download the Data:**
   - Change the format to `SQL` and specify the name of the table as `store_customer`.
   - Click the "Download Data" button to download the generated SQL file.

### Step 2: Import Dummy Data into the Database using MySQL Workbench

1. **Open MySQL Workbench:**
   Launch MySQL Workbench and connect to your MySQL server.

2. **Open the SQL File:**
   Go to `File > Open SQL Script...` and select the downloaded SQL file from Mockaroo.

3. **Review the SQL Statements:**
   The SQL file should contain `INSERT` statements for the `store_customer` table. Review the statements to ensure they match your database schema.

4. **Execute the SQL Script:**
   Click the lightning bolt icon (Execute) to run the SQL script. This will insert the dummy data into your `store_customer` table.

### Step 3: Verify the Data

1. **Query the Customer Table:**
   In MySQL Workbench, run the following query to count the records in the `store_customer` table:

   ```sql
   SELECT COUNT(*) FROM store_customer;
   ```

   This should return the number of records inserted, e.g., `1000`.

2. **Verify Data:**
   You can also run a `SELECT` query to verify that the data has been inserted correctly:

   ```sql
   SELECT * FROM store_customer LIMIT 10;
   ```

   This will display the first 10 records in the `store_customer` table.
