-- DML/DDL/DCL Part 4
--
-- Does the following statement use the DDL or DML component of SQL?

ALTER TABLE things
DROP CONSTRAINT things_item_key;

Answer:

  Both `ALTER` and `DROP` deal with changing the structure of the data in a
  table/database. Although they might change/remove actual data in the process
  as side effects, they belong to Data Definitino Language component of SQL. 
