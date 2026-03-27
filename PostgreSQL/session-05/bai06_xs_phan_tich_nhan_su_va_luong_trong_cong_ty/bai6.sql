create database ss05_bai06;

CREATE TABLE departments
(
    dept_id   SERIAL PRIMARY KEY,
    dept_name VARCHAR(100)
);

CREATE TABLE employees
(
    emp_id    SERIAL PRIMARY KEY,
    emp_name  VARCHAR(100),
    dept_id   INT REFERENCES departments (dept_id),
    salary    NUMERIC(10, 2),
    hire_date DATE
);

alter table employees
    add constraint fkey FOREIGN KEY (dept_id) references departments (dept_id);

CREATE TABLE projects
(
    project_id   SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id      INT REFERENCES departments (dept_id)
);

-- 1a + b: Hiển thị danh sách nhân viên gồm: Tên nhân viên, Phòng ban, Lương
select emp_name, dept_name, salary
from employees e,
     departments d;

-- Câu 2a1: Tổng quỹ lương toàn công ty
select sum(salary)
from employees;

-- 2a2: Mức lương trung bình
select avg(salary)
from employees;

-- 2a3: Lương cao nhất, thấp nhất
select max(salary), min(salary)
from employees;

-- 2a4: Số nhân viên
select count(emp_id)
from employees;

-- 3a + b: Tính mức lương trung bình của từng phòng ban và chỉ hiển thị những phòng ban có lương trung bình > 15.000.000
select dept_id, avg(salary) as avg_sal
from employees
group by dept_id
having avg(salary) > 15.000;

-- 4: Liệt kê danh sách dự án (project) cùng với phòng ban phụ trách và nhân viên thuộc phòng ban đó
select p.project_name, d.dept_name, e.emp_name
from projects p
         join departments d ON p.dept_id = d.dept_id
         join employees e on d.dept_id = e.dept_id;

-- 5: Tìm nhân viên có lương cao nhất trong mỗi phòng ban
select e.emp_id, e.emp_name, e.dept_id, e.salary, e.hire_date
from employees e
join (select dept_id, max(salary) as max_salary
      from employees
      group by dept_id
      ) m
on e.dept_id = m.dept_id and e.salary = m.max_salary;