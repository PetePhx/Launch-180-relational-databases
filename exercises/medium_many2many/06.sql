Services With At Least 3 Customers

Write a query that displays the description for every service that is subscribed
to by at least 3 customers. Include the customer count for each description in
the report. The report should look like this:

 description  | count
--------------+-------
 DNS          |     3
 Unix Hosting |     5
(2 rows)

SELECT services.description,
       count(customers_services.id)
  FROM services INNER JOIN customers_services
    ON services.id = service_id
  GROUP BY services.description
  HAVING count(customers_services.id) >= 3;
