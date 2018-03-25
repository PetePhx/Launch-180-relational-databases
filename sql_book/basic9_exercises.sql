1. Make sure you are connected to the encyclopedia database. We want to hold the
continent data in a separate table from the country data.

  1.1 Create a continents table with an auto-incrementing id column (set is as the
    Primary Key), and a continent_name column which can hold the same data as
    the continent column from the countries table.

    CREATE TABLE continents (
    id int,
    continent_name varchar(50),
    PRIMARY KEY (id)
    );

  1.2 Remove the continent column from the countries table.

  ALTER TABLE countries
  DROP COLUMN continent;

  1.3 Add a continent_id column to the countries table of type integer.

  ALTER TABLE countries
  ADD COLUMN continent_id int;

  1.4 Add a Foreign Key constraint to the continent_id column which references
  the id field of the continents table.

  ALTER TABLE countries ADD
  FOREIGN KEY (continent_id) REFERENCES continents (id) ON DELETE CASCADE;


2. Write queries to add data to the countries and continents tables so that the
data below is correctly represented across the two tables. Add both the
countries and the continents to their respective tables in alphabetical order.

Name      Capital       Population      Continent
-----------------------------------------------------
France      Paris       67,158,000      Europe
USA     Washington D.C. 325,365,189     North America
Germany     Berlin      82,349,400      Europe
Japan     Tokyo         126,672,000     Asia
Egypt     Cairo         96,308,900      Africa
Brazil    Brasilia      208,385,000     South America
-----------------------------------------------------

INSERT INTO continents (id, continent_name)
VALUES (1, 'Africa'),
(2, 'Asia'),
(3, 'Europe'),
(4, 'North America'),
(5, 'South America');

INSERT INTO countries (id, name, capital, population, continent_id)
VALUES (1, 'France', 'Paris', 67158000, 3),
(2, 'USA', 'Washington DC', 325365189, 4),
(3, 'Germany', 'Berlin', 82349400, 3),
(4, 'Japan', 'Tokyo', 126672000, 2),
(5, 'Egypt', 'Cairo', 96308900, 1),
(6, 'Brazil', 'Brasilia', 208385000, 5);


3. Examine the data below:
Album Name      Released        Genre           Label                     Singer Name
Born to Run 	  August 25, 1975 	Rock and roll 	Columbia 	             Bruce Springsteen
Purple Rain 	  June 25, 1984 	  Pop, R&B, Rock 	Warner Bros 	         Prince
Born in the USA June 4, 1984 	    Rock and roll, pop Columbia 	         Bruce Springsteen
Madonna 	July 27, 1983 	      Dance-pop, post-disco 	Warner Bros 	  Madonna
True Blue 	June 30, 1986 	    Dance-pop, Pop 	Warner Bros 	           Madonna
Elvis 	October 19, 1956 	     Rock and roll, Rhythm and Blues 	 RCA Victor 	Elvis Presley
Sign o' the Times 	March 30, 1987 	Pop, R&B, Rock, Funk 	   Paisley Park, Warner Bros 	Prince
G.I. Blues 	    October 1, 1960 	Rock and roll, Pop 	         RCA Victor 	Elvis Presley

We want to create an albums table to hold all the above data except the singer
name, and create a reference from the albums table to the singers table to link
the each album to the correct singer. Write the necessary SQL statements to do
this and to populate the table with data. Assume Album Name, Genre, and Label
can hold strings up to 100 characters. Include an auto-incrementing id column in
the albums table.

ALTER TABLE singers ADD PRIMARY KEY (id);

CREATE TABLE albums (
id serial PRIMARY KEY,
album_name varchar(100),
release_date date,
genre varchar(100),
label varchar(100),
singer_id int,
FOREIGN KEY (singer_id) REFERENCES singers (id)
);

