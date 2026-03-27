create database ecommerce_db;

create schema shop;

create table shop.users (
	user_id serial primary key,
	username varchar(50) unique not null,
	email varchar(100) unique not null,
	password varchar(100) not null,
	role varchar(20) check (role in ('Customer','Admin'))
);

create table shop.categories (
	category_id serial primary key,
	category_name varchar(100) unique not null
);

create table shop.products (
	product_id serial primary key,
	product_name varchar(100) not null,
	price numeric(10,2) check (price > 0),
	stock int check (stock >= 0),
	category_id int,
	foreign key (category_id) references shop.categories(category_id)
);

create table shop.orders (
	order_id serial primary key,
	user_id int,
	order_date date not null,
	status varchar(20) check (status in ('Pending','Shipped','Delivered','Cancelled')),
	foreign key (user_id) references shop.users(user_id)
);

create table shop.orderdetails (
	order_detail_id serial primary key,
	order_id int,
	product_id int,
	quantity int check (quantity > 0),
	price_each numeric(10,2) check (price_each > 0),
	foreign key (order_id) references shop.orders(order_id),
	foreign key (product_id) references shop.products(product_id)
);

create table shop.payments (
	payment_id serial primary key,
	order_id int,
	amount numeric(10,2) check (amount >= 0),
	payment_date date not null,
	method varchar(30) check (method in ('Credit Card','Momo','Bank Transfer','Cash')),
	foreign key (order_id) references shop.orders(order_id)
);