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
);

-- Tạo bảng courses
create table university.courses (
	course_id serial primary key,
	course_name varchar(100) not null,
	credits int
);

-- Tạo bảng phụ enrollments
create table university.enrollments (
	enrollment_id serial primary key,
	student_id int,
	foreign key (student_id) references university.students(student_id),

	course_id int,
	foreign key (course_id) references university.courses(course_id),
	enroll_date date
);

-- Query để xem tất cả các db hiện tại
SELECT datname
FROM pg_database;

--Query để xem tất cả các schema hiện tại
SELECT schema_name
FROM information_schema.schemata;

-- Xem cấu trúc bảng students (bao gồm cả data)
select * from university.students;

-- Xem cấu trúc bảng courses (cả data)
select * from university.courses;

-- Xem cấu trúc bảng enrollments (cả data)
select * from university.enrollments;