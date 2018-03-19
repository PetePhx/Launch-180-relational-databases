1. From the Terminal, create a database called database_one.

  $ createdb database_one

2. From the Terminal, connect via the psql console to the database that you
created in the previous question.

  $ psql -d database_one

  psql (10.3 (Ubuntu 10.3-1.pgdg16.04+1), server 9.5.12)
  Type "help" for help.

  database_one=#

3. From the psql console, create a database called database_two.

database_one=# CREATE DATABASE database_two;
CREATE DATABASE

4. From the psql console, connect to database_two.

database_one=# \connect database_two
psql (10.3 (Ubuntu 10.3-1.pgdg16.04+1), server 9.5.12)
You are now connected to database "database_two" as user "user".
database_two=#

5. Display all of the databases that currently exist.

database_two=# \list
                                      List of databases
       Name        |  Owner   | Encoding |   Collate   |    Ctype    |   Access privileges
-------------------+----------+----------+-------------+-------------+-----------------------
 database_one      | user     | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 database_two      | user     | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 ls_burger         | user     | UTF8     | en_US.UTF-8 | en_US.UTF-8 |

                                        ...

 sql_book          | user     | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0         | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
                   |          |          |             |             | postgres=CTc/postgres
 template1         | postgres | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
                   |          |          |             |             | postgres=CTc/postgres
 user              | user     | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
(11 rows)


6. From the psql console, delete database_two.

  First we need to disconnect by connecting to another database, and then
  issuing the DROP DATABASE command:

  database_two=# \c database_one
  psql (10.3 (Ubuntu 10.3-1.pgdg16.04+1), server 9.5.12)
  You are now connected to database "database_one" as user "user".
  database_one=#
  database_one=# DROP DATABASE database_two;
  DROP DATABASE

7. From the Terminal, delete the database_one and ls_burger databases.

  $ dropdb database_one

  $ dropdb ls_burger
