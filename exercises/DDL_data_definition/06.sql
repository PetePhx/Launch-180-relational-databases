Enumerated Types

In the previous exercise, we added a CHECK constraint to the stars table to
enforce that the value stored in the spectral_type column for each row is valid.
In this exercise, we will use an alternate approach to the same problem.

PostgreSQL provides what is called an enumerated data type; that is, a data type
that must have one of a finite set of values. For instance, a traffic light can
be red, green, or yellow: these are enumerate values for the color of the
currently lit signal light.

Modify the stars table to remove the CHECK constraint on the spectral_type
column, and then modify the spectral_type column so it becomes an enumerated
type that restricts it to one of the following 7 values: 'O', 'B', 'A', 'F',
'G', 'K', and 'M'.

ALTER TABLE stars
  DROP CONSTRAINT stars_spectral_type_check;

CREATE TYPE spectral_enum AS ENUM ( 'O', 'B', 'A', 'F', 'G', 'K', 'M');

ALTER TABLE stars
  ALTER COLUMN spectral_type TYPE spectral_enum
  USING spectral_type::spectral_enum;

extrasolar=# \d stars

                                       Table "public.stars"
    Column     |         Type          | Collation | Nullable |              Default
---------------+-----------------------+-----------+----------+-----------------------------------
 id            | integer               |           | not null | nextval('stars_id_seq'::regclass)
 name          | character varying(50) |           | not null |
 distance      | numeric               |           | not null |
 spectral_type | spectral_enum         |           | not null |
 companions    | integer               |           | not null |
Indexes:
    "stars_pkey" PRIMARY KEY, btree (id)
    "stars_name_key" UNIQUE CONSTRAINT, btree (name)
Check constraints:
    "stars_companion_check" CHECK (companions >= 0)
    "stars_distance_check" CHECK (distance > 0::numeric)
Referenced by:
    TABLE "planets" CONSTRAINT "planets_star_id_fkey" FOREIGN KEY (star_id) REFERENCES stars(id)
