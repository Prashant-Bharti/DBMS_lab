create database college;
use college;

create table student (
stid int primary key ,
fname varchar(20),
mname varchar(20),
lname varchar(20),
house varchar(20)
);
create table instructor (
iid int primary key ,
iname varchar (20)

);
create table course (
cid int primary key,
cname varchar(20),
iid int ,
foreign key (iid) references instructor(iid)
);

create table grade (
stid int ,
cid int ,
grade varchar(20),
marks int ,
foreign key (stid) references student(stid),
foreign key (grade) references gradepoint(grade)
);
create table gradepoint(
grade varchar(20) primary key,
gradepoint int

);
select* from student;
select* from instructor;
select* from course;
select* from grade;
select* from gradepoint;

drop table student;
drop table instructor;
drop table course;
drop table grade;
drop table gradepoint;

INSERT INTO student (stid, fname, mname, lname, house) VALUES
(1, 'Angela', 'Abyss', 'Doe', 'Red House'),
(2, 'Bard', 'Abbas', 'Louis', 'Red House'),
(3, 'Cass', 'Imper', 'Chrom', 'Red House'),
(4, 'David', 'Abbas', 'Brown', 'Green House'),
(5, 'Emily', 'Anne', 'Williams', 'Yellow House'),
(6, 'Olivia', 'Grace', 'Davis', 'Blue House'),
(7, 'William', 'Abba', 'Taylor', 'Red House'),
(8, 'Harry', 'Abbas', 'Potter', 'Blue House'),
(9, 'Sophia', 'Elizabeth', 'Miller', 'Yellow House'),
(10, 'Anita', 'James', 'Johnson', 'Green House');
INSERT INTO student (stid, fname, mname, lname, house) VALUES 
(1, 'Anita', 'James', 'xyz', 'Green House');

-- Insert data into the instructor table
INSERT INTO instructor (iid, iname) VALUES
(1000, 'Palak'),
(2000, 'Subrata'),
(3000, 'Vinay'),
(4000, 'Deepali'),
(5000, 'DS');

-- Insert data into the course table
INSERT INTO course (cid, cname, iid) VALUES
(101, 'English', 1000),
(202, 'Hindi', 2000),
(303, 'Maths', 3000),
(404, 'Science', 4000),
(505, 'Sst', 5000);



-- Insert data for 10 students and 5 subjects with randomized grades and marks
INSERT INTO grade (stid, cid, grade, marks) VALUES
(1, 101, 'AB', 88),
(1, 202, 'BC', 68),
(1, 303, 'AA', 78),
(1, 404, 'CC', 72),
(1, 505, 'FF', 09),

(2, 101, 'BB', 79),
(2, 202, 'CC', 70),
(2, 303, 'AA', 92),
(2, 404, 'BC', 65),
(2, 505, 'AB', 85),

(3, 101, 'BB', 79),
(3, 202, 'CC', 70),
(3, 303, 'AA', 92),
(3, 404, 'BC', 65),
(3, 505, 'AB', 85),


(4, 101, 'BC', 66),
(4, 202, 'CC', 78),
(4, 303, 'AA', 08),
(4, 404, 'BB', 79),
(4, 505, 'AB', 72),

(5, 101, 'BB', 76),

(5, 303, 'CC', 61),
(5, 404, 'CC', 66),
(5, 505, 'AB', 86),

(6, 101, 'AA', 96),


(6, 404, 'AA', 93),
(6, 505, 'BB', 80),

(7, 101, 'AA', 91),
(7, 202, 'BB', 78),
(7, 303, 'BB', 74),
(7, 404, 'AB', 83),
(7, 505, 'BB', 75),

(8, 101, 'BB', 78),

(8, 404, 'BC', 68),
(8, 505, 'AB', 87),

(9, 101, 'CC', 74),
(9, 202, 'CC', 79),
(9, 303, 'AA', 89),
(9, 404, 'FF', 00),


