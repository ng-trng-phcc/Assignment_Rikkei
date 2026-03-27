create database Sales_DB;

create schema sales;

create table sales.Customers (
	customer_id serial primary key,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	email varchar(100) not null unique,
	phone varchar(11)
)

create table sales.Products (
	product_id serial primary key,
	product_name varchar(100) not null,
	price numeric(10, 2) not null,
	stock_quantity int not null
)

create table sales.orders (
	order_id serial primary key,
	customer_id int,
	foreign key (customer_id) references sales.customers(customer_id),
	order_date date not null	
)

create table sales.order_items (
	order_item_id serial primary key,
	order_id int,
	foreign key (order_id) references sales.orders(order_id),
	product_id int,
	foreign key (product_id) references sales.products(product_id),
	quantity int  check (quantity > 0)
)
	