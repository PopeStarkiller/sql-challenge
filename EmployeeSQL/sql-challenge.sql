
CREATE TABLE "employees" (
    "emp_no" integer   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "gender" VARCHAR   NOT NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_managers" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" integer   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR   NOT NULL,
    "frome_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "dept_managers" ADD CONSTRAINT "fk_dept_managers_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_managers" ADD CONSTRAINT "fk_dept_managers_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "titles" ADD CONSTRAINT "fk_titles_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

SELECT employees.emp_no, employees.first_name, employees.last_name, employees.gender, salaries.salary
FROM salaries
INNER JOIN employees ON
employees.emp_no=salaries.emp_no;

select employees.first_name, employees.last_name, employees.hire_date
from employees
where hire_date >= '1/1/1986' AND hire_date <= '12/31/1986'
;
-- List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name.
SELECT dept_managers.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name 
FROM ((dept_managers
INNER JOIN employees ON
employees.emp_no=dept_managers.emp_no)
INNER JOIN departments ON
departments.dept_no=dept_managers.dept_no);
;

--List the department of each employee with the following information: 
--employee number, last name, first name, and department name.
SELECT  employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM ((dept_managers
FULL OUTER JOIN employees ON
employees.emp_no=dept_managers.emp_no)
FULL OUTER JOIN departments ON
departments.dept_no=dept_managers.dept_no);
;

--List first name, last name, and sex for employees whose first name is 
--"Hercules" and last names begin with "B."

select employees.first_name, employees.last_name, employees.gender
from employees
where first_name = 'Hercules' and last_name like '%B%'
;

--List all employees in the Sales department, including their 
--employee number, last name, first name, and department name

select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM ((dept_managers
FULL OUTER JOIN employees ON
employees.emp_no=dept_managers.emp_no)
FULL OUTER JOIN departments ON
departments.dept_no=dept_managers.dept_no)
WHERE departments.dept_name = 'Sales'
;

-- List all employees in the Sales and Development departments, including their 
--employee number, last name, first name, and department name.
select employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM ((dept_managers
FULL OUTER JOIN employees ON
employees.emp_no=dept_managers.emp_no)
FULL OUTER JOIN departments ON
departments.dept_no=dept_managers.dept_no)
WHERE departments.dept_name like 'Sales' OR departments.dept_name like 'Development'
;

--In descending order, list the frequency count of employee last names, i.e.,
--how many employees share each last name.

SELECT COUNT(employees.last_name), employees.last_name
from employees
GROUP BY last_name
ORDER BY last_name;