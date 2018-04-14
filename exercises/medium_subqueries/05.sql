Conditional Subqueries: ANY, SOME, ALL

Write an SQL query that returns the names of all items that have at least one
bid of less than 100 dollars. To accomplish this, use an ANY clause, along with
a subquery.

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


Finally, write another query using the ALL clause to return items with all bids
less than 100 dollars.

You shouldn''t have to use any JOINs to finish this exercise.

Expected Output:

  Highest Bid Less Than 100 Dollars
----------------------------------
 Video Game
 Outdoor Grill
 Vase
 Television
(4 rows)

SELECT name AS "Highest Bid Less Than 100 Dollars"
  FROM items
  WHERE 100 > ALL (SELECT amount
                   FROM bids
                   WHERE items.id = bids.item_id);


Further Exploration

There is a way to get the same result table back using ALL for this exercise.
How would you go about doing this? Note that the answer lies in the previous
exercises for this set.

SELECT name AS "Highest Bid Less Than 100 Dollars"
  FROM items
  WHERE 100 > ALL (SELECT amount
                   FROM bids
                   WHERE items.id = bids.item_id)
  AND EXISTS (SELECT 1
                   FROM bids
                   WHERE items.id = bids.item_id);

Highest Bid Less Than 100 Dollars
-----------------------------------
Vase
Outdoor Grill
Video Game
(3 rows)
