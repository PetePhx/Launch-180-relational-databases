Services for each Customer

Write a query to display a list of all customer names together with a comma-
separated list of the services they use. Your output should look like this:

     name      |                                services
---------------+-------------------------------------------------------------------------
 Pat Johnson   | Unix Hosting, DNS, Whois Registration
 Nancy Monreal |
 Lynn Blake    | DNS, Whois Registration, High Bandwidth, Business Support, Unix Hosting
 Chen Ke-Hua   | High Bandwidth, Unix Hosting
 Scott Lakso   | DNS, Dedicated Hosting, Unix Hosting
 Jim Pornot    | Unix Hosting, Dedicated Hosting, Bulk Email
(6 rows)


SELECT customers.name,
       string_agg(services.description, ', ') AS "services"
  FROM customers LEFT JOIN customers_services
    ON customers.id = customer_id
    LEFT JOIN services
    ON service_id = services.id
  GROUP BY customers.name;

    name      |                                services
---------------+-------------------------------------------------------------------------
Chen Ke-Hua   | Unix Hosting, High Bandwidth
Jim Pornot    | Unix Hosting, Dedicated Hosting, Bulk Email
Pat Johnson   | Unix Hosting, DNS, Whois Registration
Lynn Blake    | Unix Hosting, DNS, Whois Registration, High Bandwidth, Business Support
Scott Lakso   | Unix Hosting, DNS, Dedicated Hosting
Nancy Monreal |
(6 rows)


-- Further Exploration

Can you modify the above command so the output looks like this?

     name      |    description
---------------+--------------------
 Chen Ke-Hua   | High Bandwidth
               | Unix Hosting
 Jim Pornot    | Dedicated Hosting
               | Unix Hosting
               | Bulk Email
 Lynn Blake    | Whois Registration
               | High Bandwidth
               | Business Support
               | DNS
               | Unix Hosting
 Nancy Monreal |
 Pat Johnson   | Whois Registration
               | DNS
               | Unix Hosting
 Scott Lakso   | DNS
               | Dedicated Hosting
               | Unix Hosting
(17 rows)

This won''t be easy! Hint: you will need to use the window lag function together
with a CASE condition in your SELECT. To get you started, try this command:

SELECT customers.name,
       lag(customers.name)
         OVER (ORDER BY customers.name)
         AS previous,
       services.description
FROM customers
LEFT OUTER JOIN customers_services
             ON customer_id = customers.id
LEFT OUTER JOIN services
             ON services.id = service_id;

Examine the relationship between the previous column and the rest of the table
to get a handle on what lag does.

    name      |   previous    |    description
---------------+---------------+--------------------
Chen Ke-Hua   |               | High Bandwidth
Chen Ke-Hua   | Chen Ke-Hua   | Unix Hosting
Jim Pornot    | Chen Ke-Hua   | Dedicated Hosting
Jim Pornot    | Jim Pornot    | Unix Hosting
Jim Pornot    | Jim Pornot    | Bulk Email
Lynn Blake    | Jim Pornot    | Whois Registration
Lynn Blake    | Lynn Blake    | High Bandwidth
Lynn Blake    | Lynn Blake    | Business Support
Lynn Blake    | Lynn Blake    | DNS
Lynn Blake    | Lynn Blake    | Unix Hosting
Nancy Monreal | Lynn Blake    |
Pat Johnson   | Nancy Monreal | Whois Registration
Pat Johnson   | Pat Johnson   | DNS
Pat Johnson   | Pat Johnson   | Unix Hosting
Scott Lakso   | Pat Johnson   | DNS
Scott Lakso   | Scott Lakso   | Dedicated Hosting
Scott Lakso   | Scott Lakso   | Unix Hosting
(17 rows)


SELECT CASE
       WHEN customers.name = lag(customers.name)
                 OVER (ORDER BY customers.name)
       THEN ''
       ELSE customers.name
       END,
       services.description
  FROM customers
    LEFT OUTER JOIN customers_services
      ON customers.id = customer_id
    LEFT OUTER JOIN services
      ON service_id = services.id;

    name      |    description
---------------+--------------------
Chen Ke-Hua   | High Bandwidth
              | Unix Hosting
Jim Pornot    | Dedicated Hosting
              | Unix Hosting
              | Bulk Email
Lynn Blake    | Whois Registration
              | High Bandwidth
              | Business Support
              | DNS
              | Unix Hosting
Nancy Monreal |
Pat Johnson   | Whois Registration
              | DNS
              | Unix Hosting
Scott Lakso   | DNS
              | Dedicated Hosting
              | Unix Hosting
(17 rows)
