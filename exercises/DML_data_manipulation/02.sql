Insert Data for Parts and Devices

Now that we have the infrastructure for our workshop set up, let''s start adding
in some data. Add in two different devices. One should be named,
"Accelerometer". The other should be named, "Gyroscope".

The first device should have 3 parts (this is grossly simplified). The second
device should have 5 parts. The part numbers may be any number between 1 and
10000. There should also be 3 parts that don''t belong to any device yet.

INSERT INTO devices (id, name, created_at)
  VALUES (1, 'Accelerometer', DEFAULT),
         (2, 'Gyroscope', DEFAULT);

INSERT INTO parts (id, part_number, device_id)
  VALUES (1, 101, 1),
         (2, 102, 1),
         (3, 103, 1),
         (4, 201, 2),
         (5, 202, 2),
         (6, 203, 2),
         (7, 204, 2),
         (8, 205, 2),
         (9, 301, NULL),
         (10, 302, NULL),
         (11, 303, NULL);
