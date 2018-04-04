Oldest Device

Insert one more device into the devices table. You may use this SQL statement or
create your own.

INSERT INTO devices (name) VALUES ('Magnetometer');
INSERT INTO parts (part_number, device_id) VALUES (442, 3);

Assuming nothing about the existing order of the records in the database, write
an SQL statement that will return the name of the oldest device from our devices
table.


INSERT INTO devices (id, name) VALUES (3, 'Magnetometer');
INSERT INTO parts (id, part_number, device_id) VALUES (12, 442, 3);

SELECT name, created_at FROM devices
  ORDER BY created_at
  LIMIT 1;

    name      |         created_at
---------------+----------------------------
Accelerometer | 2018-04-04 11:17:13.617445
(1 row)
