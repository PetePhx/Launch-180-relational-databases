1. Make sure you are connected to the encyclopedia database. Add the following
data to the countries table:

Name 	Capital 	Population
France 	Paris 	67,158,000

  $ psql -d encyclopedia

  encyclopedia=# \d countries
                                     Table "public.countries"
   Column   |         Type          | Collation | Nullable |                Default
------------+-----------------------+-----------+----------+---------------------------------------
 id         | integer               |           | not null | nextval('countries_id_seq'::regclass)
 name       | character varying(50) |           | not null |
 capital    | character varying(50) |           | not null |
 population | integer               |           |          |


  =#  INSERT INTO countries (name, capital, population)
                  VALUES ('France', 'Paris', 67158000);


2. Now add the following additional data to the countries table:

Name 	Capital 	Population
USA 	Washington D.C. 	325,365,189
Germany 	Berlin 	82,349,400
Japan 	Tokyo 	126,672,000

=# INSERT INTO countries (name, capital, population)
                VALUES ('USA', 'Washington D.C.', 325365189),
                       ('Germany', 'Berlin', 82349400),
                       ('Japan', 'Tokyo', 126672000);

3. Add an entry to the celebrities table for the singer and songwriter Bruce
Springsteen, who was born on September 23rd 1949 and is still alive.

\d celebrities
                                        Table "public.celebrities"
    Column     |          Type          | Collation | Nullable |                  Default
---------------+------------------------+-----------+----------+-------------------------------------------
 id            | integer                |           | not null | nextval('famous_people_id_seq'::regclass)
 first_name    | character varying(80)  |           | not null |
 occupation    | character varying(150) |           |          |
 date_of_birth | date                   |           | not null |
 deceased      | boolean                |           |          | false
 last_name     | character varying(100) |           | not null |


  =#  INSERT INTO celebrities (first_name, last_name, date_of_birth, occupation)
                VALUES ('Bryce', 'Sprengstine', '1949-09-23', 'singer songwriter');


4. Add an entry for the actress Scarlett Johansson, who was born on November
22nd 1984. Use the default value for the deceased column.

  =#  INSERT INTO celebrities (first_name, last_name, date_of_birth, occupation)
            VALUES ('Crimson', 'Josephson', '1984-11-22', 'actress');

5. Add the following two entries to the celebrities table with a single INSERT statement. For Frank Sinatra set true as the value for the deceased column. For Tom Cruise, don't set an explicit value for the deceased column, but use the default value.
First Name 	Last Name 	Occupation 	D.O.B.
Frank 	Sinatra 	Singer, Actor 	December 12, 1915
Tom 	Cruise 	Actor 	July 03, 1962

=# INSERT INTO celebrities (first_name, last_name, date_of_birth, occupation)
          VALUES ('Phrank', 'Cinatra', '1915-12-12', 'singer actor'),
                 ('Tomme', 'Kruze', '1962-07-03', 'actor');


6. Look at the schema of the celebrities table. What do you think will happen if
we try to insert the following data?
First Name 	Last Name 	Occupation 	D.O.B. 	Deceased
Madonna 		Singer, Actress 	'08/16/1958' 	false
Prince 		Singer, Songwriter, Musican, Actor 	'06/07/1958' 	true

  Since the last_name column has no default value, the DBMS will raise an error.

  =#  INSERT INTO celebrities (first_name, date_of_birth, occupation)
            VALUES ('Madonna', '1984-11-22', 'actress');

      ERROR:  null value in column "last_name" violates not-null constraint
      DETAIL:  Failing row contains (5, Madonna, actress, 1984-11-22, f, null).


