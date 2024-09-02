create database joins;
use joins;

create table staff(
Id int ,
Staff_name varchar(20),
Staff_age int,
Staff_address varchar(30),
Monthly_package int,
primary key (Id)
);
create table payment(
Payment_Id int,
Date varchar(10),
Staff_Id int ,
AMOUNT float,
primary key (Payment_Id)
);
insert into staff values 
(1,"Aryan",22,"Mumbai",18000),
(2,"Sushil",32,"Delhi",20000),
(3,"Monty",25,"Mohali",22000),
(4,"Amit",20,"Allahabad",12000);

insert into payment values 
(101,"30/12/2009",1,3000.00),
(102,"22/02/2010",3,2500.00),
(103,"30/02/2010",4,3500.00);


select * from staff;
select * from payment;
truncate table payment;
drop table payment;

select * 
from staff
inner join payment
on staff.id=payment.staff_id;

select * 
from staff
left join payment
on staff.id=payment.staff_id;

select * 
from staff
join payment
on staff.id=payment.staff_id;

select * 
from staff
left join payment
on staff.id=payment.staff_id
union
select *
from staff
right join payment
on staff.id=payment.staff_id;

-- B1--------------------------------------------------------------------
create table customer(
customer_id int,
c_name varchar(10),
Email varchar(30),
Address varchar(20),
primary key (customer_id)
);
create table orders (
Order_id int,
Customer_id int ,
Date varchar(20),
Contact bigint,
primary key (Order_id),
foreign key (Customer_id) references customer(Customer_id)
);
select * from customer;
select * from orders;
drop table orders;

insert into customer values
(100,"Aarav","aarav@gmail.com","Ahemdabad"),
(101,"Aryan","Aryan@yahoo.com","Delhi"),
(102,"Dhruv","Dhruv@outlook.com","Mumbai"),
(103,"Nitya","Nitya@gmail.com","Pune"),
(104,"Vikram","Vikram@yahoo.com","Chennai"),
(105,"Yuvika","Yuvika@gmail.com","Kolkata");

INSERT INTO orders VALUES
(2022511021, 100, '2024-02-09', 9123456789),
(2022511026, 101, '2024-02-10', 7876543210),
(2022511027, 102, '2024-02-11', 8567890123),
(2022511028, 103, '2024-02-12', 9890123456),
(2022511029, 104, '2024-02-13', 7345678901),
(2022511020, 105, '2024-02-14', 6678901234);


select customer_id,c_name
from customer
where email like "%gmail%";

select *
from customer
where c_name not like "a%";

select c_name,date,contact,email,address
from customer
join orders
where customer.customer_id=orders.customer_id;

select customer.customer_id,c_name,email,address,contact
from customer
join orders
on customer.customer_id=orders.customer_id;

-- B2-----------------------------------------------
create table Books (
ISBN int ,
Title varchar(50),
Unit_price int,
Author_Name varchar(40),
Publisher_name varchar(40),
Publish_year int ,
primary key (ISBN,Author_Name)
);
create table authors (
Author varchar(40) primary key,
Country varchar(40),
ISBN int ,
foreign key (ISBN  ,Author) references Books (ISBN,Author_Name)
);


INSERT INTO Books (ISBN, Title, Unit_price, Author_Name, Publisher_name, Publish_year)
VALUES
(1001, 'Harry Potter', 3100, 'J.K. Rowling', 'Scholastic Press', 1998),
(1002, 'The Hitchhiker''s Guide to the Galaxy', 4500, 'Douglas Adams', 'Mass Market paperback', 2000),
(1003, 'Changeling', 800, 'Delia Sherman', 'Springer', 2008),
(1004, 'Giving Good Weight', 1280, 'John McPhee', 'Spiegel and Grau', 2006),
(1005, 'Writing', 1700, 'Marguerite Duras', 'Paperback', 2001);

INSERT INTO authors (Author, Country)
VALUES
('J.K. Rowling', 'U.K'),
('Douglas Adams', 'U.K'),
('Delia Sherman', 'Japan'),
('John McPhee', 'U.S.A'),
('Marguerite Duras', 'Germany');

select * from authors;
select author , country from authors;

-- 1
select count(title) as book_count
from books;

-- 2
select*
from books
limit 3;

-- 3
select Title
from books
where unit_price  between 1000 and 3000;

-- 4
select Title ,author_name,country,publish_year
from books
join authors
where books.author_name=authors.author
and publish_year=2000;

-- 5
select Title
from books
where publisher_name in ("Scholastic Press" , "Paperback" );

-- 6
select Title ,author_name,country
from books
join authors
ON books.author_name=authors.author;

-- 7
select author_name ,Title ,country
from books
join authors
ON books.author_name=authors.author
and country= 'U.K';

-- ----------------------------------------------------
create table salesman(
salesman_id int primary key,
name varchar(20),
city varchar(20),
commission float
);
create table customers(
customer_id int,
cust_name varchar(20),
city varchar(20),
grade int,
salesman_id int,
foreign key (salesman_id) references salesman(salesman_id)
);

INSERT INTO salesman (salesman_id, name, city, commission)
VALUES 
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nailil Knite', 'Paris ', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5007, 'Paul Adam', 'Rome', 0.12);
    
    INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES 
    (101, 'Brad Corp', 'New York', 300, '5001'),
    (102, 'Becky Ltd', 'California', 200, '5002'),
    (103, 'William Inc', 'London', 100, '5005'),
    (104, 'Steve Co', 'Paris', 100, '5006'),
    (105, 'Justin Ltd', 'New Jersey', 300, '5007');
    
select*from salesman;
select * from customers;
SET SQL_SAFE_UPDATES = 0;

select * from customers 
where customers.grade in (select grade
from customers
group by grade
having  count(grade)>1);

-- 1
SET SQL_SAFE_UPDATES = 0;
update  salesman
set commission = commission+commission*0.15;

-- 2
select name ,cust_name, salesman.city as salesman_city ,customers.city as customer_city
from salesman
join customers
on salesman.city = customers.city;

-- 3
select salesman.salesman_id , name, salesman. city, commission
from salesman
join customers
on salesman.salesman_id = customers.salesman_id
and salesman.city != customers.city;






