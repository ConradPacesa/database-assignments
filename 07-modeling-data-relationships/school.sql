CREATE TABLE class(
  id integer,
  subject text,
  class_code text,
  room integer,
  teacher text,
  time time
);

CREATE TABLE students(
  id integer,
  first_name text,
  last_name text,
  phone_number integer,
  email_address text
);

CREATE TABLE enrolments(
  id integer,
  classid integer,
  studentid integer,
  grade varchar(1)
);

INSERT INTO class
VALUES
(1, 'Intro to comp sci', 'CS 101', 122, 'Mr. Smith', '08:00'),
(2, 'Algorithms', 'CS 201', 233, 'Mrs. Smith', '09:30'),
(3, 'atabases', 'DB 101', 132, 'Mr. Doe', '11:00');


INSERT INTO students
VALUES
(1, 'Bart', 'Simpson', 5555555, 'bart@example.com'),
(2, 'Lisa', 'Simpson', 1234567, 'lisa@example.com'),
(3, 'Chris', 'Griffin', 3217654, 'chris@example.com'),
(4, 'Meg', 'Griffin', 1234576, 'meg@example.com'),
(5, 'Stewie', 'Griffin', 1235465, 'stew@example.com'),
(6, 'Homer', 'Simpson', 5453554, 'homer@example.com');

INSERT INTO enrolments
VALUES
(1, 1, 1, 'D'),
(2, 1, 2, 'A'),
(3, 1, 3, 'C'),
(4, 1, 4, 'B'),
(5, 1, 5, 'B'),
(6, 2, 1, 'C'),
(7, 2, 2, 'A'),
(8, 2, 5, 'A'),
(9, 2, 6, 'B'),
(10, 3, 2, 'A'),
(11, 3, 4, 'B'),
(12, 3, 5, 'A');


/* Find all students who have taken a particular class. */

SELECT students.first_name, students.last_name
FROM students
JOIN enrolments
ON students.id = enrolments.studentid
WHERE enrolments.classid = 1;

/* Count the number of each grade (using letter grades A-F) earned in a particular class. */

SELECT grade, COUNT(*)
FROM enrolments
GROUP BY grade, classid
HAVING classid = 1;

/* Find class names and the total number of students who have taken each class in the list. */

SELECT class.subject, COUNT(*)
FROM class
JOIN enrolments
ON class.id = enrolments.classid
GROUP BY class.subject;

/* Find the class taken by the largest number of students. */

SELECT classid, COUNT(classid)
FROM enrolments
GROUP BY classid
ORDER BY count DESC
LIMIT 1;