INSERT INTO albums (album_name, released, genre, label, singer_id)
VALUES ('Born to Run', '1975-08-25', 'Rock and roll', 'Columbia', 1),
('Purple Rain', '1984-06-25', 'Pop, R&B, Rock', 'Warner Bros', 6),
('Born in the USA', '1984-06-04', 'Rock and roll, pop', 'Columbia', 1),
('Madonna', '1983-07-27', 'Dance-pop, post-disco', 'Warner Bros', 5),
('True Blue', '1986-06-30', 'Dance-pop, Pop', 'Warner Bros', 5),
('Elvis', '1956-10-19', 'Rock and roll, Rhythm and Blues', 'RCA Victor', 7),
('Sign o'' the Times', '1987-03-30', 'Pop, R&B, Rock, Funk', 'Paisley Park, Warner Bros', 6),
('G.I. Blues', '1960-10-01', 'Rock and roll, Pop', 'RCA Victor', 7);


4. Connect to the ls_burger database. If you run a simple SELECT query to
retrieve all the data from the orders table, you will see it is very
unnormalized. We have repetition of item names and costs and of customer data.

ls_burger=# SELECT * FROM orders;
 id | customer_name  |         burger          |    side     |      drink      |     customer_email      | customer_loyalty_points | burger_cost | side_cost | drink_cost
----+----------------+-------------------------+-------------+-----------------+-------------------------+-------------------------+-------------+-----------+------------
  3 | Natasha O'Shea | LS Double Deluxe Burger | Onion Rings | Chocolate Shake | natasha@osheafamily.com |                      42 |        6.00 |      1.50 |       2.00
  2 | Natasha O'Shea | LS Cheeseburger         | Fries       |                 | natasha@osheafamily.com |                      18 |        3.50 |      1.20 |       0.00
  1 | James Bergman  | LS Chicken Burger       | Fries       | Lemonade        | james1998@email.com     |                      28 |        4.50 |      1.20 |       1.50
  4 | Aaron Muller   | LS Burger               | Fries       |                 |                         |                      13 |        3.00 |      1.20 |       0.00
(4 rows)

We want to break this table up into multiple tables.

First of all create a customers table to hold the customer name data and an
email_addresses table to hold the customer email data.

Create a one-to-one relationship between them, ensuring that if a customer
record is deleted so is the equivalent email address record. Populate the tables
with the appropriate data from the current orders table.

CREATE TABLE customers (
id serial PRIMARY KEY,
name varchar(100) NOT NULL
);

INSERT INTO customers (id, name)
VALUES (1, 'Aaron Muller'),
(2, 'Natasha O''Shea'),
(3, 'James Bergman');

CREATE TABLE email_addresses (
customer_id int PRIMARY KEY,
email varchar(50),
FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE CASCADE
);

INSERT INTO email_addresses (customer_id, email)
VALUES (2, 'natasha@osheafamily.com'),
(3, 'james1998@email.com ');


5. We want to make our ordering system more flexible, so that customers can
order any combination of burgers, sides and drinks. The first step towards doing
this is to put all our product data into a separate table called products.
Create a table and populate it with the following data:

Product Name 	Product Cost 	Product Type 	Product Loyalty Points
LS Burger 	       3.00 	Burger 	10
LS Cheeseburger 	 3.50 	Burger 	15
LS Chicken Burger 	4.50 	Burger 	20
LS Double Deluxe Burger 	6.00 	Burger 	30
Fries 	1.20 	Side 	3
Onion Rings 	1.50 	Side 	5
Cola 	1.50 	Drink 	5
Lemonade 	1.50 	Drink 	5
Vanilla Shake 	2.00 	Drink 	7
Chocolate Shake 	2.00 	Drink 	7
Strawberry Shake 	2.00 	Drink 	7

The table should also have an auto-incrementing id column which acts as its
PRIMARY KEY. The product_type column should hold strings of up to 20 characters.
Other than that, the column types should be the same as their equivalent columns
from the orders table.

CREATE TABLE products (
id serial PRIMARY KEY,
product_name varchar(50),
product_cost numeric(4,2) DEFAULT 0,
product_type varchar(20),
loyalty_points int
);

