1. Make sure you are connected to the encyclopedia database. Write a query to
retrieve the first row of data from the countries table.


SELECT * FROM countries LIMIT 1;

id |  name  | capital | population
----+--------+---------+------------
 1 | France | Paris   |   67158000
(1 row)


2. Write a query to retrieve the name of the country with the largest population.

SELECT name FROM countries ORDER BY population DESC LIMIT 1;

 name
------
 USA
(1 row)

3. Write a query to retrieve the name of the country with the second largest
population.

SELECT name FROM countries ORDER BY population DESC OFFSET 1 LIMIT 1;

 name
-------
 Japan
(1 row)

4. Write a query to retrieve all of the unique values from the binomial_name column
of the animals table.

SELECT DISTINCT binomial_name FROM animals;

binomial_name
--------------------------
Aquila Chrysaetos
Strigops habroptila
Falco Peregrinus
Columbidae Columbiformes
(4 rows)


5. Write a query to return the longest binomial name from the animals table.

SELECT binomial_name FROM animals ORDER BY length(binomial_name) DESC LIMIT 1;

binomial_name
--------------------------
 Columbidae Columbiformes
(1 row)

6. Write a query to return the first name of any celebrity born in 1958.

SELECT first_name FROM celebrities WHERE date_part('year', date_of_birth) = 1958;

 first_name
------------
(0 rows)


7. Write a query to return the highest maximum age from the animals table.

SELECT max_age_years FROM animals ORDER BY max_age_years DESC LIMIT 1;

 max_age_years
---------------
            60
(1 row)


8. Write a query to return the average maximum weight from the animals table.

SELECT avg(max_weight_kg) FROM animals;
        avg
--------------------
 3.1700000000000000
(1 row)


9. Write a query to return the number of rows in the countries table.

SELECT count(id) FROM countries;

count
-------
    4
(1 row)


10. Write a query to return the total population of all the countries in the
countries table.

SELECT sum(population) FROM countries;

sum
-----------
601544589
(1 row)


11. Write a query to return each unique conservation status code alongside the
number of animals that have that code.

SELECT conservation_status, count(name) FROM animals
GROUP BY conservation_status;

conservation_status | count
---------------------+-------
CR                  |     1
LC                  |     4
(2 rows)


12. Connect to the ls_burger database. Write a query that returns the average burger
cost for all orders that include fries.

SELECT avg(burger_cost) FROM orders WHERE side = 'Fries';

avg
--------------------
4.0000000000000000
(1 row)


13. Write a query that returns the cost of the cheapest side ordered.

SELECT side_cost FROM orders WHERE side IS NOT NULL ORDER BY side_cost LIMIT 1;

side_cost
-----------
     0.99
(1 row)

  # Another solution using the aggregate function min():

SELECT min(side_cost) FROM orders WHERE side IS NOT NULL;

min
------
0.99
(1 row)


14. Write a query that returns the number of orders that include Fries and the
number of orders that include Onion Rings.

SELECT side, count(id) FROM orders
WHERE side = 'Fries' OR side = 'Onion Rings'
GROUP BY side; 

    side     | count
-------------+-------
 Fries       |     2
 Onion Rings |     1
(2 rows)
