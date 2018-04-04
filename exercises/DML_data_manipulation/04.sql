SELECT part_number

We want to grab all parts that have a part_number that starts with 3. Write a
SELECT query to get this information. This table may show all attributes of the
parts table.

SELECT * FROM parts
  WHERE part_number::VARCHAR LIKE '3%';

id | part_number | device_id 
----+-------------+-----------
 9 |         301 |
10 |         302 |
11 |         303 |
(3 rows)
