1. Import this file into a PostgreSQL database.

\i films.sql

2. Modify all of the columns to be NOT NULL.

ALTER TABLE films
  ALTER COLUMN title SET NOT NULL,
  ALTER COLUMN  "year" SET NOT NULL,
  ALTER COLUMN  genre SET NOT NULL,
  ALTER COLUMN  director SET NOT NULL,
  ALTER COLUMN  duration SET NOT NULL;

3. How does modifying a column to be NOT NULL affect how it is displayed by \d
films?

In the "nullable" attribute "not null" is displayed.

4. Add a constraint to the table films that ensures that all films have a unique
title.

ALTER TABLE films
  ADD CONSTRAINT unique_title UNIQUE (title);

5. How is the constraint added in #4 displayed by \d films?

Table "public.films"
Column  |          Type          | Collation | Nullable | Default
----------+------------------------+-----------+----------+---------
title    | character varying(255) |           | not null |
year     | integer                |           | not null |
genre    | character varying(100) |           | not null |
director | character varying(255) |           | not null |
duration | integer                |           | not null |
Indexes:
"unique_title" UNIQUE CONSTRAINT, btree (title)

6. Write a SQL statement to remove the constraint added in #4.

ALTER TABLE films
  DROP CONSTRAINT unique_title;

7. Add a constraint to films that requires all rows to have a value for title
that is at least 1 character long.

ALTER TABLE films
  ADD CONSTRAINT min_title_length
  CHECK (length(title) >= 1);

8. What error is shown if the constraint created in #7 is violated? Write a SQL
INSERT statement that demonstrates this.

INSERT INTO films
  VALUES ("", 2018, "garbage in", "garbage out", 210);

  ERROR:  zero-length delimited identifier at or near """"

9. How is the constraint added in #7 displayed by \d films?

Check constraints:
    "min_title_length" CHECK (length(title::text) >= 1)

10. Write a SQL statement to remove the constraint added in #7.

ALTER TABLE films
  DROP CONSTRAINT min_title_length;

11. Add a constraint to the table films that ensures that all films have a year
between 1900 and 2100.

ALTER TABLE films
  ADD CONSTRAINT year_bounds
  CHECK ("year" BETWEEN 1900 AND 2100);

12. How is the constraint added in #11 displayed by \d films?

Check constraints:
    "year_bounds" CHECK (year >= 1900 AND year <= 2100)

13. Add a constraint to films that requires all rows to have a value for
director that is at least 3 characters long and contains at least one space
character ().

ALTER TABLE films
  ADD CONSTRAINT director_name_form
  CHECK (length(director) >= 3
  AND director LIKE '% %');

14. How does the constraint created in #13 appear in \d films?

"director_name_form" CHECK (length(director::text) >= 3 AND director::text ~~ '% %'::text)

15. Write an UPDATE statement that attempts to change the director for
"Die Hard" to "Johnny". Show the error that occurs when this statement is
executed.

UPDATE films
  SET director = 'Johnny'
  WHERE title = 'Die Hard';

ERROR:  new row for relation "films" violates check constraint "director_name_form"

16. List three ways to use the schema to restrict what values can be stored in a
column.

TYPE <type>; NOT NULL; CHECK (<constraint>)

17. Is it possible to define a default value for a column that will be
considered invalid by a constraint? Create a table that tests this.

Yes:

CREATE TABLE hello(
  hi INTEGER,
  CHECK (hi > 0)
);

ALTER TABLE hello
  ALTER COLUMN hi
  SET DEFAULT 0;

\d hello

  Table "public.hello"
Column |  Type   | Collation | Nullable | Default
--------+---------+-----------+----------+---------
hi     | integer |           |          | 0
Check constraints:
"hello_hi_check" CHECK (hi > 0)


INSERT INTO hello (hi)
  VALUES (DEFAULT);

  ERROR:  new row for relation "hello" violates check constraint "hello_hi_check"
  DETAIL:  Failing row contains (0).

18. How can you see a list of all of the constraints on a table?

\d films

Column  |          Type          | Collation | Nullable | Default
----------+------------------------+-----------+----------+---------
title    | character varying(255) |           | not null |
              ...                       ...
duration | integer                |           | not null |
Indexes:
  "unique_title" UNIQUE CONSTRAINT, btree (title)
Check constraints:
  "director_name_form" CHECK (length(director::text) >= 3 AND director::text ~~ '% %'::text)
  "year_bounds" CHECK (year >= 1900 AND year <= 2100)
