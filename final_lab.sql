create database final;
use final;

create table product(
product_id varchar(10),
product_name varchar(20), 
category_id varchar(20), 
price int
);
create table categories (
category_id varchar(10), 
category_name varchar(20) 
);
create table orders (
order_id varchar(10), 
customer_id varchar(10), 
order_date date
);
create table order_details (
order_id varchar(10), 
product_id varchar(10), 
quantity int
);
select* FROM product;
select* FROM categories;
select* FROM orders;
select* FROM order_details;
TRUNCATE TABLE product;
TRUNCATE TABLE categories;
TRUNCATE TABLE orders;
TRUNCATE TABLE order_details;

INSERT INTO product (product_id, product_name, category_id, price) VALUES
    ('P001', 'Laptop', 'C001', 1000),
    ('P002', 'Smartphone', 'C002', 800),
    ('P003', 'Tablet', 'C002', 500),
    ('P004', 'Headphones', 'C003', 100),
    ('P005', 'Printer', 'C004', 300),
	('P006', 'Camera', 'C003', 600),
    ('P007', 'Smartwatch', 'C002', 400),
    ('P008', 'Speaker', 'C004', 200);

INSERT INTO categories (category_id, category_name) VALUES
    ('C001', 'Electronics'),
    ('C002', 'Gadgets'),
    ('C003', 'Accessories'),
    ('C004', 'Peripherals');

INSERT INTO orders (order_id, customer_id, order_date) VALUES
    ('O001', 'C1', '2024-06-10'),
    ('O002', 'C2', '2024-01-11'),
    ('O003', 'C3', '2024-04-12'),
    ('O004', 'C4', '2024-02-13'),
    ('O005', 'C3', '2024-04-14'),
	('O006', 'C6', '2024-05-15'),
    ('O007', 'C2', '2024-02-16'),
    ('O008', 'C8', '2024-07-17'),
    ('O009', 'C9', '2024-01-18'),
    ('O010', 'C1', '2024-09-19');

INSERT INTO order_details (order_id, product_id, quantity) VALUES
    ('O001', 'P001', 2),
    ('O002', 'P002', 1),
    ('O003', 'P003', 3),
    ('O004', 'P004', 2),
    ('O005', 'P005', 1),
	('O006', 'P006', 2),
    ('O007', 'P006', 1),
    ('O008', 'P008', 3),
    ('O009', 'P003', 2),
    ('O010', 'P02', 1);

-- create the view
create view monthly_sales as
SELECT
    p.product_id,
    p.product_name,
    MONTH(o.order_date) AS month,
    YEAR(o.order_date) AS year,
    SUM(od.quantity * p.price) AS total_sales
FROM
    product p
JOIN
    order_details od ON p.product_id = od.product_id
JOIN
    orders o ON od.order_id = o.order_id
GROUP BY
    p.product_id,
    p.product_name,
    MONTH(o.order_date),
    YEAR(o.order_date)
order by month asc;

-- Print the view
select * from monthly_sales;

