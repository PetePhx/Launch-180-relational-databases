1. Create a Database

Let''s start by creating a database. Create a new database called animals.

  CREATE DATABASE animals;

2. Create a Table

Now that we have an animals database, we can lay the groundwork needed to add
some data to it.

Make a table called birds. It should have the following fields:

id (a primary key)
name (string with space for up to 25 characters)
age (integer)
species (string with space for up to 15 characters)

  CREATE TABLE birds(
    id serial PRIMARY KEY,
    name varchar(25),
    age int,
    species varchar(15)
  );

3. Insert Data

For this exercise, we''ll add some data to our birds table. Add five records to
this database so that our data looks like:

 id |   name   | age | species
----+----------+-----+---------
  1 | Charlie  |   3 | Finch
  2 | Allie    |   5 | Owl
  3 | Jennifer |   3 | Magpie
  4 | Jamie    |   4 | Owl
  5 | Roy      |   8 | Crow
(5 rows)

  INSERT INTO birds (name, age, species)
  VALUES ('Charlie', 3, 'Finch'),
  ('Allie', 5, 'Owl'),
  ('Jennifer', 3, 'Magpie'),
  ('Jamie', 4, 'Owl'),
  ('Roy', 8, 'Crow');

  Further Exploration

  There is a form of INSERT INTO that doesn''t require the column names. How
  does that form of INSERT INTO work, and when would you use it?

    When we supply all column values in the same order as in the table, we won''t
    need to provide column names.

4. Write an SQL statement to query all data that is currently in our birds
table.

  SELECT * FROM birds;

   id |   name   | age | species
  ----+----------+-----+---------
    1 | Charlie  |   3 | Finch
    2 | Allie    |   5 | Owl
    3 | Jennifer |   3 | Magpie
    4 | Jamie    |   4 | Owl
    5 | Roy      |   8 | Crow
  (5 rows)


5. WHERE Clause

In this exercise, let''s practice filtering the data we want to query. Using a
WHERE clause, SELECT records for birds under the age of 5.

  SELECT * FROM birds WHERE age < 5;

  id |   name   | age | species
  ---+----------+-----+---------
   1 | Charlie  |   3 | Finch
   3 | Jennifer |   3 | Magpie
   4 | Jamie    |   4 | Owl
  (3 rows)


6. Update Data

It seems there was a mistake when we were inserting data in the birds table. One
of the rows has a species of 'Crow', but that bird is actually a Raven. Update
the birds table so that a row with a species of 'Crow' now reads 'Raven'.

  UPDATE birds
  SET species = 'Raven'
  WHERE species = 'Crow';

 Further Exploration
  Oops. Jamie isnt an Owl - hes a Hawk. Correct his information.

  UPDATE birds
  SET species = 'Hawk'
  WHERE name = 'Jamie';


7. Delete Data

Write an SQL statement that deletes the record that describes a 3 year-old
finch.

  DELETE FROM birds
  WHERE age = 3
  AND species = 'Finch';

8. Add Constraint

When we initially created our birds table, we forgot to take into account a key
factor: preventing certain values from being entered into the database. For
instance, we would never find a bird that is negative n years old. We could have
included a constraint to ensure that bad data isn''t entered for a database
record, but we forgot to do so.

For this exercise, write some code that ensures that only birds with a positive
age may be added to the database. Then write and execute an SQL statement to
check that this new constraint works correctly.

  ALTER TABLE birds
  ADD CONSTRAINT check_age CHECK ( age >= 0 );

  INSERT INTO birds (name, age, species) VALUES ('Hi', -3.45, 'Hello');
  -- ERROR:  new row for relation "birds" violates check constraint "check_age"
  -- DETAIL:  Failing row contains (7, Hi, -3, Hello).


9. Drop Table

It seems we are done with our birds table, and no longer have a need for it in
our animals database. Write an SQL statement that will drop the birds table and
all its data from the animals database.

  DROP TABLE birds;


10. Drop Database

Let''s finish things up by dropping the database animals. With no tables in it,
we don''t have much use for it any more. Write a SQL statement or PostgreSQL
command to drop the animals database.

  \c user -- to disconnect from animals database
  DROP DATABASE animals;

  (or from the terminal: dropdb animals)
