create database Library_DB;

create schema library;

create table library.books (
	book_id serial primary key,
	title varchar(255),
	author varchar(255),
	published_year integer,
	available boolean default true
);

create table library.members (
	member_id integer primary key,
	name varchar(255),
	email varchar(255) unique,
	join_date date default current_date
);