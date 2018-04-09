1. Write the SQL statements necessary to create a schema that will hold the data
for lists and todos as described above. Include any constraints that are
appropriate.

  List

    Has a unique name

  Todo

    Has a name
    Belongs to a list
    Can be completed, but should default to not being completed


  CREATE TABLE lists (
    id SERIAL PRIMARY KEY,
    name VARCHAR UNIQUE
  );

  CREATE TABLE todos(
    id SERIAL PRIMARY KEY,
    list_id INTEGER NOT NULL REFERENCES lists(id),
    name VARCHAR NOT NULL,
    completed BOOLEAN NOT NULL DEFAULT FALSE
  );


2. Create a new file, schema.sql, in the project directory. Save the statements
written in #1 in this file.

~/Launch/todo_app/schema.sql

3. Create a new database for this project called todos. Execute the SQL file
created in #2 in this database using psql.

  user@Ubuntu16:~/Launch/todo_app$ createdb todos

  user@Ubuntu16:~/Launch/todo_app$ psql todos < schema.sql
  CREATE TABLE
  CREATE TABLE
