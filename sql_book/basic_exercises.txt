1. Write a query that returns all of the customer names from the orders table.

  SELECT customer_name FROM orders;

      customer_name
    -----------------
    Todd Perez
    Florence Jordan
    Robin Barnes
    Joyce Silva
    Joyce Silva
    (5 rows)


2. Write a query that returns all of the orders that include a Chocolate Shake.

  SELECT * FROM orders WHERE drink = 'Chocolate Shake';

   id |  customer_name  |         burger          | side  |      drink
  ----+-----------------+-------------------------+-------+-----------------
    2 | Florence Jordan | LS Cheeseburger         | Fries | Chocolate Shake
    4 | Joyce Silva     | LS Double Deluxe Burger | Fries | Chocolate Shake

3. Write a query that returns the burger, side, and drink for the order with an
id of 2.

  SELECT burger, side, drink FROM orders WHERE id = 2;

       burger      | side  |      drink
  -----------------+-------+-----------------
   LS Cheeseburger | Fries | Chocolate Shake
  (1 row)

4. Write a query that returns the name of anyone who ordered Onion Rings.

  SELECT customer_name FROM orders WHERE side = 'Onion Rings';

    customer_name
    ---------------
    Robin Barnes
    Joyce Silva
    (2 rows)
