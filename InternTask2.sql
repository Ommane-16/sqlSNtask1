-- Use the correct database
USE employees;

-- Department Salary Summary

SELECT  
    d.dept_name AS Department, 
    COUNT(DISTINCT e.emp_no) AS Employees, 
    ROUND(AVG(s.salary), 2) AS Avg_Salary, 
    FORMAT(MIN(s.salary), 0) AS Min_Salary, 
    FORMAT(MAX(s.salary), 0) AS Max_Salary, 
    FORMAT(MAX(s.salary) - MIN(s.salary), 0) AS Salary_Range 
FROM departments d 
JOIN dept_emp de ON d.dept_no = de.dept_no 
JOIN employees e ON de.emp_no = e.emp_no 
JOIN salaries s ON e.emp_no = s.emp_no 
WHERE de.to_date > CURDATE()  
  AND s.to_date > CURDATE() 
GROUP BY d.dept_name 
ORDER BY Avg_Salary DESC;

-- Yearly Hiring Trends

SELECT  
    YEAR(hire_date) AS Hire_Year, 
    COUNT(*) AS New_Hires, 
    COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY YEAR(hire_date)) AS YoY_Change, 
    CONCAT(
      ROUND(
        100 * (COUNT(*) - LAG(COUNT(*)) OVER ()) / LAG(COUNT(*)) OVER (), 1
      ), '%'
    ) AS Growth_Rate 
FROM employees 
GROUP BY Hire_Year 
HAVING Hire_Year BETWEEN 1985 AND 1995 
ORDER BY Hire_Year;

-- 📌 3️⃣ High-Earning Departments

SELECT  
    d.dept_name, 
    ROUND(AVG(s.salary)) AS avg_salary, 
    COUNT(*) AS employees 
FROM departments d 
JOIN dept_emp de ON d.dept_no = de.dept_no 
JOIN salaries s ON de.emp_no = s.emp_no 
WHERE s.to_date > CURDATE() 
GROUP BY d.dept_name 
HAVING AVG(s.salary) > 70000 
   AND COUNT(*) > 10000;

-- Salary Distribution Report (Fixed)

SELECT  
    d.dept_name, 
    FLOOR(s.salary / 10000) * 10000 AS Salary_Bucket, 
    COUNT(*) AS Employees, 
    LPAD(
      CONCAT(
        ROUND(100 * COUNT(*) / SUM(COUNT(*)) OVER (PARTITION BY d.dept_name), 1),
        '%'
      ),
      5,
      ' '
    ) AS Distribution 
FROM departments d 
JOIN dept_emp de ON d.dept_no = de.dept_no 
JOIN salaries s ON de.emp_no = s.emp_no 
WHERE s.to_date > CURDATE() 
  AND d.dept_name = 'Sales' 
GROUP BY d.dept_name, Salary_Bucket 
ORDER BY Salary_Bucket;

-- Validation & Quality Checks

-- Total current employees
SELECT COUNT(DISTINCT emp_no) AS Current_Employees
FROM salaries 
WHERE to_date > CURDATE();

-- Check for null department assignments
SELECT COUNT(*) AS Null_Departments
FROM dept_emp 
WHERE dept_no IS NULL;

