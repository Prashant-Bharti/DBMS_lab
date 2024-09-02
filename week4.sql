create database week4;
use week4;
drop database week4;

create table Employee(
Emp_num int,
Emp_name varchar(20),
Department_ID int,
Salary int,
Joining_year int,
Email varchar(50)
);
create table Department(
Department_ID int,
Department_name varchar(20),
primary key (Department_ID)
);
create table Increment (
Emp_name varchar(20),
Salary_Increment int,
Emp_num int 
);
create table Teachers (
Teacher_ID int,
Teacher_name varchar(20)
);
create table Students (
Std_ID int,
Teacher_ID int,
primary key (Std_ID)
);


drop table employee;
drop table department;
drop table increment;
drop table teachers;
drop table students;

truncate table employee;
truncate table department;
truncate table increment;
truncate table teachers;
truncate table students;

select * from employee;
select * from department;
select * from increment;
select * from teachers;
select * from students;

INSERT INTO Employee (Emp_num, Emp_name, Department_ID, Salary, Joining_year, Email)
VALUES
(1, 'Alice Brown', 101, 50000, 2018, 'john.doe@example.com'),
(2, 'Bob Johnson', 101, 60000, 2017, 'jane.smith@example.com'),
(3, 'Charlie Davis', 102, 55000, 2020, 'bob.johnson@example.com'),
(4, 'David Lee', 102, 52000, 2017, 'alice.brown@example.com'),
(5, 'Eva White', 103, 58000, 2016, 'charlie.davis@example.com'),
(5, 'Eva White', 103, 58000, 2016, 'charlie.davis@example.com'),
(7, 'XYZ', 104, 59000, 2018, 'mike.wilson@example.com'),
(8, 'PQR', 105, 9000, 2016, 'sara.miller@example.com'),
(9, 'David Lee', null, 56000, 2020, 'david.lee@example.com'),
(10, 'Emily Taylor', null, 54000, 2018, 'emily.taylor@example.com');


INSERT INTO Department (Department_ID, Department_name)
VALUES
(101, 'Finance'),
(102, 'Human Resources'),
(103, 'Marketing'),
(104, 'Info Tech'),
(105, 'Operations'),
(106, 'Physiology');

INSERT INTO Increment (Emp_name, Salary_Increment, Emp_num)
VALUES
('Alice Brown', 2000, 1),
('Bob Johnson', 2500, 2),
('Charlie Davis', 3000, 3),
('David Lee', 2500, 4),
('Eva White', 3000, 5),
('Frank Wilson', 2000, 6),
('Grace Turner', 3000, 7),
('Eva White', 3000, 5),
('Frank Wilson', 2000, 6),
('Jack Taylor', 2300, 10);

INSERT INTO Teachers (Teacher_ID, Teacher_name)
VALUES
(1, 'John Smith'),
(2, 'Emily Johnson'),
(3, 'Michael Davis'),
(4, 'Laura Wilson'),
(5, 'Laura Wilson'),
(6, 'Emma White'),
(7, 'Emma White'),
(8, 'Olivia Miller'),
(9, 'Daniel Brown'),
(10, 'Sophia Taylor');


-- Insert data into Teachers table
INSERT INTO Teachers (Teacher_ID, Teacher_name)
VALUES
(1, 'Mr. Anderson'),
(2, 'Ms. Davis'),
(3, 'Dr. Smith'),
(4, 'Mrs. Johnson'),
(5, 'Professor White'),
(6, 'Mrs. Johnson'),
(7, 'Mr. Miller'),
(8, 'Mr. Miller'),
(9, 'Dr. Wilson'),
(10, 'Ms. Taylor');

-- Insert data into Students table with matching Teacher_ID values
INSERT INTO Students (Std_ID, Teacher_ID)
VALUES
(100, 0),
(101, 1),
(102, 2),
(103, 3),
(104, 4),
(105, 5),
(106, 6),
(107, 7),
(108, 8);







-- 1 Find the Second Highest Salary of an Employee.
select * 
from (select * from Employee 
      order by salary desc
      limit 2 )  as e
order by salary asc
limit 1;

-- 2 Find the duplicate rows in the table named Teachers.
select * from  teachers 
where teachers.teacher_name in (select teacher_name
from teachers
group by teacher_name
having  count(teacher_name)>1);

-- 3 Fetch the monthly Salary of the Employee if the annual salary is given.
SET SQL_SAFE_UPDATES =0;
UPDATE Employee
set salary=salary/12;

select  Emp_num,Emp_name,salary as monthly_salary
from employee;

-- 4 Fetch the first record from the Employee table.
select * 
from Employee
limit 1 ;
      
-- 5 Fetch the last record from the Department table.
select * 
from Department
order by Department_ID desc
limit 1;

 -- OR
 
 -- 5 Fetch the last record from the Department table.
select * 
from Department
 except (select * from Department
		 limit 5
			)  ;

             
-- 6 Display the first 5 Records from the Employee table.
select * 
from Employee
      limit 5 ;                        
                   
-- 7 Get 3 Highest salaries records from the Employee table.
select * 
from employee
order by salary desc
limit 3 ;

