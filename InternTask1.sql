-- Creating my own database
CREATE DATABASE IF NOT EXISTS my_company;
USE my_company;

-- Creating an employees table
CREATE TABLE employees (
  id INT PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  hire_date DATE,
  salary DECIMAL(10,2),
  department VARCHAR(50)
);

INSERT INTO employees (first_name, last_name, hire_date, salary, department) VALUES
('Alice', 'Smith', '2021-06-12', 55000.00, 'Sales'),
('Bob', 'Johnson', '2019-03-24', 62000.00, 'Marketing'),
('Charlie', 'Williams', '2022-09-15', 48000.00, 'IT'),
('Diana', 'Brown', '2020-01-10', 75000.00, 'HR'),
('Ethan', 'Jones', '2018-07-22', 67000.00, 'Finance');

-- 1) A. Retrieving the column first_name from employees 
SELECT first_name FROM employees;

-- 2) B. Calculated column
SELECT first_name, salary, salary * 1.2 AS new_salary FROM employees;

-- 3) Precision Filtering
SELECT * FROM employees WHERE salary = 55000;
SELECT * FROM employees WHERE salary <= 62000;
SELECT * FROM employees WHERE hire_date BETWEEN '2021-06-12' AND '2022-09-15';
SELECT * FROM employees WHERE first_name LIKE 'E%';
SELECT * FROM employees WHERE department = 'HR' AND first_name LIKE 'D%';
SELECT * FROM employees WHERE salary IS NULL;

-- 4) Output Control
SELECT * FROM employees ORDER BY first_name DESC;
SELECT * FROM employees LIMIT 3 OFFSET 2;
SELECT * FROM employees ORDER BY last_name ASC , salary DESC;

-- 5) Data Validation
SELECT COUNT(*) AS total_count,
       MIN(salary) AS min_salary,
       MAX(hire_date) AS latest_hire
FROM employees
WHERE department = 'Sales' AND salary > 50000;
