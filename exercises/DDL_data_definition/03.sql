Increase Star Name Length

Hmm... it turns out that 25 characters isn''t enough room to store a star''s
complete name. For instance, the star "Epsilon Trianguli Australis A" requires
30 characters. Modify the column so that it allows star names as long as 50
characters.

ALTER TABLE stars
  ALTER COLUMN name
  TYPE VARCHAR(50);


Further Exploration

Assume the stars table already contains one or more rows of data. What will
happen when you try to run the above command? To test this, revert the
modification and add a row or two of data:

ALTER TABLE stars
ALTER COLUMN name TYPE varchar(25);

INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Centauri B', 4, 'K', 3);

ALTER TABLE stars
ALTER COLUMN name TYPE varchar(50);

  Answer: The modification proceeds without any problem.

extrasolar=# \d stars
                                       Table "public.stars"
    Column     |         Type          | Collation | Nullable |              Default
---------------+-----------------------+-----------+----------+-----------------------------------
 id            | integer               |           | not null | nextval('stars_id_seq'::regclass)
 name          | character varying(50) |           | not null |
 distance      | integer               |           | not null |
 spectral_type | character(1)          |           |          |
 companions    | integer               |           | not null |
Indexes:
    "stars_pkey" PRIMARY KEY, btree (id)
    "stars_name_key" UNIQUE CONSTRAINT, btree (name)
Check constraints:
    "stars_companion_check" CHECK (companions >= 0)
    "stars_distance_check" CHECK (distance > 0)
Referenced by:
    TABLE "planets" CONSTRAINT "planets_star_id_fkey" FOREIGN KEY (star_id) REFERENCES stars(id)
