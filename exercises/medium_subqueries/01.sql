Set Up the Database using \copy

This set of exercises will focus on an auction. Create a new database called
auction. In this database there will be three tables, bidders, items, and bids.

After creating the database, set up the 3 tables using the following
specifications:

bidders

  id of type SERIAL: this should be a primary key

  name of type text: this should be NOT NULL

items

  id of type SERIAL: this should be a primary key

  name of type text: this should be NOT NULL

  initial_price and sales_price: These two columns should both be of type
  numeric. Each column should be able to hold a number as high as 1000 dollars
  with 2 decimal points of precision.

  The initial_price represents the starting price of an item when it is first
  put up for auction. This column should never be NULL.

  The sales_price represents the final price at which the item was sold. This
  column may be NULL, as it is possible to have an item that was never sold off.

bids

  id of type SERIAL: this should be a primary key

  bidder_id, item_id: These will be of type integer and should not be NULL. This
  table connects a bidder with an item and each row represents an individual
  bid. There should never be a column that has bidder_id or item_id unknown or
  NULL. Nor should there ever be a bid that references a nonexistent item or
  bidder. If the item or bidder associated with a bid is removed, that bid
  should also be removed from the database.

  Create your bids table so that both bidder_id and item_id together form a
  composite index for faster lookup.

  amount - The amount of money placed for each individual bid by a bidder. This
  column should be of the same type as items.initial_price and have the same
  constraints.

Finally, use the \copy meta-command to import the below files into your auction
database. You''ll have to create these files yourself before you can import them
with \copy.

bidders.csv

id, name
1,Alison Walker
2,James Quinn
3,Taylor Williams
4,Alexis Jones
5,Gwen Miller
6,Alan Parker
7,Sam Carter

items.csv

id, name, initial_price, sales_price
1,Video Game, 39.99, 70.87
2,Outdoor Grill, 51.00, 83.25
3,Painting, 100.00, 250.00
4,Tent, 220.00, 300.00
5,Vase, 20.00, 42.00
6,Television, 550.00,

bids.csv

id, bidder_id, item_id, amount
1,1, 1, 40.00
2,3, 1, 52.00
3,1, 1, 53.00
4,3, 1, 70.87
5,5, 2, 83.25
6,2, 3, 110.00
7,4, 3, 140.00
8,2, 3, 150.00
9,6, 3, 175.00
10,4, 3, 185.00
11,2, 3, 200.00
12,6, 3, 225.00
13,4, 3, 250.00
14,1, 4, 222.00
15,2, 4, 262.00
16,1, 4, 290.00
17,1, 4, 300.00
18,2, 5, 21.72
19,6, 5, 23.00
20,2, 5, 25.00
21,6, 5, 30.00
22,2, 5, 32.00
23,6, 5, 33.00
24,2, 5, 38.00
25,6, 5, 40.00
26,2, 5, 42.00



createdb auction

CREATE TABLE bidders (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE items (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  initial_price NUMERIC(6, 2) NOT NULL
    CHECK (initial_price BETWEEN 0.01 AND 1000.00),
  sales_price NUMERIC(6, 2)
    CHECK (sales_price BETWEEN 0.01 AND 1000.00)
);

CREATE TABLE bids (
  id SERIAL PRIMARY KEY,
  bidder_id INTEGER NOT NULL
    REFERENCES bidders(id)
      ON DELETE CASCADE,
  item_id INTEGER
    REFERENCES items(id)
      ON DELETE CASCADE,
  amount NUMERIC(6, 2) NOT NULL
    CHECK(amount BETWEEN 0.01 AND 1000.00)
);

CREATE INDEX ON bids (bidder_id, item_id);

COPY bidders (id, name)
  FROM '/home/user/Launch/180_relational_databases/exercises/medium_subqueries/bidders.csv'
  (FORMAT CSV,
   HEADER TRUE,
   DELIMITER ',',
   ENCODING 'UTF-8');

COPY items (id, name, initial_price, sales_price)
  FROM  '/home/user/Launch/180_relational_databases/exercises/medium_subqueries/items.csv'
  (FORMAT CSV,
   HEADER TRUE,
   DELIMITER ',',
   ENCODING 'UTF-8');

COPY bids (id, bidder_id, item_id, amount)
  FROM '/home/user/Launch/180_relational_databases/exercises/medium_subqueries/bids.csv'
  (FORMAT CSV,
   HEADER TRUE,
   DELIMITER ',',
   ENCODING 'UTF-8');