7. Check the schema of the celebrities table. What would happen if we specify a
NULL value for deceased column, such as with the data below?
First Name 	Last Name 	Occupation 	D.O.B. 	Deceased
Elvis 	Presley 	Singer, Musican, Actor 	'01/08/1935' 	NULL

  The deceased column does not have a NOT NULL constraint, therefore we expect
  the DBMS to accept the data.

  =#  INSERT INTO celebrities (first_name, last_name, occupation, date_of_birth, deceased)
            VALUES ('Elvis', 'Presley', 'musician, actor', '1935-01-08', NULL);

  INSERT 0 1


8. Check the schema of the animals table. What would happen if we tried to insert the following data to the table?
Name 	Binomial Name 	Max Weight (kg) 	Max Age (years) 	Conservation Status
Dove 	Columbidae Columbiformes 	2 	15 	LC
Golden Eagle 	Aquila Chrysaetos 	6.35 	24 	LC
Peregrine Falcon 	Falco Peregrinus 	1.5 	15 	LC
Pigeon 	Columbidae Columbiformes 	2 	15 	LC
Kakapo 	Strigops habroptila 	4 	60 	CR

Identify the problem and alter the table so that the data can be entered as shown,
and then insert the data.

  The table has the constraint unique_binomial_name for uniqueness of binomial
  names. In order to be able to insert both 'Dove' and 'Pigeon' rows, we need to
  first remove the constraint:

  ERROR:  duplicate key value violates unique constraint "unique_binomial_name"
  DETAIL:  Key (binomial_name)=(Columbidae Columbiformes) already exists.

  =# ALTER TABLE animals DROP CONSTRAINT unique_binomial_name;

  =# INSERT INTO animals (name, binomial_name, max_weight_kg, max_age_years, conservation_status)
     VALUES ('Dove', 'Columbidae Columbiformes', 2, 15, 'LC'),
            ('Golden Eagle', 'Aquila Chrysaetos', 6.35, 24, 'LC'),
            ('Peregrine Falcon', 'Falco Peregrinus', 1.5, 15, 'LC'),
            ('Pigeon', 'Columbidae Columbiformes', 2, 15, 'LC'),
            ('Kakapo', 'Strigops habroptila', 4, 60, 'CR');

INSERT 0 5



10. Connect to the ls_burger database and examine the schema for the orders table.

Based on the table schema and following information, write and execute an INSERT
statement to add the appropriate data to the orders table.

There are three customers -- James Bergman, Natasha O'Shea, Aaron Muller. James'
email address is james1998@email.com. Natasha's email address is
natasha@osheafamily.com. Aaron doesn't supply an email address.

James orders a LS Chicken Burger, Fries and a Cola.

Natasha has two orders --
an LS Cheeseburger with Fries but no drink, and
an LS Double Deluxe Burger with Onion Rings and a Chocolate Shake.

Aaron orders an LS Burger with no side or
drink.

The item costs and loyalty points are listed below:
Item 	Cost ($) 	Loyalty Points
LS Burger 	3.00 	10
LS Cheeseburger 	3.50 	15
LS Chicken Burger 	4.50 	20
LS Double Deluxe Burger 	6.00 	30
Fries 	0.99 	3
Onion Rings 	1.50 	5
Cola 	1.50 	5
Lemonade 	1.50 	5
Vanilla Shake 	2.00 	7
Chocolate Shake 	2.00 	7
Strawberry Shake 	2.00 	7

=# INSERT INTO orders (customer_name, customer_email, burger, burger_cost,
           side, side_cost, drink,drink_cost, customer_loyalty_points)
  VALUES ('James Bergman', 'james1998@email.com', 'LS Chicken Burger', 4.50,
  'Fries', 0.99, 'Cola', 1.50, 28),
  ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Cheeseburger', 3.50,
  'Fries', 0.99, NULL, 0, 18),
  ('Natasha O''Shea', 'natasha@osheafamily.com', 'LS Deluxe Burger', 6.00,
  'Onion Rings', 1.50, 'Chocolate Shake', 2.00, 42),
  ('Aaron Muller', NULL, 'LS Burger', 3.00, NULL, 0, NULL, 0, 10);

  INSERT 0 4
