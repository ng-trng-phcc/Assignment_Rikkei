-- Tạo db
create database University_DB;

-- Tạo schema
create schema university;

-- Tạo bảng students
create table university.students (
	student_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	birth_date date,
	email text not null unique
)

create table university.courses (
	course_id serial primary key,
	course_name varchar(100) not null,
	credits int
)

create table university.enrollments (
	enrollment_id serial primary key,
	student_id int,
	foreign key (student_id) references university.students(student_id),

	course_id int,
	foreign key (course_id) references university.courses(course_id),
	enroll_date date
)