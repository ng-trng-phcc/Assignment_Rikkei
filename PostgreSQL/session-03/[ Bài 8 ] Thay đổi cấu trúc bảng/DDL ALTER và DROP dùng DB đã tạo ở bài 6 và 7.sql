-- DB: LibraryDB (đã tạo ở bài 6)

alter table library.books add column genre varchar(100);

alter table library.books rename column available to is_available;

alter table library.members drop column email;

drop table sales.orderdetails;



/* Bài 6 + 7
create database Library_DB;

create schema library;

create table library.books (
	book_id integer primary key,
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

create schema sales;

create table sales.products (
	product_id serial primary key,
	product_name varchar(255),
	price numeric(10,2),
	stock_quantity integer
);

create table sales.orders (
	order_id serial primary key,
	order_date date default current_date,
	member_id integer,
	foreign key (member_id) references library.members(member_id)
);

create table sales.orderdetails (
	order_detail_id serial primary key,
	order_id integer,
	product_id integer,
	quantity integer,
	foreign key (order_id) references sales.orders(order_id),
	foreign key (product_id) references sales.products(product_id)
);
*/
