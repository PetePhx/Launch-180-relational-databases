1. Write a SQL statement to add the following call data to the database:

when 	                duration 	first_name 	last_name 	number
2016-01-18 14:47:00 	632 	    William 	  Swift 	    7204890809

INSERT INTO calls ("when", duration, contact_id)
  VALUES ('2016-01-18 14:47:00'::timestamp, 632, 6);


2. Write a SQL statement to retrieve the call times, duration, and first name
for all calls not made to William Swift.

SELECT "when" AS "call time",
       duration,
       first_name AS "first name"
  FROM calls INNER JOIN contacts
  ON calls.contact_id = contacts.id
  WHERE first_name <> 'William'
  OR last_name <> 'Swift';

  call time         | duration | first name
---------------------+----------+------------
2016-01-08 15:30:00 |      350 | Yuan
2016-01-11 11:06:00 |      111 | Tamila
2016-01-13 18:13:00 |     2521 | Tamila
2016-01-17 09:43:00 |      982 | Yuan


3. Write SQL statements to add the following call data to the database:

when 	                duration 	first_name 	last_name 	number
2016-01-17 11:52:00 	175 	    Merve 	     Elk 	      6343511126
2016-01-18 21:22:00 	79 	      Sawa 	       Fyodorov 	6125594874

INSERT INTO contacts (first_name, last_name, number)
  VALUES ('Merve', 'Elk', 6343511126),
         ('Sawa', 'Fyodorov', 6125594874);

INSERT INTO calls ("when", duration, contact_id)
  VALUES ('2016-01-17 11:52:00 ', 175, 26),
         ('2016-01-18 21:22:00', 79, 27);


4. Add a constraint to contacts that prevents a duplicate value being added in
the column number.

ALTER TABLE contacts
  ADD CONSTRAINT unique_number UNIQUE (number);

5. Write a SQL statement that attempts to insert a duplicate number for a new
contact but fails. What error is shown?

INSERT INTO contacts (first_name, last_name, number)
  VALUES ('Fyodor', 'Dostoyevsky', 6125594874);

  ERROR:  duplicate key value violates unique constraint "unique_number"
  DETAIL:  Key (number)=(6125594874) already exists.


6. Why does "when" need to be quoted in many of the queries in this lesson?

 `when` is a reserved word in postgresql and SQL standards.


7. Draw an entity-relationship diagram for the data we''ve been working with in
this assignment.

            +---------------+
            |     calls     |
            +---------------+
                   \|/
                    o
                    |
                    -
                    |
            +---------------+
            |    contacts   |
            +---------------+