INSERT INTO products (product_name, product_cost, product_type, loyalty_points)
VALUES ('LS Burger', 3.00, 'Burger', 10),
('LS Cheeseburger', 3.50, 'Burger', 15),
('LS Chicken Burger', 4.50, 'Burger', 20),
('LS Double Deluxe Burger', 6.00, 'Burger', 30),
('Fries', 1.20, 'Side', 3),
('Onion Rings', 1.50, 'Side', 5),
('Cola', 1.50, 'Drink', 5),
('Lemonade', 1.50, 'Drink', 5),
('Vanilla Shake', 2.00, 'Drink', 7),
('Chocolate Shake', 2.00, 'Drink', 7),
('Strawberry Shake', 2.00, 'Drink', 7);

result:
id |      product_name       | product_cost | product_type | loyalty_points
----+-------------------------+--------------+--------------+----------------
 1 | LS Burger               |         3.00 | Burger       |             10
 2 | LS Cheeseburger         |         3.50 | Burger       |             15
 3 | LS Chicken Burger       |         4.50 | Burger       |             20
 4 | LS Double Deluxe Burger |         6.00 | Burger       |             30
 5 | Fries                   |         1.20 | Side         |              3
 6 | Onion Rings             |         1.50 | Side         |              5
 7 | Cola                    |         1.50 | Drink        |              5
 8 | Lemonade                |         1.50 | Drink        |              5
 9 | Vanilla Shake           |         2.00 | Drink        |              7
10 | Chocolate Shake         |         2.00 | Drink        |              7
11 | Strawberry Shake        |         2.00 | Drink        |              7
(11 rows)


6. To associate customers with products, we need to do two more things:

  6.1 Alter or replace the orders table so that we can associate a customer with
  one or more orders (we also want to record an order status in this table).

  6.2 Create an order_items table so that an order can have one or more products
  associated with it.

Based on the order descriptions below, amend and create the tables as necessary
and populate them with the appropriate data.

James has one order, consisting of a Chicken Burger, Fries, Onion Rings, and a
 Lemonade. It has a status of 'In Progress'.

Natasha has two orders. The first consists of a Cheeseburger, Fries, and a Cola,
and has a status of 'Placed'; the second consists of a Double Deluxe Burger, a
Cheeseburger, two sets of Fries, Onion Rings, a Chocolate Shake and a Vanilla
Shake, and has a status of 'Complete'.

Aaron has one order, consisting of an LS Burger and Fries. It has a status of
'Placed'.

Assume that the order_status field of the orders table can hold strings of up to
20 characters.

  We design the order_items table such that it would facilitate the many-to-many
  relationship between orders and products.

DROP TABLE orders;

CREATE TABLE orders (
id serial PRIMARY KEY,
customer_id int,
order_status varchar(20),
FOREIGN KEY (customer_id) REFERENCES customers (id)
);

CREATE TABLE order_items (
  id serial PRIMARY KEY,
  order_id int NOT NULL,
  product_id int NOT NULL,
  FOREIGN KEY (order_id) REFERENCES orders (id) ON DELETE CASCADE,
  FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE CASCADE
);

INSERT INTO orders (customer_id, order_status)
VALUES (1, 'In Progress'),
(2, 'Placed'),
(2, 'Complete'),
(3, 'Placed');

INSERT INTO order_items (order_id, product_id)
VALUES (1, 3),
(1, 5),
(1, 6),
(1, 8),
(2, 2),
(2, 5),
(2, 7),
(3, 4),
(3, 2),
(3, 5),
(3, 5),
(3, 10),
(3, 9),
(4, 1),
(4, 5);

results:

orders:

id | customer_id | order_status
----+-------------+--------------
 1 |           1 | In Progress
 2 |           2 | Placed
 3 |           2 | Complete
 4 |           3 | Placed

order_items:

id | order_id | product_id
----+----------+------------
 1 |        1 |          3
 2 |        1 |          5
 3 |        1 |          6
 4 |        1 |          8
 5 |        2 |          2
 6 |        2 |          5
 7 |        2 |          7
 8 |        3 |          4
 9 |        3 |          2
10 |        3 |          5
11 |        3 |          5
12 |        3 |         10
13 |        3 |          9
14 |        4 |          1
15 |        4 |          5
(15 rows)
