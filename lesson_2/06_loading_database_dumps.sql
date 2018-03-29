1. Load this file into your database.
      DROP TABLE IF EXISTS public.films;
      CREATE TABLE films (title varchar(255), year integer, genre varchar(100));

      INSERT INTO films(title, year, genre) VALUES ('Die Hard', 1988, 'action');
      INSERT INTO films(title, year, genre) VALUES ('Casablanca', 1942, 'drama');
      INSERT INTO films(title, year, genre) VALUES ('The Conversation', 1974, 'thriller');

  a. What does the file do?
    First it removes the table films if it exists, then creates the table films
    with columns title, year and genre. Next it inserts row for the three movies
    into the films table.

  b. What is the output of the command? What does each line in this output mean?

  sql_book=# \i file.sql

    psql:file.sql:1: NOTICE:  table "films" does not exist, skipping
    DROP TABLE
    CREATE TABLE
    INSERT 0 1
    INSERT 0 1
    INSERT 0 1

  The first line is a warning that the table films did not exist. What follows
  are standard output messages for dropping a table, creating a table, and three
  insertions to the table.

  c. Open up the file and look at its contents. What does the first line do?

  it drops the table films if it exists.

2. Write a SQL statement that returns all rows in the films table.

  SELECT * FROM films;

       title       | year |  genre
 ------------------+------+----------
  Die Hard         | 1988 | action
  Casablanca       | 1942 | drama
  The Conversation | 1974 | thriller
  (3 rows)


3. Write a SQL statement that returns all rows in the films table with a title
shorter than 12 letters.

SELECT * FROM films
  WHERE LENGTH(title) < 12;

    title    | year | genre
  ------------+------+--------
  Die Hard   | 1988 | action
  Casablanca | 1942 | drama
  (2 rows)


4. Write the SQL statements needed to add two additional columns to the films
table: director, which will hold a director''s full name, and duration, which
will hold the length of the film in minutes.

ALTER TABLE films
  ADD COLUMN director VARCHAR(50),
  ADD COLUMN duration INTEGER;

\d films
                       Table "public.films"
 Column  |          Type          | Collation | Nullable | Default
----------+------------------------+-----------+----------+---------
title    | character varying(255) |           |          |
year     | integer                |           |          |
genre    | character varying(100) |           |          |
director | character varying(50)  |           |          |
duration | integer                |           |          |


5. Write SQL statements to update the existing rows in the database with values
for the new columns:
-- title 	            director 	          duration
-- Die Hard 	       John McTiernan 	      132
-- Casablanca 	     Michael Curtiz 	      102
-- The Conversation  Francis Ford Coppola 	113

UPDATE films
  SET director = 'John McTiernan', duration = 132
  WHERE title = 'Die Hard';

UPDATE films
  SET director = 'Michael Curtiz', duration = 102
  WHERE title = 'Casablanca';

UPDATE films
  SET director = 'Francis Ford Coppola', duration = 113
  WHERE title = 'The Conversation';


6. Write SQL statements to insert the following data into the films table:
-- title 	                      year 	genre 	    director 	         duration
-- 1984 	                      1956 	scifi 	    Michael Anderson 	  90
-- Tinker Tailor Soldier Spy 	  2011 	espionage 	Tomas Alfredson 	  127
-- The Birdcage 	              1996 	comedy 	    Mike Nichols 	     118

INSERT INTO films (title, "year", genre, director, duration)
  VALUES ('1984', 1956, 'scifi', 'Michael Anderson', 90),
         ('Tinker Tailor Soldier Spy', 2011, 'espionage', 'Tomas Alfredson', 127),
         ('The Birdcage', 1996, 'comedy', 'Mike Nichols', 118);


7. Write a SQL statement that will return the title and age in years of each
movie, with newest movies listed first:

SELECT title,
       DATE_PART('year', CURRENT_DATE) - "year" AS age
  FROM films
  ORDER BY age;

          title           | age
--------------------------+-----
Tinker Tailor Soldier Spy |   7
The Birdcage              |  22
Die Hard                  |  30
The Conversation          |  44
1984                      |  62
Casablanca                |  76
(6 rows)


8. Write a SQL statement that will return the title and duration of each movie
longer than two hours, with the longest movies first.

SELECT title, duration
  FROM films
  WHERE duration > 120
  ORDER BY duration DESC;

  title                   | duration
--------------------------+----------
Die Hard                  |      132
Tinker Tailor Soldier Spy |      127
(2 rows)


9. Write a SQL statement that returns the title of the longest film.

SELECT title
  FROM films
  ORDER BY duration DESC
  LIMIT 1;

  title
----------
 Die Hard
(1 row)
