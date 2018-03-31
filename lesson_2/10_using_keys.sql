1. Write a SQL statement that makes a new sequence called "counter".

CREATE SEQUENCE counter;

2. Write a SQL statement to retrieve the next value from the sequence created in
#1.

SELECT next_val('counter');

nextval
---------
      1
(1 row)

3. Write a SQL statement that removes a sequence called "counter".

DROP SEQUENCE counter;

4. Is it possible to create a sequence that returns only even numbers? The
documentation for sequence might be useful.

CREATE SEQUENCE double_counter INCREMENT BY 2;

sql_book=# SELECT nextval('double_counter');
 nextval
---------
       1
(1 row)

sql_book=# SELECT nextval('double_counter');
 nextval
---------
       3
(1 row)

sql_book=# SELECT nextval('double_counter');
 nextval
---------
       5
(1 row)

5. What will the name of the sequence created by the following SQL statement be?

CREATE TABLE regions (id serial PRIMARY KEY, name text, area integer);

6. Write a SQL statement to add an auto-incrementing integer primary key column to the films table.

7. What error do you receive if you attempt to update a row to have a value for id that is used by another row?

8. What error do you receive if you attempt to add another primary key column to the films table?

9. Write a SQL statement that modifies the table films to remove its primary key while preserving the id column and the values it contains.
