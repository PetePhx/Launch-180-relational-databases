INNER JOIN

Write an SQL query to display all devices along with all the parts that make
them up. We only want to display the name of the devices. It''s parts should
only display the part_number.

Expected output:

     name      | part_number
---------------+-------------
 Accelerometer |          12
 Accelerometer |          14
 Accelerometer |          16
 Gyroscope     |          31
 Gyroscope     |          33
 Gyroscope     |          35
 Gyroscope     |          37
 Gyroscope     |          39
(8 rows)

NOTE: The part numbers and sequence may vary from those shown above.

SELECT devices.name, parts.part_number
  FROM devices INNER JOIN parts
  ON devices.id = parts.device_id;

    name      | part_number
---------------+-------------
Accelerometer |         101
Accelerometer |         102
Accelerometer |         103
Gyroscope     |         201
Gyroscope     |         202
Gyroscope     |         203
Gyroscope     |         204
Gyroscope     |         205
(8 rows)
