Scalar Subqueries

For this exercise, use a scalar subquery to determine the number of bids on each
item. The entire query should return a table that has the name of each item
along with the number of bids on an item.

Here is the expected output:

    name      | count
--------------+-------
Video Game    |     4
Outdoor Grill |     1
Painting      |     8
Tent          |     4
Vase          |     9
Television    |     0
(6 rows)

SELECT name,
       (SELECT count(id)
          FROM bids
          WHERE item_id = items.id)
  FROM items;


Further Exploration

If we wanted to get an equivalent result, without using a subquery, then we
would have to use a LEFT OUTER JOIN. Can you come up with the equivalent query
that uses a JOIN clause?


SELECT items.name,
       COUNT(bids.id)
  FROM items LEFT OUTER JOIN bids
    ON items.id = bids.item_id
  GROUP BY items.name;

    name      | count 
---------------+-------
Outdoor Grill |     1
Television    |     0
Tent          |     4
Painting      |     8
Vase          |     9
Video Game    |     4
(6 rows)
