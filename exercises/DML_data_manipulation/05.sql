Aggregate Functions

Write an SQL query that returns a result table with the name of each device in
our database together with the number of parts for that device.

SELECT devices.name AS "device name",
       count(parts.id) AS "number of parts"
  FROM devices INNER JOIN parts
    ON devices.id = parts.device_id
  GROUP BY devices.name;

  device name  | number of parts
---------------+-----------------
 Gyroscope     |               5
 Accelerometer |               3
(2 rows)
