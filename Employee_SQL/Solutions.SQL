--QUERIES TO CHECK THAT ALL PRIMARY KEYS ARE UNIQUE:

SELECT COUNT(*) FROM titles;
SELECT COUNT(DISTINCT(title_id)) FROM titles;
--7 unique values from a total of 7 values. All are unique.

SELECT COUNT(*) FROM employees;
SELECT COUNT(DISTINCT(emp_no)) FROM employees;
--300024 unique values from a total of 300024 values. All are unique.

SELECT COUNT(*) FROM departments;
SELECT COUNT(DISTINCT(dept_no)) FROM departments;
--9 unique values from a total of 9 values. All are unique.

SELECT COUNT(*) FROM dept_manager;
SELECT COUNT(DISTINCT(dept_no, emp_no)) FROM dept_manager;
--24 unique values from a total of 24 values. All are unique.

SELECT COUNT(*) FROM dept_emp;
SELECT COUNT(DISTINCT(emp_no, dept_no)) FROM dept_emp;
--331603 unique values from a total of 331603 values. All are unique.

--QUESTION 1:

SELECT * FROM employees;
SELECT * FROM salaries;

--'emp_no', 'last_name', 'first_name' and 'sex' can all be found in the 'employees' table.
--To get each employee's SALARY we must join the 'employees' table with the 'salary' 
--table by 'emp_no'.

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
INNER JOIN salaries
ON employees.emp_no=salaries.emp_no;

--QUESTION 2:

SELECT * FROM employees;
SELECT * FROM salaries;

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1/1/1986' AND '31/12/1986';

--QUESTION 3:

SELECT * FROM dept_manager;
SELECT * FROM departments;
SELECT * FROM employees;

--To find the name of the departments that each manager was responsible for we must join
--the 'dept_managers' table with the 'departments' table by 'dept_no'.

--To find the details of each manager we must join also join 
--the 'employees' table.

SELECT dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN departments
ON dept_manager.dept_no=departments.dept_no
INNER JOIN employees
ON employees.emp_no=dept_manager.emp_no;

--QUESTION 4:

SELECT * FROM dept_manager;
SELECT * FROM dept_emp;
SELECT * FROM departments;
SELECT * FROM employees;

--To find the department number for each employee we must join
--the 'employees' table with the 'dept_emp' table by 'emp_no'.

--To find the name of each department that the employees worked in we must join also join 
--the 'departments' table.

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no=dept_emp.dept_no
ORDER BY emp_no;

--To check that all employees are represented in the table above we can create
--a VIEW called 'employee_departments' and count all the DISTINCT 'emp_no' values.

CREATE VIEW employee_departments AS
SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
INNER JOIN dept_emp
ON employees.emp_no=dept_emp.emp_no
INNER JOIN departments
ON departments.dept_no=dept_emp.dept_no
ORDER BY emp_no;

SELECT COUNT(DISTINCT(emp_no)) FROM employee_departments;
--There are 300024 distinct values in the view, for 300024 registered employees.
--All employees are present in the VIEW.

--QUESTION 5:

SELECT * FROM employees;

SELECT last_name, first_name, sex
FROM employees
WHERE last_name LIKE 'B%'
AND first_name='Hercules';

--QUESTION 6:

--This questions can best be answered by using the VIEW made in Question 4.

SELECT emp_no, last_name, first_name, dept_name
FROM employee_departments
WHERE dept_name = 'Sales';

--QUESTION 7:

--Again, this questions is best answered using the VIEW made in Question 4.

SELECT emp_no, last_name, first_name, dept_name
FROM employee_departments
WHERE dept_name = 'Sales'
OR dept_name = 'Development';

--QUESTION 8:

SELECT last_name, count(last_name) 
FROM employees
GROUP BY last_name;

--To check, list all employees whose last name is Breugel.
--Create a VIEW called 'breugel' and then count the rows in that view.

CREATE VIEW breugel AS
SELECT last_name, first_name
FROM employees
WHERE last_name = 'Breugel';
SELECT COUNT (*) FROM breugel;

--161 results returned.
--This matches the COUNT from the original table.

--To double check, list all employees whose last name is Dahlbom.
--Create a VIEW called 'dahlbom' and then count the rows in that view.

CREATE VIEW dahlbom AS
SELECT last_name, first_name
FROM employees
WHERE last_name = 'Dahlbom';
SELECT COUNT (*) FROM dahlbom;

--181 results returned.
--This matches the COUNT from the original table.

--BONUS SECTION:

--Please refer to the jupiter notebook which is in the GitHub repository.