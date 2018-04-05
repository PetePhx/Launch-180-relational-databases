1. Import this file into a database using psql.

\i films_directors.sql


2. Write a SQL statement that will add a primary key column to films.

ALTER TABLE films
  ADD COLUMN id SERIAL PRIMARY KEY;


3. Write the SQL statement needed to create a join table that will allow a film
to have multiple directors, and directors to have multiple films. Include an id
column in this table, and add foreign key constraints to the other columns.

CREATE TABLE directors_films (
  id SERIAL PRIMARY KEY,
  director_id INTEGER NOT NULL REFERENCES directors (id),
  film_id INTEGER NOT NULL REFERENCES films (id)
);


4. Write the SQL statements needed to insert data into the new join table to
represent the existing one-to-many relationships.

INSERT INTO directors_films (director_id, film_id)
  VALUES (1, 1),
         (2, 2),
         (3, 3),
         (4, 4),
         (5, 5),
         (6, 6),
         (3, 7),
         (7, 8),
         (8, 9),
         (4, 10);


5. Write a SQL statement to remove any unneeded columns from films.

ALTER TABLE films
  DROP COLUMN director_id;


6. Write a SQL statement that will return the following result:

           title           |         name
---------------------------+----------------------
 12 Angry Men              | Sidney Lumet
 1984                      | Michael Anderson
 Casablanca                | Michael Curtiz
 Die Hard                  | John McTiernan
 Let the Right One In      | Michael Anderson
 The Birdcage              | Mike Nichols
 The Conversation          | Francis Ford Coppola
 The Godfather             | Francis Ford Coppola
 Tinker Tailor Soldier Spy | Tomas Alfredson
 Wayne''s World             | Penelope Spheeris
(10 rows)

SELECT films.title, directors.name
  FROM films INNER JOIN directors_films
    ON films.id = directors_films.film_id
  INNER JOIN directors
    ON directors.id = directors_films.director_id
  ORDER BY films.title;


7. Write SQL statements to insert data for the following films into the database:

Film 	      Year 	Genre 	Duration 	Directors
-------------------------------------------------------------------------
Fargo 	       1996 	comedy 	98 	Joel Coen
No Country for Old Men 	2007 	western 	122 	Joel Coen, Ethan Coen
Sin City 	    2005 	crime 	124 	Frank Miller, Robert Rodriguez
Spy Kids 	    2001 	scifi 	88 	Robert Rodriguez

INSERT INTO directors (id, name)
  VALUES (9, 'Joel Coen'),
         (10, 'Ethan Coen'),
         (11, 'Frank Miller'),
         (12, ' Robert Rodriguez');

INSERT INTO films (id, title, "year", genre, duration)
  VALUES (11, 'Fargo', 1996, 'comedy', 98),
         (12, 'No Country for Old Me', 2007, 'western', 122),
         (13, 'Sin City', 2005, 'crime', 124),
         (14, 'Spy Kids', 2001, 'scifi', 88);

INSERT INTO directors_films (director_id, film_id)
  VALUES (9, 11),
         (9, 12),
         (10, 12),
         (11, 13),
         (12, 13),
         (12, 14);

8. Write a SQL statement that determines how many films each director in the
database has directed. Sort the results by number of films (greatest first) and
then name (in alphabetical order).

SELECT directors.name AS "director",
       count(directors_films.film_id) AS "films"
  FROM directors INNER JOIN directors_films
    ON directors.id = directors_films.director_id
  GROUP BY directors.name
  ORDER BY "films" DESC, "director";

      director       | films
----------------------+-------
Francis Ford Coppola |     2
Joel Coen            |     2
Michael Anderson     |     2
Robert Rodriguez     |     2
Ethan Coen           |     1
Frank Miller         |     1
John McTiernan       |     1
Michael Curtiz       |     1
Mike Nichols         |     1
Penelope Spheeris    |     1
Sidney Lumet         |     1
Tomas Alfredson      |     1
(12 rows)
