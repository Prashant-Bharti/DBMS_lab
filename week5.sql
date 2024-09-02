create database OFFICE;
use OFFICE;

create table Student (
Rollno  bigint PRIMARY KEY,
SName varchar(20) ,
Dob date, 
Gender varchar(20) check (gender in ("MALE","FEMALE","OTHERS")), 
BCode Varchar(20)
);
create table Branch (
BCode varchar(20) primary key, 
BName varchar(20)
);
create table Course (
CCode varchar(20) primary key , 
CName varchar (20), 
Credits int , 
BCode varchar (20)
);
create table Enrolled_Students (
Rollno bigint references student(rollno), 
sName varchar(20), 
CCode varchar(20), 
CName varchar(20), 
BCode varchar(20)
);
create table Sports (
Sport_id varchar(20) primary key check (Sport_id like "s%" ) , 
Sport_name varchar(20), 
Rollno bigint , 
Sname varchar(20), 
Gender varchar(20)
);

-- Assuming the table structure is already created
INSERT INTO Student (Rollno, SName, Dob, Gender, BCode) VALUES
(111221, 'Alan Doe', '2000-11-15', 'MALE', 'B101'),
(111222, 'Jane Smith', '2001-08-20', 'FEMALE', 'B102'),
(111223, 'Alex Johnson', '1999-12-10', 'MALE', 'B103'),
(111224, 'Emily Davis', '2002-11-25', 'FEMALE', 'B104'),
(111225, 'Chris Brown', '2000-07-05', 'OTHERS', 'B105'),
(111226, 'Mia Taylor', '2001-12-30', 'FEMALE', 'B106'),
(111227, 'Sam Robinson', '2005-09-12', 'MALE', 'B107'),
(111228, 'Sophia Miller', '2003-12-18', 'FEMALE', 'B108'),
(111229, 'Jordan White', '2002-11-08', 'MALE', 'B109'),
(111220, 'Taylor Wilson', '1999-06-22', 'OTHERS', 'B110');

INSERT INTO Branch (BCode, BName) VALUES
('B101', 'CSE '),
('B102', 'IT'),
('B103', 'EC');

INSERT INTO Course (CCode, CName, Credits, BCode) VALUES
('101', 'DBMS', 2, 'B101'),
('102', 'OS', 4, 'B101'),
('103', 'Maths', 3, 'B102'),
('104', 'CN', 1, 'B101'),
('105', 'Statistics', 3, 'B103');

INSERT INTO Enrolled_Students (RollNo, sname, CCode, CName, BCode) VALUES
('111221', 'Alan Doe', '101', 'DBMS', 'B101'),
('111222', 'Jane Smith', '102', 'OS', 'B101'),
('111223', 'Alex Johnson', '103', 'Maths', 'B102'),
('111224', 'Emily Davis', '104', 'CN', 'B102'),
('111225', 'Chris Brown', '105', 'Statistics', 'B103'),
('111226', 'Mia Taylor', '101', 'DBMS', 'B101'),
('111227', 'Sam Robinson', '102', 'OS', 'B101'),
('111228', 'Sophia Miller', '103', 'Maths', 'B102'),
('111229', 'Jordan White', '104', 'CN', 'B102'),
('111220', 'Taylor Wilson', '105', 'Statistics', 'B103'),
('111221', 'Alan Doe', '101', 'OS', 'B101'),
('111222', 'Jane Smith', '102', 'DBMS', 'B101'),
('111223', 'Alex Johnson', '103', 'CN', 'B102'),
('111224', 'Emily Davis', '104', 'Statistics', 'B103'),
('111225', 'Chris Brown', '105', 'Maths', 'B102'),
('111226', 'Mia Taylor', '101', 'OS', 'B101'),
('111227', 'Sam Robinson', '102', 'DBMS', 'B101'),
('111228', 'Sophia Miller', '103', 'CN', 'B102'),
('111229', 'Jordan White', '104', 'Statistics', 'B103'),
('111220', 'Taylor Wilson', '105', 'Maths', 'B102');

INSERT INTO Sports (Sport_id, Sport_name, Rollno, sname, Gender) VALUES
('S001', 'Chess', '111221', 'Alan Doe', 'MALE'),
('S002', 'Table Tennis', '111222', 'Jane Smith', 'FEMALE'),
('S003', 'Carrom', '111223', 'Alex Johnson', 'MALE'),
('S004', 'Carrom', '111224', 'Emily Davis', 'FEMALE'),
('S005', 'Volleyball', '111225', 'Chris Brown', 'OTHERS'),
('S006', 'Cricket', '111226', 'Mia Taylor', 'FEMALE'),
('S007', 'Chess', '111227', 'Sam Robinson', 'MALE'),
('S008', 'Table Tennis', '111228', 'Sophia Miller', 'FEMALE'),
('S009', 'Carrom', '111229', 'Jordan White', 'MALE'),
('S010', 'Dart', '111220', 'Taylor Wilson', 'OTHERS');

