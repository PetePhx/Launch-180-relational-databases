Add a Semi-Major Axis Column

Add a semi_major_axis column for the semi-major axis of each planet''s orbit;
the semi-major axis is the average distance from the planet''s star as measured
in astronomical units (1 AU is the average distance of the Earth from the Sun).
Use a data type of numeric, and require that each planet have a value for the
semi_major_axis.


ALTER TABLE planets
  ADD COLUMN semi_major_axis NUMERIC NOT NULL;


Further Exploration

Assume the planets table already contains one or more rows of data. What will
happen when you try to run the above command? What will you need to do
differently to obtain the desired result?

ALTER TABLE planets
DROP COLUMN semi_major_axis;

DELETE FROM stars;
INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Alpha Centauri B', 4.37, 'K', 3);
INSERT INTO stars (name, distance, spectral_type, companions)
           VALUES ('Epsilon Eridani', 10.5, 'K', 0);

INSERT INTO planets (designation, mass, star_id)
           VALUES ('b', 0.0036, 1); -- check star_id; see note below
INSERT INTO planets (designation, mass, star_id)
           VALUES ('c', 0.1, 2); -- check star_id; see note below

ALTER TABLE planets
ADD COLUMN semi_major_axis numeric NOT NULL;

`ERROR:  column "semi_major_axis" contains null values`

Error is raised when we try to enforce NOT NULL for columns with existing rows
that have corresponding NULL values.

To fix this, we need to first enter the semi_major_axis data for the two
planets before enforcing the NOT NULL constraint:

ALTER TABLE planets
  ADD COLUMN semi_major_axis numeric;

UPDATE planets
  SET semi_major_axis = 0.04 WHERE star_id = 1;

UPDATE planets
  SET semi_major_axis = 40 WHERE star_id = 2;

ALTER TABLE planets
  ALTER COLUMN semi_major_axis
    SET NOT NULL;

extrasolar=# \d planets
                                   Table "public.planets"
     Column      |     Type     | Collation | Nullable |               Default
-----------------+--------------+-----------+----------+-------------------------------------
 id              | integer      |           | not null | nextval('planets_id_seq'::regclass)
 designation     | character(1) |           | not null |
 mass            | numeric      |           | not null |
 star_id         | integer      |           | not null |
 semi_major_axis | numeric      |           | not null |
Indexes:
    "planets_pkey" PRIMARY KEY, btree (id)
Check constraints:
    "planets_mass_check" CHECK (mass > 0::numeric)
Foreign-key constraints:
    "planets_star_id_fkey" FOREIGN KEY (star_id) REFERENCES stars(id)
