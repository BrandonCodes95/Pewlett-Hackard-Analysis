-- Creating tables for PH-EmployeeDB
CREATE TABLE employees (
              emp_no INT NOT NULL,
			  birth_date DATE NOT NULL,
			  first_name VARCHAR NOT NULL,
	          last_name VARCHAR NOT NULL,
	          gender VARCHAR NOT NULL, 
	          hire_date DATE NOT NULL,
	          PRIMARY KEY (emp_no)
	);
	
CREATE TABLE departments (
     dept_no VARCHAR(4) NOT NULL,
     dept_name VARCHAR(40) NOT NULL,
     PRIMARY KEY (dept_no),
     UNIQUE (dept_name)
);


CREATE TABLE dept_manager (
dept_no VARCHAR(4) NOT NULL,
    emp_no INT NOT NULL,
    from_date DATE NOT NULL,
    to_date DATE NOT NULL,
FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);


CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  from_date DATE NOT NULL,
  to_date DATE NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);

--CREATE TABLE title (
	--emp_no INT NOT NULL,
	--title VARCHAR NOT NULL,
	--from_date DATE NOT NULL,
	--to_date DATE NOT NULL,
	--FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	--PRIMARY KEY (title, from_date)



CREATE TABLE title (
	emp_no INT NOT NULL,
	title VARCHAR NOT NULL,
	from_date DATE NOT NULL,
	to_date DATE NOT NULL,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	PRIMARY KEY (from_date, emp_no)
);


CREATE TABLE department_employees (
	emp_no INT NOT NULL, 
	dept_no VARCHAR(4) NOT NULL, 
	from_date DATE NOT NULL,
	to_date DATE NOT NULL, 
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	PRIMARY KEY (emp_no, dept_no)
);

SELECT * FROM departments;

SELECT * FROM employees;

SELECT * FROM department_employees;

SELECT * FROM dept_manager;

SELECT * FROM salaries;

SELECT * FROM title; 


--Retirement Eligibility 
SELECT first_name, last_name 
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name
FROM employees 
WHERE birth_date BETWEEN '1952-01-01' AND '1952-12-31';

SELECT first_name, last_name
FROM employees 
WHERE birth_date BETWEEN '1953-01-01' AND '1953-12-31';

SELECT first_name, last_name
FROM employees 
WHERE birth_date BETWEEN '1954-01-01' AND '1954-12-31';

SELECT first_name, last_name 
FROM employees 
WHERE birth_date BETWEEN '1955-01-01' AND '1955-12-31'

--Number of Employees Retiring 
SELECT COUNT(first_name) 
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');


SELECT first_name, last_name 
INTO retirement_info
FROM employees 
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

SELECT * FROM retirement_info;

DROP TABLE retirement_employees;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT employees.emp_no, first_name, last_name, title, from_date, to_date
INTO retirement_employees
FROM employees
INNER JOIN title
ON employees.emp_no = title.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY employees.emp_no;

SELECT * FROM retirement_employees;

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_employees
ORDER BY retirement_employees.emp_no, to_date DESC;

SELECT * FROM unique_titles; 

--DROP TABLE unique_titles;

SELECT COUNT(title), title 
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;

SELECT * FROM retiring_titles;

DROP TABLE retiring_titles;

SELECT DISTINCT ON (employees.emp_no) employees.emp_no, first_name,
		last_name, birth_date, title, department_employees.to_date, 
		department_employees.from_date
INTO membership_eligibility 
FROM employees
INNER JOIN department_employees 
ON department_employees.emp_no = employees.emp_no
INNER JOIN title 
ON title.emp_no = employees.emp_no
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
     AND (employees.hire_date BETWEEN '1985-01-01' AND '9999-01-01')
ORDER BY employees.emp_no;

DROP TABLE membership_eligibility;
SELECT * FROM membership_eligibility 