truncate table sports;

select * from student;
select * from branch;
select * from course;
select * from enrolled_students ;
select * from sports ;

truncate table enrolled_students;


-- 1
select student.rollno,student.sname,gender,cname
from student 
join enrolled_students 
on student.rollno=enrolled_students.rollno
where cname in ("DBMS","OS");

-- 2
select count(*)
from sports
where gender = "female";

-- 3
select * 
from student
join enrolled_students
where student.rollno=enrolled_students.rollno
and cname = "DBMS"
and student.rollno in (select rollno from sports);

-- 4
select * 
from student
join sports
where student.rollno=sports.rollno
and sport_name ="chess"
and Month(Dob) between 11 and 12;

-- 5
select * 
from sports
join enrolled_students
on sports.rollno=enrolled_students.rollno
where sports.sname like "a%";

-- 6
select sport_name , count(sname)
from sports
group by sport_name 
order by sport_name desc ;

-- 6
select cname, count(sname) 
from enrolled_students
group by cname
order by cname asc;

-- 7
select cname , count(sname)
from Enrolled_Students
group by cname
order by cname asc;

-- 8
select bcode, count(sname)
from Enrolled_Students
group by bcode
order by bcode desc;

-- 9
select ccode , count(rollno)
from enrolled_students
group by ccode
having count(rollno)>3;


-- 10
select cname ,ccode,credits
from course
where credits in("1","2");

-- 11
select student.*,course.credits
from enrolled_students
join student
on  enrolled_students.rollno =  student.rollno
join course
on  enrolled_students.ccode=course.ccode
where credits in("1","2");

-- 12
select sp.sport_name,sports.sname,sp.sname
from sports
join sports as sp
where sports.sport_name=sp.sport_name
and sports.rollno>sp.rollno;

-- 13
select distinct student.rollno,student.sname,student.Dob,student.gender,
                 sports.sport_name,enrolled_students.cname
from enrolled_students
join sports
on enrolled_students.rollno=sports.rollno
join student 
on student.rollno=enrolled_students.rollno
where sport_name="Chess"
and cname not in ("Maths","Statistics");

-- 14
SET SQL_SAFE_UPDATES =0;
update  student 
set dob = "2001/01/01"
where rollno="111222";
select * from student;


-- 15
delete from student
where rollno in (select enrolled_students.rollno from enrolled_students
join sports
on enrolled_students.rollno=sports.rollno
where sport_name="volleyball"
and  cname="maths");

-- 16
select *
from enrolled_students
where exists (select cname from enrolled_students 
               group by cname
              having count(sname)>1 )
              order by cname;

-- 17
select sname
from   student
where Dob < all (select Dob from student
                 join sports      
                 on student.rollno=sports.rollno 
                 where sport_name="Chess");

-- 18
select distinct S1.SName AS SName1, S2.SName AS SName2, 
                S1.RollNo AS RollNo1, S2.RollNo AS RollNo2, S1.CCode, SP1.sport_name
from Enrolled_Students S1
join Enrolled_Students S2 on S1.CCode = S2.CCode and S1.RollNo > S2.RollNo
join Sports SP1 on S1.RollNo = SP1.Rollno
join Sports SP2 on S2.RollNo = SP2.Rollno and SP1.Sport_name = SP2.Sport_name;



-- 19
select enrolled_students.sname ,cname
from enrolled_students 
join sports 
on enrolled_students.rollno=sports.rollno
where sport_name not in ("Table tennis");

-- 20
select sname,count(cname)
from enrolled_students 
group by sname
having count(cname)>=2;




-- Create "departments" table
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(30) 
);
-- Question 2
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(30),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO departments (department_id, department_name)
VALUES
    (1, 'Human Resources'),
    (2, 'Marketing'),
    (3, 'Finance');

-- Insert data into "employees" table
INSERT INTO employees (employee_id, employee_name, department_id)
VALUES
    (101, 'John Doe', 1),
    (102, 'Jane Smith', 1),
    (103, 'Mike Johnson', 2),
    (104, 'Emily Davis', 2),
    (105, 'Chris Brown', 2),
    (106, 'Amanda White', 1);
    
select distinct department_id
from employees
where exists (select department_id,count(employee_id) 
              from employees 
              group by department_id
              having count(employee_id)>=1);
