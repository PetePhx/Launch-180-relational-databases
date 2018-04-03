1. Import this file into an empty PostgreSQL database. Note: the file contains a
lot of data and may take a while to run; your terminal should return to the
command prompt once the import is complete.

  $ createdb lesson_3
  $ psql lesson_3 < tickets.sql

2. Write a query that determines how many tickets have been sold.

   SELECT count(id) AS "Number of Tickets Sold"
    FROM tickets;

    Number of Tickets Sold
   ------------------------
                      3783
   (1 row)


3. Write a query that determines how many different customers purchased tickets
to at least one event.

  SELECT count(DISTINCT customer_id)
    AS "Number of Distinct Customers"
    FROM tickets;

    Number of Distinct Customers
   ------------------------------
                            1652
   (1 row)


4. Write a query that determines what percentage of the customers in the
database have purchased a ticket to one of the events.

-- subquery:

SELECT round(100 * count(DISTINCT customer_id) /
  (SELECT count(id) * 1.0 FROM customers), 2)
  AS "Percentage of Customers Who Bought At Least One Ticket"
  FROM tickets;

  Percentage of Customers Who Bought At Least One Ticket
--------------------------------------------------------
                                                 16.52
(1 row)

-- left outer join:

SELECT round(100 * count(DISTINCT tickets.customer_id) /
    (count(DISTINCT customers.id)::NUMERIC(8, 2)), 2)
  AS "Percentage of Customers Who Bought At Least One Ticket"
  FROM customers LEFT OUTER JOIN tickets
  ON customers.id = tickets.customer_id;

  Percentage of Customers Who Bought At Least One Ticket
--------------------------------------------------------
                                                 16.52
(1 row)


5. Write a query that returns the name of each event and how many tickets were
sold for it, in order from most popular to least popular.

SELECT events.name AS "Event Name",
       count(tickets.id) AS "Tickets Sold"
  FROM events LEFT OUTER JOIN tickets
  ON events.id = tickets.event_id
  GROUP BY "Event Name"
  ORDER BY "Tickets Sold" DESC;

        Event Name         | Tickets Sold
----------------------------+--------------
A-Bomb                     |          555
Captain Deadshot Wolf      |          541
Illustrious Firestorm      |          521
Siren I                    |          457
Kool-Aid Man               |          439
Green Husk Strange         |          414
Ultra Archangel IX         |          359
Red Hope Summers the Fated |          307
Magnificent Stardust       |          134
Red Magus                  |           56
(10 rows)


6. Write a query that returns the user id, email address, and number of events
for all customers that have purchased tickets to three events.

SELECT customers.id AS "user id",
       customers.email,
       count(DISTINCT events.id) AS "number of events"
  FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id
    INNER JOIN events ON events.id = tickets.event_id
  GROUP BY "user id"
  HAVING count(DISTINCT events.id) >= 3;

user id |                email                 | number of events
---------+--------------------------------------+------------------
  141 | isac.hayes@herzog.net                |                3
  326 | tatum.mraz@schinner.org              |                3
  624 | adelbert.yost@kleinwisozk.io         |                3
 1719 | lionel.feeney@metzquitzon.biz        |                3
 2058 | angela.ruecker@reichert.co           |                3
 3173 | audra.moore@beierlowe.biz            |                3
 4365 | ephraim.rath@rosenbaum.org           |                3
 6193 | gennaro.rath@mcdermott.co            |                3
 7175 | yolanda.hintz@binskshlerin.com       |                3
 7344 | amaya.goldner@stoltenberg.org        |                3
 7975 | ellen.swaniawski@schultzemmerich.net |                3
 9978 | dayana.kessler@dickinson.io          |                3


7. Write a query to print out a report of all tickets purchased by the customer
with the email address 'gennaro.rath@mcdermott.co'. The report should include
the event name and starts_at and the seat''s section name, row, and seat number.

SELECT tickets.id AS "ticket id",
       events.name AS "event name",
       events.starts_at AS "start time",
       sections.name AS "section",
       seats.row AS "seat row",
       seats.number AS "seat number"
  FROM tickets INNER JOIN customers ON tickets.customer_id = customers.id
    INNER JOIN events ON tickets.event_id = events.id
    INNER JOIN seats ON tickets.seat_id = seats.id
    INNER JOIN sections ON seats.section_id = sections.id
  WHERE customers.email = 'gennaro.rath@mcdermott.co';

ticket id |     event name     |     start time      |    section    | seat row | seat number
-----------+--------------------+---------------------+---------------+----------+-------------
      113 | Kool-Aid Man       | 2016-06-14 20:00:00 | Lower Balcony | H        |          10
      114 | Kool-Aid Man       | 2016-06-14 20:00:00 | Lower Balcony | H        |          11
     2778 | Green Husk Strange | 2016-02-28 18:00:00 | Orchestra     | O        |          14
     2779 | Green Husk Strange | 2016-02-28 18:00:00 | Orchestra     | O        |          15
     2780 | Green Husk Strange | 2016-02-28 18:00:00 | Orchestra     | O        |          16
     3682 | Ultra Archangel IX | 2016-05-23 18:00:00 | Upper Balcony | G        |           7
     3683 | Ultra Archangel IX | 2016-05-23 18:00:00 | Upper Balcony | G        |           8
