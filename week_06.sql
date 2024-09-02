-- Create Authors table
CREATE TABLE Authors (
    author_id INT PRIMARY KEY,
    author_name VARCHAR2(100) NOT NULL
);

CREATE ASSERTION price_check
CHECK (NOT EXISTS
(SELECT * FROM books
WHERE price < 99.00));

-- Create Books table
CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    author_id INT,
    price DECIMAL(10, 2) NOT NULL,                -- Ensuring price is not less than Rs. 99 through assertion
    quantity INT NOT NULL CHECK (quantity >= 0),        -- Ensuring non-negative quantity through check
    CONSTRAINT fk_author FOREIGN KEY (author_id) REFERENCES Authors(author_id) DEFERRABLE INITIALLY DEFERRED
);

-- Create View for easy reference
CREATE VIEW BookView AS
SELECT b.book_id, b.title, a.author_name, b.price
FROM Books b
JOIN Authors a ON b.author_id = a.author_id;

-- Insert into Authors table
INSERT INTO Authors (author_id, author_name) VALUES (1, 'Author 1');
INSERT INTO Authors (author_id, author_name) VALUES (2, 'Author 2');
INSERT INTO Authors (author_id, author_name) VALUES (3, 'Author 3');

-- Insert into Books table
INSERT INTO Books (book_id, title, author_id, price, quantity) VALUES (101, 'English 1', 1, 120.50, 10);
INSERT INTO Books (book_id, title, author_id, price, quantity) VALUES (201, 'Hindi 2', 2, 99.99, 5);
INSERT INTO Books (book_id, title, author_id, price, quantity) VALUES (301, 'Maths 3', 3, 150.00, 8);
INSERT INTO Books (book_id, title, author_id, price, quantity) VALUES (401, 'Science 4', 1, 200.00, 3);
INSERT INTO Books (book_id, title, author_id, price, quantity) VALUES (501, 'S.St 5', 2, 120.00, 15);
INSERT INTO Books (book_id, title, author_id, price, quantity) VALUES (601, 'G.K. 6', 4,100.00, 20);

-- Example PL/SQL block
BEGIN
    -- Your PL/SQL code here
    INSERT INTO Books (book_id, title, author_id, price, quantity) VALUES (601, 'Book 6', 4, 100.00, 20);
    
    -- Additional statements if needed
    
    -- Commit the transaction
    COMMIT;
END;




COMMIT;
select * from authors;
select * from books;
select * from Bookview;
-- truncate table books;
CREATE TRIGGER check_price
AFTER INSERT ON Books
FOR EACH ROW
BEGIN
    -- Check if the inserted price is less than Rs. 99
    IF NEW.price < 99 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Price cannot be less than Rs. 99';
    END IF;
END;
