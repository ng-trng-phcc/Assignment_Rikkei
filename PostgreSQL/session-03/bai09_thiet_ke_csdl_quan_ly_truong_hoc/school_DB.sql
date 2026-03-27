create database schooldb;

create schema school;

create table school.students (
	student_id serial primary key,
	name varchar(50),
	dob date
);

create table school.courses (
	course_id serial primary key,
	course_name varchar(50),
	credits integer
);

create table school.enrollments (
	enrollment_id serial primary key,
	student_id integer,
	course_id integer,
	grade char(1) check (grade in ('A','B','C','D','F')),
	foreign key (student_id) references school.students(student_id),
	foreign key (course_id) references school.courses(course_id),
);