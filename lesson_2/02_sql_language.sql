1. What kind of programming language is SQL?

  A special-purpose, declarative language used for interacting with relational
  databases.

2. What are the three sublanguages of SQL?

  Data Definition Language
  Data Manipulation Language
  Data Control Langugage

3. Write the following values as quoted string values that could be used in a
SQL query.

-- canoe
  'canoe'
-- a long road
  'a long road'
-- weren't
  'were''nt'
-- "No way!"
  '"No way!"'

4. What operator is used to concatenate strings?

  ||

  SELECT 'a' || 'b' ;
   ?column?
  ----------
   ab
  (1 row)

5. What function returns a lowercased version of a string? Write a SQL statement
using it.

  lower

  SELECT lower('HeLlO tHeRe');
    lower
  -------------
  hello there
  (1 row)

6. How does the psql console display true and false values?

  t and f, respectively:

  SELECT true, false;
   bool | bool
  ------+------
   t    | f
  (1 row)


7. The surface area of a sphere is calculated using the formula A = 4π r2, where
A is the surface area and r is the radius of the sphere.

Use SQL to compute the surface area of a sphere with a radius of 26.3cm,
truncated to return an integer.

  SELECT floor(4 * pi() * 26.3 ^ 2) AS "area (cm^2)";

   area (cm^2)
  -------------
      8692
  (1 row)
