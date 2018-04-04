IS NULL and IS NOT NULL

Write two SQL queries:

  One that generates a listing of parts that currently belong to a device.

  One that generates a listing of parts that don''t belong to a device.

Do not include the id column in your queries.


SELECT part_number, device_id
  FROM parts
  WHERE device_id IS NOT NULL;

  part_number | device_id
 -------------+-----------
          101 |         1
          102 |         1
          103 |         1
          201 |         2
          202 |         2
          203 |         2
          204 |         2
          205 |         2
 (8 rows)

SELECT part_number, device_id
  FROM parts
  WHERE device_id IS NULL;

 part_number | device_id
-------------+-----------
         301 |
         302 |
         303 |
(3 rows)
