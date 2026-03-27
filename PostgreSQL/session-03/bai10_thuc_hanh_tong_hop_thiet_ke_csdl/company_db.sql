create database company_db;

create schema company;

create table company.departments (
	department_id serial primary key,
	department_name varchar(50)
);

create table company.employees (
	emp_id serial primary key,
	name varchar(50),
	dob date,
	department_id integer,
	foreign key (department_id) references company.departments(department_id)
);

create table company.projects (
	project_id serial primary key,
	project_name varchar(50),
	start_date date,
	end_date date
);

create table company.employeeprojects (
	emp_id integer,
	project_id integer,
	primary key (emp_id, project_id),
	foreign key (emp_id) references company.employees(emp_id),
	foreign key (project_id) references company.projects(project_id)
);