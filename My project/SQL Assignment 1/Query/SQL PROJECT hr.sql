USE hr;

-- 1.Write a query to display the names (first_name, last_name) using alias name “First Name", "Last Name"
SELECT first_name,last_name FROM employees;

-- 2.Write a query to get unique department ID from employee table
SELECT DISTINCT department_id FROM employees;

-- 3.Write a query to get all employee details from the employee table order by first name, descending
SELECT * FROM employees ORDER BY first_name DESC;

-- 4.Write a query to get the names (first_name, last_name), salary, PF of all the employees (PF is calculated as 15% of salary)
SELECT first_name, last_name,salary,round(salary*.15 )PF FROM EMPLOYEES;

-- 5.Write a query to get the employee ID, names (first_name, last_name), salary in ascending order of salary
SELECT employee_id, first_name, last_name, salary FROM employees ORDER BY salary ASC;

-- 6.Write a query to get the total salaries payable to employees
SELECT SUM(SALARY) FROM EMPLOYEES;

-- 7.Write a query to get the maximum and minimum salary from employees table
SELECT MAX(SALARY), MIN(SALARY) FROM EMPLOYEES;

-- 8.Write a query to get the average salary and number of employees in the employees table
SELECT AVG(SALARY), COUNT(EMPLOYEE_ID) FROM EMPLOYEES;

-- 9.Write a query to get the number of employees working with the company
SELECT COUNT(*) FROM EMPLOYEES;

-- 10.Write a query to get the number of jobs available in the employees table
SELECT COUNT(DISTINCT job_id) FROM employees;

-- 11.Write a query get all first name from employees table in upper case
SELECT upper(first_name) FROM EMPLOYEES;

-- 12.Write a query to get the first 3 characters of first name from employees table
SELECT LEFT(first_name, 3) FROM employees;


--  13.Write a query to get first name from employees table after removing white spaces from both side
SELECT trim(first_name) FROM EMPLOYEES;

-- 14.Write a query to get the length of the employee names (first_name, last_name) from employees table
SELECT first_name, last_name, LENGTH(first_name) + LENGTH(last_name) 'LENGTH OF THE NAMES' FROM EMPLOYEES;

-- 15.Write a query to check if the first_name fields of the employees table contains numbers
SELECT * FROM employees WHERE first_name REGEXP '[0-9]';

-- 16.Write a query to display the name (first_name, last_name) and salary for all employees whose salary is 
-- not in the range $10,000 through $15,000
SELECT first_name, last_name, salary FROM EMPLOYEES WHERE SALARY NOT BETWEEN '10000' AND '15000';

-- 17.Write a query to display the name (first_name, last_name) and department ID of all employees in
-- departments 30 or 100 in ascending order
SELECT first_name, last_name, department_ID FROM EMPLOYEES WHERE department_ID IN(30,100) ORDER BY department_ID ASC;

-- 18.Write a query to display the name (first_name, last_name) and salary for all employees whose salary is
-- not in the range $10,000 through $15,000 and are in department 30 or 100
SELECT first_name, last_name, salary FROM EMPLOYEES WHERE SALARY NOT BETWEEN '10000' AND '15000' AND department_ID IN(30,100);

-- 19.Write a query to display the name (first_name, last_name) and hire date for all employees who were hired in 1987
SELECT first_name, last_name,HIRE_DATE FROM EMPLOYEES WHERE YEAR(HIRE_DATE) = '1987';

-- 20.Write a query to display the first_name of all employees who have both "b" and "c" in their first name
SELECT first_name FROM EMPLOYEES WHERE FIRST_NAME LIKE '%B%' AND FIRST_NAME LIKE '%C%';

-- 21.Write a query to display the last name, job, and salary for all employees whose job is that of a
-- Programmer or a Shipping Clerk, and whose salary is not equal to $4,500, $10,000, or $15,000
SELECT LAST_NAME,JOB_ID,SALARY FROM EMPLOYEES WHERE JOB_ID IN ('IT_PROG', 'SH_CLERK') and 
SALARY NOT IN (4500,10000,15000);

-- 22.Write a query to display the last name of employees whose names have exactly 6 characters
SELECT last_name FROM EMPLOYEES where LAST_NAME LIKE '______';

-- 23.Write a query to display the last name of employees having 'e' as the third character
SELECT last_name FROM EMPLOYEES where LAST_NAME LIKE '__E%';

-- 24.Write a query to get the job_id and related employee's id
SELECT job_id, GROUP_CONCAT(employee_id)FROM employees GROUP BY job_id;

-- 25.Write a query to update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
UPDATE EMPLOYEES SET phone_number = REPLACE(phone_number,'124','999') WHERE phone_number LIKE '%124%';

-- 26. Write a query to get the details of the employees where the length of the first name greater than or equal to 8
SELECT * FROM employees WHERE length(first_name) >= 8;

-- 27. Write a query to append '@example.com' to email field
UPDATE EMPLOYEES SET email = concat(email,'@example.com');

-- 28. Write a query to extract the last 4 character of phone numbers
SELECT RIGHT(phone_number,4) FROM EMPLOYEES;

-- 29. Write a query to get the last word of the street address
SELECT street_address, 
SUBSTRING_INDEX(REPLACE(REPLACE(REPLACE(street_address,',',' '),')',' '),'(',' '),' ',-1) 
AS 'Last word of street address' 
FROM locations;

-- 30. Write a query to get the locations that have minimum street length
SELECT * FROM locations WHERE length(street_address) <= (SELECT (min(length(street_address))) FROM LOCATIONS);

-- 31.Write a query to display the first word from those job titles which contains more than one words
SELECT job_title, SUBSTR(job_title,1, INSTR(job_title, ' ')-1)
FROM jobs;

-- 32. Write a query to display the length of first name for employees where last name contain character 'c' after 2nd position
SELECT first_name, last_name FROM employees WHERE INSTR(last_name,'C') > 2;

-- 33. Write a query that displays the first name and the length of the first name for all employees whose
-- name starts with the letters 'A', 'J' or 'M'. Give each column an appropriate label. Sort the results by the 'employees' first name
SELECT first_name, length(first_name) AS "LENGTH" FROM employees WHERE
first_name LIKE 'A%'
or first_name LIKE 'J%'
or first_name LIKE	'M' ORDER BY first_name;

-- 34. Write a query to display the first name and salary for all employees. Format the salary to be 10
-- characters long, left-padded with the $ symbol. Label the column SALARY Employees ID
SELECT first_name, LPAD(salary,10,'$') 'Salary' FROM employees;

-- 35. Write a query to display the first eight characters of the employees first names and indicates the amounts of their salaries with '$' sign. 
-- Each '$' sign signifies a thousand dollars. Sort the data in descending order of salary
SELECT left(first_name, 8),REPEAT('$', FLOOR(salary/1000)) 'SALARY($)', salary FROM employees ORDER BY salary DESC;  

-- 36. Write a query to display the employees with their code, first name, last name and hire date 
-- who hired either on seventh day of any month or seventh month in any year
SELECT employee_id,first_name,last_name,hire_date 
FROM employees 
WHERE POSITION("07" IN DATE_FORMAT(hire_date, '%d %m %Y'))>0;