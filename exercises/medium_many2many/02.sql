Get Customers With Services

Write a query to retrieve the customer data for every customer who currently
subscribes to at least one service.

SELECT customers.name, customers.payment_token
  FROM customers INNER JOIN customers_services
    ON customers.id = customers_services.customer_id
  GROUP BY customers.name, customers.payment_token;

   name     | payment_token
-------------+---------------
Scott Lakso | UUEAPQPS
Chen Ke-Hua | KWETYCVX
Pat Johnson | XHGOAHEQ
Jim Pornot  | XKJEYAZA
Lynn Blake  | KLZXWEEE
(5 rows)

-- Or more succinctly using DISTINCT instead of GROUP BY:

SELECT DISTINCT customers.name, customers.payment_token
  FROM customers INNER JOIN customers_services
    ON customers.id = customer_id;
