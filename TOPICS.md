# Detailed SQL Topics Guide

## 1. Database Fundamentals

### 1.1 Databases (#01. DATABASES)
- **Purpose**: Databases are containers that hold all your SQL objects (tables, views, procedures, etc.)
- **Key Concepts**:
  - Creating databases
  - Selecting databases
  - Dropping databases
  - Database permissions
- **Interactive Example**:
```sql
-- Create a new database
CREATE DATABASE my_database;

-- Select the database to use
USE my_database;

-- Drop a database (be careful!)
DROP DATABASE my_database;
```

### 1.2 Tables (#02. TABLES)
- **Purpose**: Tables are the fundamental storage units in SQL
- **Key Operations**:
  1. Creating tables
  2. Selecting tables
  3. Renaming tables
  4. Dropping tables
  5. Altering tables (adding/modifying/dropping columns)
- **Interactive Example**:
```sql
-- Create a table
CREATE TABLE employees (
    id INT,
    name VARCHAR(100),
    email VARCHAR(255)
);

-- Add a new column
ALTER TABLE employees ADD COLUMN salary DECIMAL(10,2);

-- Rename a column
ALTER TABLE employees RENAME COLUMN name TO full_name;

-- Drop a column
ALTER TABLE employees DROP COLUMN email;
```

### 1.3 Rows (#03. ROWS)
- **Purpose**: Individual records in a table
- **Key Operations**:
  - Inserting rows
  - Updating rows
  - Deleting rows
  - Selecting specific rows
- **Interactive Example**:
```sql
-- Insert a row
INSERT INTO employees (id, name, salary) 
VALUES (1, 'John Doe', 50000);

-- Update a row
UPDATE employees 
SET salary = 55000 
WHERE id = 1;

-- Delete a row
DELETE FROM employees 
WHERE id = 1;
```

### 1.4 SELECT (#04. SELECT)
- **Purpose**: Querying data from tables
- **Key Features**:
  - Basic SELECT
  - WHERE clause
  - DISTINCT
  - Aliases
- **Interactive Example**:
```sql
-- Basic select
SELECT * FROM employees;

-- Select with conditions
SELECT name, salary 
FROM employees 
WHERE salary > 50000;

-- Select with alias
SELECT name AS employee_name, 
       salary AS monthly_salary 
FROM employees;
```

## 2. Data Manipulation

### 2.1 UPDATE and DELETE (#05. UPDATEandDELETE)
- **Purpose**: Modifying and removing existing data
- **Key Concepts**:
  - UPDATE syntax
  - DELETE syntax
  - WHERE clause importance
  - Safe deletion practices
- **Interactive Example**:
```sql
-- Update multiple columns
UPDATE employees 
SET salary = 60000, 
    department = 'IT' 
WHERE id = 1;

-- Delete with condition
DELETE FROM employees 
WHERE department = 'HR';
```

### 2.2 Transaction Management (#06. AUTOCOMMIT, COMMIT, ROLLBACK)
- **Purpose**: Managing database transactions
- **Key Concepts**:
  - Transaction boundaries
  - ACID properties
  - Commit and rollback
- **Interactive Example**:
```sql
-- Start transaction
START TRANSACTION;

-- Perform operations
UPDATE employees SET salary = 65000 WHERE id = 1;
INSERT INTO employees (id, name, salary) VALUES (2, 'Jane Doe', 70000);

-- Commit transaction
COMMIT;

-- Or rollback if something goes wrong
ROLLBACK;
```

### 2.3 Constraints
#### 2.3.1 UNIQUE (#08. UNIQUE)
- **Purpose**: Ensure column values are unique
- **Interactive Example**:
```sql
CREATE TABLE users (
    id INT PRIMARY KEY,
    email VARCHAR(255) UNIQUE,
    username VARCHAR(50) UNIQUE
);
```

#### 2.3.2 NOT NULL (#09. NOTNULL)
- **Purpose**: Prevent NULL values in columns
- **Interactive Example**:
```sql
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);
```

#### 2.3.3 CHECK (#10. CHECK)
- **Purpose**: Enforce data validation rules
- **Interactive Example**:
```sql
CREATE TABLE orders (
    id INT PRIMARY KEY,
    amount DECIMAL(10,2) CHECK (amount > 0),
    status VARCHAR(20) CHECK (status IN ('pending', 'completed', 'cancelled'))
);
```

## 3. Advanced Queries

### 3.1 JOIN Operations (#15. JOIN)
- **Purpose**: Combine data from multiple tables
- **Types**:
  - INNER JOIN
  - LEFT JOIN
  - RIGHT JOIN
  - FULL JOIN
- **Interactive Example**:
```sql
-- Inner join
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id;

-- Left join
SELECT e.name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id;
```

### 3.2 Functions (#16. FUNCTIONS)
- **Purpose**: Built-in SQL functions for data manipulation
- **Categories**:
  - Aggregate functions (COUNT, SUM, AVG)
  - String functions (CONCAT, SUBSTRING)
  - Date functions (DATE_FORMAT, DATEDIFF)
- **Interactive Example**:
```sql
-- Aggregate functions
SELECT 
    COUNT(*) as total_employees,
    AVG(salary) as avg_salary,
    MAX(salary) as max_salary
FROM employees;

-- String functions
SELECT 
    CONCAT(first_name, ' ', last_name) as full_name,
    UPPER(email) as email_upper
FROM employees;
```

### 3.3 Subqueries (#25. SUB_QUERY)
- **Purpose**: Nested queries for complex data retrieval
- **Types**:
  - Scalar subqueries
  - Row subqueries
  - Table subqueries
- **Interactive Example**:
```sql
-- Find employees with salary above average
SELECT name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Find departments with no employees
SELECT department_name
FROM departments
WHERE id NOT IN (SELECT dept_id FROM employees);
```

### 3.4 Stored Procedures (#28. STORED_PROCEDURE)
- **Purpose**: Reusable SQL code blocks
- **Benefits**:
  - Code reusability
  - Better performance
  - Security
- **Interactive Example**:
```sql
DELIMITER //
CREATE PROCEDURE get_employee_details(IN emp_id INT)
BEGIN
    SELECT e.*, d.department_name
    FROM employees e
    LEFT JOIN departments d ON e.dept_id = d.id
    WHERE e.id = emp_id;
END //
DELIMITER ;

-- Call the procedure
CALL get_employee_details(1);
```

### 3.5 Triggers (#29. TRIGGERS)
- **Purpose**: Automatic actions on database events
- **Types**:
  - BEFORE triggers
  - AFTER triggers
- **Interactive Example**:
```sql
DELIMITER //
CREATE TRIGGER before_employee_update
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < OLD.salary THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Salary cannot be decreased';
    END IF;
END //
DELIMITER ;
```

## 🎯 Practice Exercises

For each topic, try these exercises:

1. **Basic Operations**:
   - Create a new database
   - Create tables with different constraints
   - Insert sample data
   - Try various SELECT queries

2. **Advanced Operations**:
   - Create complex JOIN queries
   - Write subqueries
   - Create stored procedures
   - Implement triggers

3. **Real-world Scenarios**:
   - Design a simple inventory system
   - Create an employee management system
   - Build a basic e-commerce database

## 🔍 Tips for Practice

1. Start with simple queries and gradually increase complexity
2. Always test your queries on sample data
3. Use proper naming conventions
4. Comment your code
5. Handle errors appropriately
6. Consider performance implications

## 📚 Additional Resources

- SQL documentation
- Online SQL practice platforms
- Database design best practices
- Performance optimization guides

---

Happy Learning! 🚀 