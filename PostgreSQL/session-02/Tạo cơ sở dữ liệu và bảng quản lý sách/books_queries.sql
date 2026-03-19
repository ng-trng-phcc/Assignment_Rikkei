-- Tạo db
create database LibraryDB;

-- Tạo schema
create schema library;

-- Tạo bảng books theo schema
create table library.Books (
   book_id serial primary key,
   title varchar(100) not null,
   author varchar(50) not null,
   published_year int,
   price numeric(10, 2)
);

-- Query để xem tất cả các db hiện tại
SELECT datname
FROM pg_database;

--Query để xem tất cả các schema hiện tại
SELECT schema_name
FROM information_schema.schemata;

-- Query để xem cấu trúc bảng books (không bao gồm data)
SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'books';

-- Hoặc nếu xem cả bảng lẫn data thì
SELECT *
FROM library.books
