Comparing SQL Statements

In this exercise, we''ll use EXPLAIN ANALYZE to compare the efficiency of two
SQL statements. These two statements are actually from the "Query From a Virtual
Table" exercise in this set. In that exercise, we stated that our subquery-based
solution:

SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

was actually faster than the simpler equivalent without subqueries:

SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;

In this exercise, we will demonstrate this fact.

Run EXPLAIN ANALYZE on the two statements above. Compare the planning time,
execution time, and the total time required to run these two statements. Also
compare the total "costs". Which statement is more efficient and why?


Analyzing the first query:

EXPLAIN ANALYZE
  SELECT MAX(bid_counts.count)
    FROM (SELECT COUNT(bidder_id)
          FROM bids
          GROUP BY bidder_id) AS bid_counts;

                                                  QUERY PLAN
---------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=37.15..37.16 rows=1 width=8) (actual time=0.032..0.032 rows=1 loops=1)
   ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.028..0.029 rows=6 loops=1)
         Group Key: bids.bidder_id
         ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.012..0.015 rows=26 loops=1)
 Planning time: 0.101 ms
 Execution time: 0.074 ms
(6 rows)


Analying the second query:

EXPLAIN ANALYZE
  SELECT COUNT(bidder_id) AS max_bid
    FROM bids
    GROUP BY bidder_id
    ORDER BY max_bid DESC
    LIMIT 1;

                                                     QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
 Limit  (cost=35.65..35.65 rows=1 width=12) (actual time=0.038..0.038 rows=1 loops=1)
   ->  Sort  (cost=35.65..36.15 rows=200 width=12) (actual time=0.037..0.037 rows=1 loops=1)
         Sort Key: (count(bidder_id)) DESC
         Sort Method: top-N heapsort  Memory: 25kB
         ->  HashAggregate  (cost=32.65..34.65 rows=200 width=12) (actual time=0.027..0.029 rows=6 loops=1)
               Group Key: bidder_id
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.013..0.015 rows=26 loops=1)
 Planning time: 0.099 ms
 Execution time: 0.073 ms
(9 rows)


The final results of analysis varies from each run to another by up to 20%,
nevertheless the two querying methods seem to be similar both in cost metrics
as well as execution time within the alalysis precision.


Further Exploration:

Cost comparison for scalar subqueries versus JOIN operations:

Scalar Subquery analysis:

EXPLAIN ANALYZE
  SELECT name,
         (SELECT count(id)
            FROM bids
            WHERE item_id = items.id)
    FROM items;

                                                 QUERY PLAN
-------------------------------------------------------------------------------------------------------------
 Seq Scan on items  (cost=0.00..25455.20 rows=880 width=40) (actual time=0.028..0.067 rows=6 loops=1)
   SubPlan 1
     ->  Aggregate  (cost=28.89..28.91 rows=1 width=8) (actual time=0.008..0.008 rows=1 loops=6)
           ->  Seq Scan on bids  (cost=0.00..28.88 rows=8 width=4) (actual time=0.003..0.005 rows=4 loops=6)
                 Filter: (item_id = items.id)
                 Rows Removed by Filter: 22
 Planning time: 0.117 ms
 Execution time: 0.101 ms
(8 rows)


JOIN query analysis:

EXPLAIN ANALYZE
  SELECT items.name,
         COUNT(bids.id)
    FROM items LEFT OUTER JOIN bids
      ON items.id = bids.item_id
    GROUP BY items.name;

                                                     QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
 HashAggregate  (cost=81.50..83.50 rows=200 width=40) (actual time=0.084..0.086 rows=6 loops=1)
   Group Key: items.name
   ->  Hash Right Join  (cost=29.80..73.95 rows=1510 width=36) (actual time=0.059..0.071 rows=27 loops=1)
         Hash Cond: (bids.item_id = items.id)
         ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=8) (actual time=0.006..0.008 rows=26 loops=1)
         ->  Hash  (cost=18.80..18.80 rows=880 width=36) (actual time=0.026..0.026 rows=6 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Seq Scan on items  (cost=0.00..18.80 rows=880 width=36) (actual time=0.013..0.015 rows=6 loops=1)
 Planning time: 0.144 ms
 Execution time: 0.128 ms


Here both the planning time as well as the execution time is shorter for the
scalar query by about 20% (across multiple tries with similar difference in
performace).
