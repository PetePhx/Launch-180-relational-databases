1. Describe the difference between the varchar and text data types.

  varchar is a standard SQL type, while text is a postgresql data type.

  varchar with an argument (e.g varchar(5)) stores up to a certain limit of
  characters, but the text storage limit is practically unlimited (>1 GB).

2. Describe the difference between the integer, decimal, and real data types.

  integer can only store whole numbers between -2^31 and 2^31 - 1
  decimal/numeric can store numbers with a given precision and scale
    (significant digits and digits after the decimal point)
  real is a floating-point data type with variable-precision and inexact
    representation. It also includes Infinity, -Infinity, and NaN.

3. What is the largest value that can be stored in an integer column?

  SELECT -2^31 AS smallest_int, 2^31 AS largest_int;

   smallest_int | largest_int
  --------------+-------------
    -2147483648 |  2147483648

4. Describe the difference between the timestamp and date data types.

  timestamp includes both date and time information, while date only includes
  date information (year-month-date)

  SELECT '2018-03-28 12:41:00'::timestamp, '2018-03-28 12:41:00'::date;

        timestamp      |    date
  ---------------------+------------
   2018-03-28 12:41:00 | 2018-03-28
  (1 row)


5. Can a time with a time zone be stored in a column of type timestamp?

  Not with the original timestamp data type:

  SELECT '2018-03-28 12:46:00 PST'::timestamp;
        timestamp
  ---------------------
   2018-03-28 12:46:00
  (1 row)

  But we can use `timestamp with time zone` to include the time zone:

  SELECT '2018-03-28 12:46:00'::timestamp with time zone;
      timestamptz
  ------------------------
   2018-03-28 13:46:00-07
  (1 row)
