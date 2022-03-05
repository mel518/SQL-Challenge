CREATE TABLE titles(
	title_id VARCHAR primary key,
	title VARCHAR
	);

CREATE TABLE employees(
	emp_no SERIAL primary key,
	emp_title_id VARCHAR NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR NOT NULL,
	last_name VARCHAR NOT NULL,
	sex VARCHAR NOT NULL,
	hire_date DATE NOT NULL,
	foreign key (emp_title_id) references titles(title_id)
	);
	
CREATE TABLE departments(
	dept_no VARCHAR primary key,
	dept_name VARCHAR
	);
	
CREATE TABLE dept_manager(
	dept_no VARCHAR,
	emp_no SERIAL,
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no)
	);
	
CREATE TABLE dept_emp(
	emp_no SERIAL,
	dept_no VARCHAR, 
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no)
	);

CREATE TABLE salaries(
	emp_no SERIAL,
	salary INT,
	foreign key (emp_no) references employees(emp_no)
	);

------------------------------------------------------------

-- List the following details of each employee: 
-- employee number, last name, first name, sex, and salary.

select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from salaries
join employees on
employees.emp_no = salaries.emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986.
select first_name, last_name, hire_date 
from employees
where hire_date between '1/1/1986' and '12/31/1986';

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, last name, first name

select departments.dept_no, departments.dept_name, 
dept_manager.emp_no, employees.last_name, employees.first_name
from dept_manager
join employees on employees.emp_no = dept_manager.emp_no
join departments on departments.dept_no = dept_manager.dept_no;

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on departments.dept_no = dept_emp.dept_no;

-- List first name, last name, and sex for employees 
-- whose first name is "Hercules" and last names begin with "B."

select first_name, last_name, sex from employees
where first_name = 'Hercules' and last_name like 'B%';

-- List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on departments.dept_no = dept_emp.dept_no
where dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name.

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no
join departments on departments.dept_no = dept_emp.dept_no
where dept_name = 'Sales' or dept_name = 'Development';

-- In descending order, list the frequency count of employee last names, 
-- i.e., how many employees share each last name.

select last_name,
count(last_name) from employees
group by last_name
order by count(last_name) desc;

	