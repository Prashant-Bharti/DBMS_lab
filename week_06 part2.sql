-- Create Department Table
CREATE TABLE Department (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    department_head_id INT,
    CHECK (department_id > 0)
);

-- Create Student Table
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    GPA DECIMAL(3, 2) CHECK (GPA >= 0 AND GPA <= 4),
    CHECK (student_id > 0)
);

-- Create Student_Department Junction Table
CREATE TABLE Student_Department (
    student_id INT,
    department_id INT,
    PRIMARY KEY (student_id, department_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)  DEFERRABLE INITIALLY DEFERRED ,
    FOREIGN KEY (department_id) REFERENCES Department(department_id)  DEFERRABLE INITIALLY DEFERRED
);

-- Create Assertion for Every Student Must Belong to at Least One Department
CREATE ASSERTION student_belongs_to_department
CHECK (
    NOT EXISTS (
        SELECT 1
        FROM Student s
        WHERE NOT EXISTS (
            SELECT 1
            FROM Student_Department sd
            WHERE sd.student_id = s.student_id
        )
    )
) DEFERRABLE INITIALLY DEFERRED;


-- Create Assertion for Department Head
CREATE ASSERTION department_head_exists
CHECK (
    NOT EXISTS (
        SELECT 1
        FROM Department d
        WHERE d.department_head_id IS NULL
    )
)  DEFERRABLE INITIALLY DEFERRED;

-- Create Assertion for Maximum Students in a Department
CREATE ASSERTION max_students_per_department
CHECK (
    NOT EXISTS (
        SELECT 1
        FROM (
            SELECT department_id, COUNT(*) as num_students
            FROM Student_Department
            GROUP BY department_id
        ) s_count
        WHERE s_count.num_students > 100
    )
)  DEFERRABLE INITIALLY DEFERRED;

-- We can also create a trigger regarding this situation
CREATE OR REPLACE TRIGGER max_students_trigger
BEFORE INSERT ON Student_Department
FOR EACH ROW
DECLARE
    current_students NUMBER;
BEGIN
    -- Count the current number of students in the department
    SELECT COUNT(*) INTO current_students
    FROM Student_Department
    WHERE department_id = :NEW.department_id;

    -- Check if adding the new student would exceed the limit
    IF current_students >= 100 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Maximum number of students in a department exceeded.');
    END IF;
END;
/



-- Insert values into Department table
INSERT INTO Department (department_id, department_name, department_head_id)
VALUES (1, 'Computer Science', 101);

INSERT INTO Department (department_id, department_name, department_head_id)
VALUES (2, 'Mathematics', 102);

INSERT INTO Department (department_id, department_name, department_head_id)
VALUES (3, 'Physics', 103);

-- Insert values into Student table
INSERT INTO Student (student_id, student_name, GPA)
VALUES (101, 'John Doe', 3.5);

INSERT INTO Student (student_id, student_name, GPA)
VALUES (102, 'Jane Smith', 3.8);

INSERT INTO Student (student_id, student_name, GPA)
VALUES (103, 'Bob Johnson', 3.2);

-- Insert values into Student_Department junction table
INSERT INTO Student_Department (student_id, department_id)
VALUES (101, 1); 

INSERT INTO Student_Department (student_id, department_id)
VALUES (102, 2); 

INSERT INTO Student_Department (student_id, department_id)
VALUES (103, 3);

INSERT INTO Student_Department (student_id, department_id)
VALUES (101, 2);

INSERT INTO Student_Department (student_id, department_id)
VALUES (102, 1); 

INSERT INTO Student_Department (student_id, department_id)
VALUES (102, 99); 
commit;

select * from Department;
select * from Student;
select * from Student_Department;