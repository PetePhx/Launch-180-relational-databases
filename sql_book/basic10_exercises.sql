1. Connect to the encyclopedia database. Write a query to return all of the
country names along with their appropriate continent names.

SELECT c.name, t.continent_name
FROM countries AS c
JOIN continents AS t
ON (c.continent_id = t.id);


2. Write a query to return all of the names and capitals of the European
countries.

SELECT c.name, c.capital
FROM countries AS c
JOIN continents AS t
ON (c.continent_id = t.id)
WHERE t.continent_name = 'Europe';

-- using a subquery

SELECT c.name, c.capital
FROM countries AS c
WHERE c.continent_id IN
(SELECT t.id FROM continents AS t
WHERE t.continent_name = 'Europe');


3. Write a query to return the first name of any singer who had an album
released under the Warner Bros label.

SELECT DISTINCT s.first_name
FROM singers AS s
JOIN albums AS a
ON (s.id = a.singer_id)
WHERE a.label LIKE '%Warner Bros%';


4. Write a query to return the first name and last name of any singer who
released an album in the 80s and who is still living, along with the names of
the album that was released and the release date. Order the results by the
singer''s age (youngest first).

SELECT s.first_name, s.last_name, a.album_name, a.released
FROM singers AS s
JOIN albums AS a
ON (a.singer_id = s.id)
WHERE a.released >= '1980-01-01'
AND a.released <= '1989-12-31'
AND s.deceased = false
ORDER BY s.date_of_birth DESC;


5. Write a query to return the first name and last name of any singer without an
associated album entry.

SELECT s.first_name, s.last_name
FROM singers AS s
LEFT JOIN albums AS a
ON (s.id = a.singer_id)
WHERE a.id IS NULL;


6. Rewrite the query for the last question as a sub-query.

SELECT first_name, last_name
FROM singers
WHERE id NOT IN
(SELECT singer_id FROM albums);


7. Connect to the ls_burger database. Return a list of all orders and their
associated product items.

SELECT o.*, p.*
FROM orders AS o
JOIN order_items AS oi
ON oi.order_id = o.id
JOIN products AS p
ON oi.product_id = p.id;

-- with double CROSS JOIN:
-- (yes, it's very inefficient!)

SELECT o.*, p.*
FROM orders AS o
CROSS JOIN order_items AS oi
CROSS JOIN products AS p
WHERE oi.order_id = o.id
AND oi.product_id = p.id;


8. Return the id of any order that includes Fries. Use table aliasing in your
query.

SELECT DISTINCT o.id
FROM orders AS o
JOIN order_items AS oi
ON oi.order_id = o.id
JOIN products AS p
ON oi.product_id = p.id
WHERE p.product_name = 'Fries';


9. Build on the query from the previous question to return the name of any
customer who ordered fries. Return this in a column called 'Customers who like
Fries'. Don''t repeat the same customer name more than once in the results.

SELECT DISTINCT c.name AS "Customers who like Fries"
FROM customers AS c
JOIN orders AS o
ON c.id = o.customer_id
JOIN order_items AS oi
ON oi.order_id = o.id
JOIN products AS p
ON oi.product_id = p.id
WHERE p.product_name = 'Fries';


10. Write a query to return the total cost of Natasha O'Shea's orders.

SELECT sum(p.product_cost)
FROM customers AS c
JOIN orders AS o
ON c.id = o.customer_id
JOIN order_items AS oi
ON oi.order_id = o.id
JOIN products AS p
ON oi.product_id = p.id
WHERE c.name LIKE '%Natasha O''Shea%';


11. Write a query to return the name of every product included in an order
alongside the number of times it has been ordered.

SELECT p.product_name, count(p.id) AS "number of times ordered"
FROM order_items AS oi
JOIN products AS p
ON oi.product_id = p.id
GROUP BY p.product_name
ORDER BY "number of times ordered" DESC;

product_name            | number of times ordered
------------------------+-------------------------
Fries                   |                       5
LS Cheeseburger         |                       2
LS Chicken Burger       |                       1
Onion Rings             |                       1
Vanilla Shake           |                       1
Lemonade                |                       1
LS Double Deluxe Burger |                       1
Chocolate Shake         |                       1
Cola                    |                       1
LS Burger               |                       1
(10 rows)
