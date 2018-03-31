1. What is the result of using an operator on a NULL value?

  Aside from `IS NULL` and `IS NOT NULL`, the operators will return NULL.

2. Set the default value of column department to "unassigned". Then set the
value of the department column to "unassigned" for any rows where it has a NULL
value. Finally, add a NOT NULL constraint to the department column.

ALTER TABLE employees
  ALTER COLUMN department
  SET DEFAULT 'unassigned';

UPDATE employees
  SET department = 'unassigned'
  WHERE department IS NULL;

ALTER TABLE employees
  ALTER COLUMN department
  SET NOT NULL;

3. Write the SQL statement to create a table called temperatures to hold the
following data:

-- date 	low 	high
-- ------------------
-- 2016-03-01 	34 	43
-- 2016-03-02 	32 	44
-- 2016-03-03 	31 	47
-- 2016-03-04 	33 	42
-- 2016-03-05 	39 	46
-- 2016-03-06 	32 	43
-- 2016-03-07 	29 	32
-- 2016-03-08 	23 	31
-- 2016-03-09 	17 	28

Keep in mind that all rows in the table should always contain all three values.

CREATE TABLE temperatures (
  "date" DATE NOT NULL,
  low INTEGER NOT NULL,
  high INTEGER NOT NULL
);


4. Write the SQL statements needed to insert the data shown in #3 into the
temperatures table.

INSERT INTO temperatures
  VALUES ('2016-03-01', 34, 43),
         ('2016-03-02', 32, 44),
         ('2016-03-03', 31, 47),
         ('2016-03-04', 33, 42),
         ('2016-03-05', 39, 46),
         ('2016-03-06', 32, 43),
         ('2016-03-07', 29, 32),
         ('2016-03-08', 23, 31),
         ('2016-03-09', 17, 28);


5. Write a SQL statement to determine the average (mean) temperature for the
days from March 2, 2016 through March 8, 2016.

average temerature for each day:

SELECT "date", round((high + low) / 2.0, 1) AS "average temperature"
  FROM temperatures
  WHERE "date" BETWEEN '2016-03-02' AND '2016-03-08';

  date    | average temperature
------------+---------------------
2016-03-02 |                38.0
2016-03-03 |                39.0
2016-03-04 |                37.5
2016-03-05 |                42.5
2016-03-06 |                37.5
2016-03-07 |                30.5
2016-03-08 |                27.0
(7 rows)

average temperature for all days:

SELECT round(avg((high + low) / 2.0), 1) AS "average temperature"
  FROM temperatures
  WHERE "date" BETWEEN '2016-03-02' AND '2016-03-08';

  average temperature
 ---------------------
                 36.0
 (1 row)


6. Write a SQL statement to add a new column, rainfall, to the temperatures
table. It should store millimeters of rain as integers and have a default value
of 0.

ALTER TABLE temperatures
  ADD COLUMN rainfall INTEGER DEFAULT 0;

7. Each day, it rains one millimeter for every degree the average temperature
goes above 35. Write a SQL statement to update the data in the table
temperatures to reflect this.

To avoid round-off errors:
ALTER TABLE temperatures ALTER COLUMN rainfall TYPE NUMERIC(3,1)


UPDATE temperatures
  SET rainfall = round((high + low) / 2.0 - 35, 1)
  WHERE round((high + low) / 2.0, 1) > 35;

8. A decision has been made to store rainfall data in inches. Write the SQL
statements required to modify the rainfall column to reflect these new
requirements.

ALTER TABLE temperatures
  ALTER COLUMN rainfall
  TYPE NUMERIC(5, 3);

UPDATE temperatures
  SET rainfall = rainfall * 0.03937;

9. Write a SQL statement that renames the temperatures table to weather.

ALTER TABLE temperatures
  RENAME TO weather;

10. What psql meta command shows the structure of a table? Use it to describe
the structure of weather.

\d weather

                  Table "public.weather"
  Column  |     Type     | Collation | Nullable | Default
----------+--------------+-----------+----------+---------
 date     | date         |           | not null |
 low      | integer      |           | not null |
 high     | integer      |           | not null |
 rainfall | numeric(5,3) |           |          | 0


11. What PostgreSQL program can be used to create a SQL file that contains the
SQL commands needed to recreate the current structure and data of the weather
table?

From bash terminal:

$ pg_dump -d sql_book -t weather --inserts > weather.sql

If we are only interested in copying the data (not schema), we can use
metacommand \copy in psql:

=# \copy weather to weather.sql
