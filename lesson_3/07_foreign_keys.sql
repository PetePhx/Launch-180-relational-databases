1. Import this file into a new database.

(https://raw.githubusercontent.com/launchschool/sql_course_data/master/sql-and-relational-databases/relational-data-and-joins/foreign-keys/orders_products1.sql)

  lesson_3=# \i orders.sql

2. Update the orders table so that referential integrity will be preserved for
the data between orders and products.

ALTER TABLE orders
  ADD FOREIGN KEY (product_id)
  REFERENCES products(id);

-- more explicitly:

ALTER TABLE orders
  ADD CONSTRAINT orders_product_id_fkey
  FOREIGN KEY (product_id)
  REFERENCES products(id);


3. Use psql to insert the data shown in the following table into the database:

Quantity 	Product
---------------------
10 	      small bolt
25 	      small bolt
15 	      large bolt

INSERT INTO products
  VALUES (1, 'small bolt'),
         (2, 'large bolt');

INSERT INTO  orders
  VALUES (DEFAULT, 1, 10),
         (DEFAULT, 1, 25),
         (DEFAULT, 2, 15);


4. Write a SQL statement that returns a result like this:

 quantity |    name
----------+------------
       10 | small bolt
       25 | small bolt
       15 | large bolt
(3 rows)

SELECT orders.quantity, products.name
  FROM orders INNER JOIN products
  ON orders.product_id = products.id;


5. Can you insert a row into orders without a product_id? Write a SQL statement
to prove your answer.

Yes. Both of the following queries are accepted:

INSERT INTO orders (id, quantity)
  VALUES (4, 1);

INSERT INTO orders (id, product_id, quantity)
  VALUES (5, NULL, 1);

lesson_3=# SELECT * FROM orders;

 id | product_id | quantity
----+------------+----------
  1 |          1 |       10
  2 |          1 |       25
  3 |          2 |       15
  4 |            |        1     -- NULL product_id rows that
  5 |            |        1     -- we added above.
(5 rows)


6. Write a SQL statement that will prevent NULL values from being stored in
orders.product_id. What happens if you execute that statement?

ALTER TABLE orders
  ALTER COLUMN product_id
  SET NOT NULL;

  ERROR:  column "product_id" contains null values

  Error occures since we added null values to product_id column in the previous
  exercise.

7. Make any changes needed to avoid the error message encountered in #6.

DELETE FROM orders
  WHERE product_id IS NULL;

ALTER TABLE orders
  ALTER COLUMN product_id
  SET NOT NULL;

8. Create a new table called reviews to store the data shown below. This table
should include a primary key and a reference to the products table.

Product 	Review
small bolt 	a little small
small bolt 	very round!
large bolt 	could have been smaller

CREATE TABLE reviews (
  id serial PRIMARY KEY,
  product_id int REFERENCES products(id),
  body text NOT NULL
);


9. Write SQL statements to insert the data shown in the table in #8.

INSERT INTO reviews (product_id, body)
  VALUES (1, 'a little small'),
         (1, 'very round!'),
         (2, 'could have been smaller');


10. True or false: A foreign key constraint prevents NULL values from being
stored in a column.

False.

The foreign key constraint prevents entering of values that are not present in
the referenced table primary key. HOwever, null values are not prevented. We
need to add a NOT NULL constraint in addition to the FOREIGN KEY constraint. 
