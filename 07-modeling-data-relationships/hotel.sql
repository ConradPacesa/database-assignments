CREATE TABLE guest(
  id integer,
  first_name text,
  last_name text,
  phone_number integer,
  email text,
  address text
);

CREATE TABLE rooms(
  room_number integer,
  floor_number integer,
  price integer
);

CREATE TABLE visits(
  id integer,
  guestid integer,
  room_number integer,
  check_in_date date,
  check_out_date date
);

INSERT INTO guest
VALUES
(1, 'bob', 'smith', 5551234, 'bob@example.com', '123 main st'),
(2, 'jane', 'smith', 5551235, 'jane@example.com', '123 first st'),
(3, 'sally', 'smith', 5551236, 'sally@example.com', '125 main st'),
(4, 'bobby', 'boberson', 5551237, 'bobby@example.com', '123 second st'),
(5, 'jimmy', 'bobby', 5551238, 'jimmyb@example.com', '321 main st'),
(6, 'stan', 'smith', 5551239, 'stan@example.com', '44 fourth st');

INSERT INTO rooms
VALUES
(11, 1, 50),
(12, 1, 50),
(21, 2, 60),
(22, 2, 60);

INSERT INTO visits
VALUES
(1, 1, 11, '2017-09-09', '2017-09-11'),
(2, 1, 12, '2017-09-09', '2017-09-11'),
(3, 2, 21, '2017-09-09', '2017-09-12'),
(4, 3, 22, '2017-09-14', '2017-09-15'),
(5, 4, 12, '2017-09-14', '2017-09-17'),
(6, 3, 21, '2017-09-17', '2017-09-19'),
(7, 2, 11, '2017-09-20', '2017-09-21');

/* Find a guest who exists in the database and has not booked a room. */

SELECT * FROM guest
WHERE id NOT IN (SELECT guestid FROM visits);

/* Find bookings for a guest who has booked two rooms for the same dates. */

SELECT guestid, check_in_date, check_out_date, STRING_AGG(room_number::text, ', ') AS room_numbers
FROM visits
GROUP BY guestid, check_in_date, check_out_date
HAVING COUNT(check_in_date) > 1;

/* Find bookings for a guest who has booked one room several times on different dates.*/

SELECT guestid
FROM visits
GROUP BY guestid
HAVING COUNT(DISTINCT check_in_date) > 1;


/* Count the number of unique guests who have booked the same room. */

SELECT room_number, COUNT(DISTINCT guestid) AS num
FROM visits
GROUP BY room_number;
