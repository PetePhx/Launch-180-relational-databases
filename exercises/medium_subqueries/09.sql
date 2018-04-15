EXPLAIN

For this exercise, let''s explore the EXPLAIN PostgreSQL statement. It''s a very
useful SQL statement that lets us analyze the efficiency of our SQL statements.
More specifically, use EXPLAIN to check the efficiency of the query statement we
used in the exercise on EXISTS:

SELECT name FROM bidders
WHERE EXISTS (SELECT 1 FROM bids WHERE bids.bidder_id = bidders.id);

First use just EXPLAIN, then include the ANALYZE option as well. For your
answer, list any SQL statements you used, along with the output you get back,
and your thoughts on what is happening in both cases.

EXPLAIN
  SELECT name
  FROM bidders
  WHERE EXISTS (SELECT 1
                FROM bids
                WHERE bids.bidder_id = bidders.id);

--------------------------------------------------------------------------
 Hash Join  (cost=33.38..66.47 rows=635 width=32)
   Hash Cond: (bidders.id = bids.bidder_id)
   ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36)
   ->  Hash  (cost=30.88..30.88 rows=200 width=4)
         ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4)
               Group Key: bids.bidder_id
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4)
(7 rows)


EXPLAIN ANALYZE
  SELECT name
  FROM bidders
  WHERE EXISTS (SELECT 1
                FROM bids
                WHERE bids.bidder_id = bidders.id);

                                              QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
Hash Join  (cost=33.38..66.47 rows=635 width=32) (actual time=0.043..0.046 rows=6 loops=1)
  Hash Cond: (bidders.id = bids.bidder_id)
  ->  Seq Scan on bidders  (cost=0.00..22.70 rows=1270 width=36) (actual time=0.013..0.014 rows=7 loops=1)
  ->  Hash  (cost=30.88..30.88 rows=200 width=4) (actual time=0.024..0.024 rows=6 loops=1)
    Buckets: 1024  Batches: 1  Memory Usage: 9kB
    ->  HashAggregate  (cost=28.88..30.88 rows=200 width=4) (actual time=0.020..0.021 rows=6 loops=1)
      Group Key: bids.bidder_id
      ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.007..0.010 rows=26 loops=1)
Planning time: 0.224 ms
Execution time: 0.080 ms
(10 rows)

The number of rows in the estimate are much larger than the actual rows in the
subquery as well as the main query.
