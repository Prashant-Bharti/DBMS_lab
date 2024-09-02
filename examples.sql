create database example;
use example;
-- Create table
CREATE TABLE groupes (
    gid INT PRIMARY KEY,
    name VARCHAR(255)
);
CREATE TABLE users (
    uid INT PRIMARY KEY,
    name VARCHAR(255),
    age INT,
    pop INT
);
-- Create a new table
CREATE TABLE members (
    uid INT,
    gid VARCHAR(255),
    PRIMARY KEY (uid, gid)
);

-- Insert data
INSERT INTO groupes (gid, name) VALUES
(1, 'Book Club'),
(2, 'Student Government'),
(3, 'Dead Putting Society');


-- Insert data into the existing table
INSERT INTO users (uid, name, age, pop) VALUES
(142, 'Bart', 10, 1),
(123, 'Milhouse', 10, 0),
(857, 'Lisa', 8, 1),
(456, 'Ralph', 8, 0);

-- Insert data into the members table
INSERT INTO members (uid, gid) VALUES
(142, 'dps'),
(123, 'gov'),
(857, 'gov'),
(857, 'abc'),
(456, 'gov'),
(456, 'abc');
-- -----------------------------------------------------------------------------
SELECT * FROM Users;
SELECT * FROM groupes;
SELECT * FROM members;
set sql_safe_updates =0;
delete from users;
-- Rename the table


ALTER TABLE groupes RENAME groupes TO group;


SELECT 2024-age FROM Users where name = "Lisa";

SELECT Groupes.gid, Groupes.name
FROM Users, Members, Groupes
WHERE Users.uid = Members.uid
AND Members.gid = Groupes.gid
AND Groupes.name ="Simpson";

