# SQL Learning Project 🚀

A comprehensive SQL learning repository that covers fundamental to advanced SQL concepts through practical examples and exercises.

## 📚 Table of Contents
- [Project Overview](#project-overview)
- [Learning Path](#learning-path)
- [Topic Details](#topic-details)
- [Interactive Examples](#interactive-examples)
- [Practice Exercises](#practice-exercises)
- [Resources](#resources)

## Project Overview

This repository is designed to help you master SQL from basics to advanced concepts. Each topic is organized in numbered folders for systematic learning.

### 🎯 Learning Objectives
- Master fundamental SQL concepts
- Understand database design principles
- Learn advanced querying techniques
- Practice real-world scenarios
- Develop database optimization skills

## Learning Path

### 1️⃣ Foundation Level
1. **Database Basics**
   - Understanding databases and their types
   - Creating and managing databases
   - Database security and permissions

2. **Table Management**
   - Table creation and modification
   - Data types and constraints
   - Table relationships

3. **Basic Operations**
   - INSERT, UPDATE, DELETE
   - SELECT queries
   - WHERE clauses

### 2️⃣ Intermediate Level
1. **Data Integrity**
   - Constraints (PRIMARY KEY, FOREIGN KEY)
   - Data validation
   - Transaction management

2. **Advanced Queries**
   - JOIN operations
   - Subqueries
   - Functions and aggregations

### 3️⃣ Advanced Level
1. **Database Programming**
   - Stored Procedures
   - Triggers
   - Views

2. **Performance Optimization**
   - Indexing
   - Query optimization
   - Database tuning

## Topic Details

### 1. Database Fundamentals

#### 1.1 Databases (#01. DATABASES)
**Purpose**: Learn how to create and manage databases
```sql
-- Create a new database
CREATE DATABASE company_db;

-- Select the database
USE company_db;

-- Show all databases
SHOW DATABASES;

-- Drop a database (with safety check)
DROP DATABASE IF EXISTS company_db;
```

#### 1.2 Tables (#02. TABLES)
**Purpose**: Master table creation and modification
```sql
-- Create a table with multiple columns
CREATE TABLE employees (
    id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    hire_date DATE,
    salary DECIMAL(10,2)
);

-- Modify table structure
ALTER TABLE employees
ADD COLUMN department VARCHAR(50),
MODIFY COLUMN salary DECIMAL(12,2);

-- Rename table
RENAME TABLE employees TO staff;
```

#### 1.3 Data Manipulation (#03. ROWS, #04. SELECT)
**Purpose**: Learn to insert, update, and query data
```sql
-- Insert multiple rows
INSERT INTO employees (id, first_name, last_name, email, salary)
VALUES 
    (1, 'John', 'Doe', 'john@example.com', 50000),
    (2, 'Jane', 'Smith', 'jane@example.com', 60000);

-- Update with conditions
UPDATE employees 
SET salary = salary * 1.1
WHERE department = 'IT';

-- Complex SELECT query
SELECT 
    e.first_name,
    e.last_name,
    d.department_name,
    e.salary
FROM employees e
JOIN departments d ON e.department_id = d.id
WHERE e.salary > 50000
ORDER BY e.salary DESC;
```

### 2. Advanced Concepts

#### 2.1 JOIN Operations (#15. JOIN)
**Purpose**: Combine data from multiple tables
```sql
-- INNER JOIN
SELECT e.name, d.department_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id;

-- LEFT JOIN with NULL check
SELECT e.name, COALESCE(d.department_name, 'Unassigned') as department
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id;

-- Self JOIN (employee hierarchy)
SELECT 
    e1.name as employee,
    e2.name as manager
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.id;
```

#### 2.2 Functions (#16. FUNCTIONS)
**Purpose**: Use built-in SQL functions
```sql
-- Aggregate functions with GROUP BY
SELECT 
    department,
    COUNT(*) as employee_count,
    AVG(salary) as avg_salary,
    MAX(salary) as max_salary
FROM employees
GROUP BY department;

-- String functions
SELECT 
    CONCAT(first_name, ' ', last_name) as full_name,
    UPPER(email) as email_upper,
    LOWER(department) as department_lower
FROM employees;

-- Date functions
SELECT 
    name,
    hire_date,
    DATEDIFF(CURRENT_DATE, hire_date) as days_employed,
    DATE_FORMAT(hire_date, '%Y-%m-%d') as formatted_date
FROM employees;
```

#### 2.3 Stored Procedures (#28. STORED_PROCEDURE)
**Purpose**: Create reusable SQL code blocks
```sql
DELIMITER //

-- Create a procedure for employee management
CREATE PROCEDURE manage_employee(
    IN action VARCHAR(10),
    IN emp_id INT,
    IN emp_name VARCHAR(100),
    IN emp_salary DECIMAL(10,2)
)
BEGIN
    CASE action
        WHEN 'INSERT' THEN
            INSERT INTO employees (id, name, salary)
            VALUES (emp_id, emp_name, emp_salary);
        WHEN 'UPDATE' THEN
            UPDATE employees 
            SET name = emp_name, salary = emp_salary
            WHERE id = emp_id;
        WHEN 'DELETE' THEN
            DELETE FROM employees WHERE id = emp_id;
    END CASE;
END //

DELIMITER ;

-- Use the procedure
CALL manage_employee('INSERT', 1, 'John Doe', 50000);
```

## Interactive Examples

### Real-world Scenarios

#### 1. E-commerce Database
```sql
-- Create tables
CREATE TABLE products (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    category_id INT
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATETIME,
    total_amount DECIMAL(10,2)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2)
);

-- Complex query example
SELECT 
    o.id as order_id,
    c.name as customer_name,
    COUNT(oi.product_id) as items_count,
    SUM(oi.quantity * oi.price) as total_amount
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN order_items oi ON o.id = oi.order_id
GROUP BY o.id, c.name
HAVING total_amount > 1000;
```

#### 2. Employee Management System
```sql
-- Create tables with relationships
CREATE TABLE departments (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(100)
);

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    manager_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (department_id) REFERENCES departments(id),
    FOREIGN KEY (manager_id) REFERENCES employees(id)
);

-- Hierarchical query
WITH RECURSIVE employee_hierarchy AS (
    SELECT id, name, manager_id, 1 as level
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.id, e.name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.id
)
SELECT * FROM employee_hierarchy;
```

## Practice Exercises

### Beginner Level
1. Create a database for a library system
2. Design tables for books, members, and loans
3. Write queries to:
   - Find overdue books
   - List popular books
   - Calculate member statistics

### Intermediate Level
1. Design an inventory management system
2. Create complex queries with:
   - Multiple JOINs
   - Subqueries
   - Aggregate functions

### Advanced Level
1. Build a banking system with:
   - Transaction management
   - Stored procedures
   - Triggers for audit logging

## Resources

### 📚 Documentation
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [SQL Server Documentation](https://docs.microsoft.com/en-us/sql/sql-server/)

### 🎓 Learning Platforms
- SQLZoo
- LeetCode SQL
- HackerRank SQL

### 🛠️ Tools
- MySQL Workbench
- pgAdmin
- SQL Server Management Studio

### 📝 Best Practices
1. Always use meaningful table and column names
2. Implement proper indexing
3. Write efficient queries
4. Use transactions appropriately
5. Regular database maintenance

## 🤝 Contributing

Feel free to contribute to this project by:
1. Adding more examples
2. Improving existing queries
3. Adding new topics
4. Fixing bugs
5. Enhancing documentation

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

Happy Learning! 🚀 