
Create an Extrasolar Planetary Database

For this exercise set, we will be working with the DDL statements to create and
modify tables in a database that tracks planets around stars other than our Sun.
To get started, first create a postgresql database named "extrasolar", and then
create two tables in the database as follows:

stars table

  id: a unique serial number that auto-increments and serves as a primary key
  for this table.

  name: the name of the star,e,g., "Alpha Centauri A". Allow room for 25
  characters. Must be unique and non-null.

  distance: the distance in light years from Earth. Define this is a whole
  number (e.g., 1, 2, 3, etc) that must be non-null and greater than 0.

  spectral_type: the spectral type of the star: O, B, A, F, G, K, and M. Use a
  one character string.

  companions: how many companion stars does the star have? A whole number will
  do. Must be non-null and non-negative.

planets table

  id: a unique serial number that auto-increments and serves as a primary key
  for this table.

  designation: a single alphabetic character that uniquely identifies the planet
  in its star system ('a', 'b', 'c', etc.)

  mass: estimated mass in terms of Jupiter masses; use an integer for this
  value.

Note:

Several of these exercises include Further Exploration sections: more so than
normal, we highly recommend tackling these problems. All of them deal with how
to alter a database''s schema when the database already contains data; this
sometimes requires additional work beyond just the statement provided in the
main problem solution.


CREATE DATABASE extrasolar;

\d extrasolar

CREATE TABLE stars (
  id SERIAL PRIMARY KEY,
  name VARCHAR(25) UNIQUE NOT NULL,
  distance INTEGER NOT NULL
    CHECK (distance > 0),
  spectral_type CHAR(1),
  companions INTEGER NOT NULL
    CHECK (companion >= 0)
);

CREATE TABLE planets (
  id SERIAL PRIMARY KEY,
  designation CHAR(1),
  mass INTEGER
);
