1. Make sure you are connected to the encyclopedia database. Write a query to
retrieve the population of the USA.

encyclopedia=# SELECT population FROM countries WHERE name = 'USA';

  population
  ------------
  325365189
  (1 row)

2. Write a query to return the population and the capital (with the columns in
that order) of all the countries in the table.

encyclopedia=# SELECT population, capital FROM countries;
 population |     capital
------------+-----------------
   67158000 | Paris
  325365189 | Washington D.C.
   82349400 | Berlin
  126672000 | Tokyo
(4 rows)

3. Write a query to return the names of all the countries ordered alphabetically.

encyclopedia=# SELECT name FROM countries ORDER BY name ASC;

  name
---------
 France
 Germany
 Japan
 USA
(4 rows)

4. Write a query to return the names and the capitals of all the countries in
order of population, from lowest to highest.

encyclopedia=# SELECT name, capital FROM countries ORDER BY population ASC;
  name   |     capital
---------+-----------------
 France  | Paris
 Germany | Berlin
 Japan   | Tokyo
 USA     | Washington D.C.
(4 rows)

5. Write a query to return the same information as the previous query, but
ordered from highest to lowest.

encyclopedia=# SELECT name, capital FROM countries ORDER BY population DESC;
  name   |     capital
---------+-----------------
 USA     | Washington D.C.
 Japan   | Tokyo
 Germany | Berlin
 France  | Paris
(4 rows)

6. Write a query on the animals table, using ORDER BY, that will return the
following output:

       name       |      binomial_name       | max_weight_kg | max_age_years
------------------+--------------------------+---------------+---------------
 Peregrine Falcon | Falco Peregrinus         |        1.5000 |            15
 Pigeon           | Columbidae Columbiformes |        2.0000 |            15
 Dove             | Columbidae Columbiformes |        2.0000 |            15
 Golden Eagle     | Aquila Chrysaetos        |        6.3500 |            24
 Kakapo           | Strigops habroptila      |        4.0000 |            60
(5 rows)

Use only the columns that can be seen in the above output for ordering purposes.

encyclopedia=# SELECT name, binomial_name, max_weight_kg, max_age_years
               FROM animals
               ORDER BY max_age_years, max_weight_kg, name DESC;

7. Write a query that returns the names of all the countries with a population
greater than 70 million.

encyclopedia=# SELECT name FROM countries WHERE (population > 70000000);
  name
---------
 USA
 Germany
 Japan
(3 rows)

  Could also just use WHERE (population > 70E6)

8. Write a query that returns the names of all the countries with a population
greater than 70 million but less than 200 million.

encyclopedia-# SELECT name FROM countries
               WHERE (population > 70E6 AND population < 200E6);

   name
 ---------
  Germany
  Japan
 (2 rows)

9. Write a query that will return the first name and last name of all entires in
the celebrities table where the value of the deceased column is not true.

encyclopedia=# SELECT first_name, last_name FROM celebrities
WHERE deceased <> true OR deceased IS NULL;
 first_name |  last_name
------------+-------------
 Bryce      | Sprengstine
 Crimson    | Josephson
 Phrank     | Cinatra
 Tomme      | Kruze
 Elvis      | Presley
(5 rows)

10. Write a query that will return the first and last names of all the
celebrities who sing.

encyclopedia=# SELECT first_name, last_name FROM celebrities
               WHERE occupation LIKE '%singer%';

 first_name |  last_name
------------+-------------
 Bryce      | Sprengstine
 Phrank     | Cinatra
(2 rows)

11. Write a query that will return the first and last names of all the
celebrities who act.

encyclopedia=# SELECT first_name, last_name FROM celebrities
               WHERE occupation LIKE '%act%';

 first_name | last_name
------------+-----------
 Crimson    | Josephson
 Phrank     | Cinatra
 Tomme      | Kruze
 Elvis      | Presley
(4 rows)

12. Write a query that will return the first and last names of all the
celebrities who both sing and act.

encyclopedia=# SELECT first_name, last_name FROM celebrities
WHERE (occupation LIKE '%singer%') AND
(occupation LIKE '%actor%' OR occupation LIKE '%actress%');

 first_name | last_name
------------+-----------
 Phrank     | Cinatra
(1 row)

13. Connect to the ls_burger database. Write a query that lists all of the
burgers that have been ordered, from cheapest to most expensive, where the cost
of the burger is less than $5.00.


SELECT burger FROM orders WHERE burger_cost < 5.00 ORDER BY burger_cost;

    burger
-------------------
LS Burger
LS Cheeseburger
LS Chicken Burger
(3 rows)

14. Write a query to return the customer name and email address and loyalty
points from any order worth 20 or more loyalty points. List the results from the
highest number of points to the lowest.


  SELECT customer_name, customer_email, customer_loyalty_points FROM orders
  WHERE customer_loyalty_points > 20 ORDER BY customer_loyalty_points DESC;

  customer_name  |     customer_email      | customer_loyalty_points
  ----------------+-------------------------+-------------------------
  Natasha O'Shea | natasha@osheafamily.com |                      42
  James Bergman  | james1998@email.com     |                      28
  (2 rows)


15. Write a query that returns all the burgers ordered by Natasha O'Shea.

SELECT burger FROM orders WHERE customer_name = 'Natasha O''Shea';

      burger
------------------
 LS Cheeseburger
 LS Deluxe Burger
(2 rows)


16. Write a query that returns the customer name from any order which does not
include a drink item.

SELECT customer_name FROM orders WHERE drink IS NOT NULL;

customer_name
----------------
James Bergman
Natasha O'Shea
(2 rows)

17. Write a query that returns the three meal items for any order which does
not include fries.

SELECT burger, side, drink FROM orders WHERE side <> 'Fries' OR side IS NULL;

      burger      |    side     |      drink
------------------+-------------+-----------------
 LS Deluxe Burger | Onion Rings | Chocolate Shake
 LS Burger        |             |
(2 rows)


18. Write a query that returns the three meal items for any order that includes
both a side and a drink.

SELECT burger, side, drink FROM orders
WHERE (side IS NOT NULL) AND (drink IS NOT NULL);

      burger       |    side     |      drink
-------------------+-------------+-----------------
LS Chicken Burger | Fries       | Cola
LS Deluxe Burger  | Onion Rings | Chocolate Shake
(2 rows)