(10, 101, 'BC', 69),
(10, 202, 'CC', 71),
(10, 303, 'FF', 03),
(10, 404, 'AB', 85);




-- Insert data into the gradepoint table
INSERT INTO gradepoint (grade, gradepoint) VALUES
('AA', 100),
('AB', 90),
('BB', 80),
('BC', 70),
('CC', 60),
('CD', 50),
('DD', 40),
('DE', 30),
('EE', 20),
('EF', 10),
('FF', 0);

-- 1
select max(stid_count) 
FROM (select cid , count(stid) as stid_count from grade group by cid)
as max_stid_count;

-- 2
SELECT cid, COUNT( stid) as stid_count
FROM grade
GROUP BY cid;

-- 3
select student.stid, fname,lname ,  count(distinct grade) as grade_count
from grade
join student
on student.stid=grade.stid
group by student.stid, fname,lname;

-- 4
select  grade.stid , grade.cid , instructor.iname
from course
inner join grade
on  course.cid= grade.cid
join instructor
on instructor.iid=course.iid;

--  5
SELECT stid, cpi
FROM (
    SELECT stid, ROUND(SUM(marks) / COUNT(DISTINCT cid), 2) AS cpi
    FROM grade
    GROUP BY stid
) AS cpi_data
WHERE cpi IN (
    SELECT cpi
    FROM (
        SELECT ROUND(SUM(marks) / COUNT(DISTINCT cid), 2) AS cpi
        FROM grade
        GROUP BY stid
    ) AS subquery
    GROUP BY cpi
    HAVING COUNT(*) > 1
);
-- 6
SELECT instructor.iname, SUM(grade.marks) AS total_marks
FROM course
JOIN instructor ON instructor.iid = course.iid
JOIN grade ON course.cid = grade.cid
GROUP BY instructor.iname
order by total_marks desc
limit 1;

-- 7
select grade.stid  , sum(gradepoint.gradepoint) as sum_gp
from grade
join gradepoint
on grade.grade=gradepoint.grade
group by grade.stid
order by sum_gp desc
limit 1;

-- 8
select student.stid, student.house,count(gradepoint.gradepoint)
from student
join grade
on student.stid=grade.stid
join gradepoint
on grade.grade=gradepoint.grade
group by student.stid, student.house 
order by house;

-- ---------ambiguous
SELECT student.stid, student.house, SUM(gradepoint.gradepoint) AS total_gradepoints
FROM student
JOIN grade ON student.stid = grade.stid
JOIN gradepoint ON grade.grade = gradepoint.grade
GROUP BY student.stid, student.house;



-- 8
WITH RankedStudents AS (
    SELECT
        student.stid,
        student.house,
        SUM(gradepoint.gradepoint) AS total_gradepoints,
        ROW_NUMBER() OVER (PARTITION BY student.house ORDER BY SUM(gradepoint.gradepoint) DESC) AS gradepoint
    FROM
        student
    JOIN grade ON student.stid = grade.stid
    JOIN gradepoint ON grade.grade = gradepoint.grade
    GROUP BY
        student.stid, student.house
)
SELECT DISTINCT house, stid, total_gradepoints
FROM RankedStudents
WHERE gradepoint = 1;

-- 9 
select student.fname
from student
join grade 
on student.stid=grade.stid
where grade.grade="FF";
 
-- 10
SELECT *
FROM student
WHERE fname LIKE 'A%a' And fname LIKE '%A';

-- 11
select count(stid)
from grade
join course
on course.cid=grade.cid
where marks>70 or cname="maths";

-- 12
select count(stid)
from student;

select max(marks)
from grade
where cid=202;

select min(marks)
from grade
where cid=101;

select stid,sum(marks)
from grade
where stid = 7;

select stid,avg (marks)
from grade
where stid = 1;

-- 13
select stid, sum(marks)/count(stid) as markss
from grade
group by stid
limit 4;

-- 14
ALTER TABLE grade
MODIFY COLUMN marks FLOAT;

-- 15
select * from student where mname like 'Ab%';





