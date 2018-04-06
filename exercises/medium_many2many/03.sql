Get Customers With No Services

Write a query to retrieve the customer data for every customer who does not
currently subscribe to any services.

SELECT customers.name, customers.payment_token
  FROM customers LEFT JOIN customers_services
    ON customers.id = customer_id
  WHERE service_id IS NULL;


    name      | payment_token
---------------+---------------
Nancy Monreal | JKWQPJKL
(1 row)


-- Further Exploration

Can you write a query that displays all customers with no services and all
services that currently don''t have any customers? The output should look like
this:

 id |     name      | payment_token | id |     description     | price
----+---------------+---------------+----+---------------------+--------
  2 | Nancy Monreal | JKWQPJKL      |    |                     |
    |               |               |  8 | One-to-one Training | 999.00
(2 rows)

Hint: read the documentation for the JOIN clause in the SELECT statement.

SELECT DISTINCT customers.*, services.*
  FROM customers FULL OUTER JOIN customers_services
    ON customers.id = customer_id
  FULL OUTER JOIN services
    ON service_id = services.id
  WHERE customers.id IS NULL
    OR services.id IS NULL
  ORDER BY customers.id, services.id;

id |     name      | payment_token | id |     description     | price
----+---------------+---------------+----+---------------------+--------
 2 | Nancy Monreal | JKWQPJKL      |    |                     |
   |               |               |  8 | One-to-one Training | 999.00
(2 rows)

-- Or more simply:

SELECT DISTINCT customers.*, services.*
  FROM customers FULL OUTER JOIN customers_services
    ON customers.id = customer_id
    FULL OUTER JOIN services
    ON service_id = services.id
  WHERE customers_services.id IS NULL;
