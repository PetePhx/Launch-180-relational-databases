Hypothetically

The company president is looking to increase revenue. As a prelude to his
decision making, he asks for two numbers: the amount of expected income from
"big ticket" services (those services that cost more than $100) and the maximum
income the company could achieve if it managed to convince all of its customers
to select all of the company''s big ticket items.

For simplicity, your solution should involve two separate SQL queries: one that
reports the current expected income level, and one that reports the hypothetical
maximum. The outputs should look like this:

  sum
--------
 500.00
(1 row)

  sum
---------
 10493.00
(1 row)


SELECT sum(services.price)
  FROM services
    INNER JOIN customers_services
      ON services.id = service_id
    INNER JOIN customers
      ON customer_id = customers.id
  WHERE services.price > 100;

  sum
--------
 500.00
(1 row)

SELECT sum(services.price)
  FROM customers CROSS JOIN services
  WHERE services.price > 100;

  sum
----------
10493.00
(1 row)


-- Further Exploration

This exercise is really contrived: it just shows how hard it is to come up with
a possible use case for CROSS JOIN. CROSS JOIN is generally best suited to
generating test data rather than production queries.

Can you think of any other situations where a CROSS JOIN might be useful?

Creating all possible combinations, say positions on the chess board:

CREATE TABLE rows (r CHAR(1));

CREATE TABLE cols (c INT);

INSERT INTO rows
  VALUES ('A'), ('B'), ('C'), ('D'), ('E'), ('F'), ('G'), ('H');

INSERT INTO cols
  VALUES (1), (2), (3), (4), (5), (6), (7), (8);

SELECT (r, c) AS position
  FROM rows CROSS JOIN cols;

  position
 ----------
  (A,1)
  (B,1)
  (C,1)
  (D,1)
  (E,1)
  ...
  (D,8)
  (E,8)
  (F,8)
  (G,8)
  (H,8)
