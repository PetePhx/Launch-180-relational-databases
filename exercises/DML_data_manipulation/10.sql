Delete Accelerometer

Our workshop has decided to not make an Accelerometer after all. Delete any data
related to "Accelerometer", this includes the parts associated with an
Accelerometer.


First, make sure the parts table foreign key will cascade on delete:

ALTER TABLE parts
  DROP CONSTRAINT parts_device_id_fkey;

ALTER TABLE parts
  ADD CONSTRAINT parts_device_id_fkey
  FOREIGN KEY (device_id)
  REFERENCES devices (id)
  ON DELETE CASCADE;

Now we delete the Accelerometer from the devices table:

DELETE FROM devices
  WHERE name = 'Accelerometer';

Check the parts table:

SELECT * FROM parts
  ORDER BY device_id;

  id | part_number | device_id
 ----+-------------+-----------
   4 |         201 |         2
   5 |         202 |         2
   6 |         203 |         2
   1 |         101 |         2
  12 |         442 |         3
  10 |         302 |
  11 |         303 |
   9 |         301 |
 (8 rows)

(all parts with device_id 1 are also deleted.)


Further Exploration

This process may have been a bit simpler if we had initially defined our devices
tables a bit differently. We could delete both a device and its associated parts
with one SQL statement if that were the case. What change would have to have to
be made to table devices to make this possible? Also, what SQL statement would
you have to write that can delete both a device and its parts all in one go?

Answer:

As shown above, the ON DELETE CASCADE clause in the foreign key declaration
causes the rows referencing a specific row to delete on deletion of the
referenced row.
