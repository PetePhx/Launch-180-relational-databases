Conditional Subqueries: ANY, SOME, ALL

Write an SQL query that returns the names of all items that have at least on bid
less than 100 dollars. To accomplish this, use an ANY clause, along with a
subquery.

Expected Output:

 At Least One Bid Less Than 100 Dollars
----------------------------------
 Video Game
 Outdoor Grill
 Vase
(3 rows)

SELECT name AS "At Least One Bid Less Than 100 Dollars"
  FROM items
  WHERE 100 > ANY (SELECT amount
                   FROM bids
                   WHERE items.id = bids.item_id);

Finally, another query using ALL clause to return items with all bids less than
100 dollars.

You shouldn''t have to use any JOINs to finish this exercise.

Expected Output:

  Highest Bid Less Than 100 Dollars
----------------------------------
 Video Game
 Outdoor Grill
 Vase
 Television
(4 rows)

SELECT name AS " Highest Bid Less Than 100 Dollars"
  FROM items
  WHERE 100 > ALL (SELECT amount
                   FROM bids
                   WHERE items.id = bids.item_id);
