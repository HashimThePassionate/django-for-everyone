# Importing Dummy Data into MySQL Workbench

## Introduction

This guide will help you import dummy data into MySQL Workbench using the `data.sql` file. Follow the steps below to complete the process.

## Steps to Import Data

1. **Locate the SQL File**
   - Find the `sql` folder in your project directory.
   - Inside the `sql` folder, locate the `data.sql` file.

2. **Open MySQL Workbench**
   - Launch MySQL Workbench on your computer.

3. **Access Data Import**
   - Click on the `Administration` tab in the MySQL Workbench.
   - Under the `Management` section, click on `Data Import/Restore`.

4. **Import Data**
   - In the `Data Import/Restore` window, select `Import from Disk`.
   - Choose `Import from Self-Contained File`.
   - Click on the `...` button and navigate to the location of the `data.sql` file.
   - Select the `data.sql` file and confirm.

5. **Start Importing**
   - Click on the `Start Import` button to begin the import process.
   - Wait for the import process to complete successfully.

6. **Verify Import**
   - Once the import is complete, go to the SQL editor.
   - Run the following query to select the data from the `store_product` table:
     ```sql
     SELECT * FROM store_product;
     ```

## Conclusion

You have successfully imported the dummy data into your MySQL database using MySQL Workbench. You can now work with the `store_product` table and the data it contains.
