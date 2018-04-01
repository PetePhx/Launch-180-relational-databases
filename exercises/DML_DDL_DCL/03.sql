-- DML/DDL/DCL Part 3
--
-- Does the following statement use the DDL or DML component of SQL?

CREATE TABLE things (
  id serial PRIMARY KEY,
  item text NOT NULL UNIQUE,
  material text NOT NULL
);

Answer:

  Creating a table and the associated schema responsible for defining the data
  structure is part of the Data Definition Language. 