-- 8 Create a table with the same structure as the Employee table.
CREATE TABLE NewEmployees AS
SELECT *
FROM Employee
WHERE 1 = 0;
select * from newemployees;

-- 9 
SELECT *
FROM Employee
where emp_num < (select max(emp_num)/2 from employee)
ORDER BY Emp_num;

-- 10  Fetch only common records between tables Teachers and Students.
select * 
from teachers
inner join students
on teachers.Teacher_ID=students.Teacher_ID;

-- 11 Get information about Employees where an Employee is not assigned to the department
select * 
from Employee
where department_id is null;

-- 12. Get distinct records from the Increment table without using distinct keyword.
select emp_num, Salary_Increment , emp_name
from increment
group by emp_num, Salary_Increment , emp_name;
           

-- 13 Select all records from the Employee table whose name is ‘XYZ and ‘PQR’.
select * 
from Employee
where Emp_name in ("XYZ","PQR");

-- 14 Select all records from the Employee table where the name is not in ‘XYZ’ and ‘PQR’.
select * 
from Employee
where Emp_name NOT in ("XYZ","PQR");

-- 15 I/p: ABCDE
-- O/p:
-- A
-- B
-- C
-- D
-- E

SELECT SUBSTRING('ABCDE' FROM 1 FOR 1) AS Single_char
UNION ALL
SELECT SUBSTRING('ABCDE' FROM 2 FOR 1)
UNION ALL
SELECT SUBSTRING('ABCDE' FROM 3 FOR 1)
UNION ALL
SELECT SUBSTRING('ABCDE' FROM 4 FOR 1)
UNION ALL
SELECT SUBSTRING('ABCDE' FROM 5 FOR 1);




-- 16 Fetch all the records from employees whose joining year is 2017.
select * 
from Employee
where Joining_year = 2017;

-- 17 Find the maximum salary offered by each department.
select  department_id, max(salary)
from Employee
group by department_id ;

-- 18 Display the name of employees who joined in 2016 and whose salary is greater than 10000.
select * 
from Employee
where Employee.Joining_year = 2016
      and Employee.salary>10000;
      
-- 19 Display the following using query -
-- O/p:
-- *
-- **
-- ***
SELECT REPEAT('*', numbers.n) AS Output
FROM (
  SELECT ROW_NUMBER() OVER () AS n
  FROM information_schema.columns
) AS numbers
WHERE numbers.n <= 3;


-- 20 Add the email validation using only one query in the employee table.
update employee
set email = "invalid type"
where  email not like  "%@example.com" ;
select * from employee;

-- 21 Display 1 to 100 Numbers with a query.
WITH RECURSIVE NumberSequence AS (
  SELECT 1 AS Number
  UNION ALL
  SELECT Number + 1
  FROM NumberSequence
  WHERE Number < 100
)
SELECT Number
FROM NumberSequence;



-- 22  Find the count of duplicate rows from the table employee.
SELECT Emp_num, Emp_name, Department_ID, Salary, Joining_year, Email, COUNT(*) AS DuplicateCount
FROM Employee
GROUP BY Emp_num, Emp_name, Department_ID, Salary, Joining_year, Email
HAVING COUNT(*) > 1;

-- 23 Remove duplicate rows from the table employee?
select distinct *
from employee;

-- 24
-- INNER JOIN is used to concatenate that rows of two tables that have common attribute value
select * 
from teachers
inner join students
on teachers.Teacher_ID=students.Teacher_ID;

-- LEFT OUTER JOIN is used concatenate all values of left table to the common values of shared 
-- atrribute of right table. Values of right table not common with the shared attribute of left 
-- one are taken null.
select * 
from teachers
left join students
on teachers.Teacher_ID=students.Teacher_ID;

-- RIGHT OUTER JOIN is used concatenate all values of right table to the common values of shared 
-- atrribute of left table. Values of left table not common with the shared attribute of right 
-- one are taken null.
select * 
from teachers
right join students
on teachers.Teacher_ID=students.Teacher_ID;

-- FULL JOIN concatenate all rows of right and left table on basis of shared attribute, whether common
-- or not common. 
select * 
from teachers
left join students
on teachers.Teacher_ID=students.Teacher_ID
union
select * 
from teachers
right join students
on teachers.Teacher_ID=students.Teacher_ID;

-- 25 Display the allocated departments with its department id.(common department)
select department.department_name , department.Department_ID
from department 
inner join employee
on employee.Department_ID = department.Department_ID;

-- 26 Query to fetch employees associated with department names.
select Emp_name , Department_name, department.department_id
from employee 
left join department
on employee.Department_ID = department.Department_ID;

-- 27 Query to fetch all departments with its associated employees.
select department.department_name,department.department_id,emp_name
from department
left join employee
on department.department_id=employee.department_id;

-- 28 Joins between Employee, Department, and Increment Tables.
select * 
from employee
left join department
on department.department_id=employee.department_id 
left join increment
on employee.emp_num=increment.emp_num
union
select *
from employee
right join department
on department.department_id=employee.department_id 
right join increment
on employee.emp_num=increment.emp_num
;

-- try 28
select * 
from employee
left join department
on department.department_id=employee.department_id 
union
select *
from employee
right join department
on department.department_id=employee.department_id 
left join increment
on employee.emp_num=increment.emp_num;

