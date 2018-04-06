Total Gross Income

Assuming that everybody in our database has a bill coming due, and that all of
them will pay on time, write a query to compute the total gross income we expect
to receive.

  gross
--------
678.50
(1 row)


SELECT sum(services.price) AS "gross"
  FROM services INNER JOIN customers_services
    ON services.id = service_id;
