Deleting Rows

Write the necessary SQL statements to delete the "Bulk Email" service and
customer "Chen Ke-Hua" from the database.

First we delete the records from the join table, and then from each individual
table:

DELETE FROM customers_services
  WHERE service_id = 7
    OR customer_id = 4;

DELETE FROM customers
  WHERE id = 4;

DELETE FROM services
  WHERE id = 7;
