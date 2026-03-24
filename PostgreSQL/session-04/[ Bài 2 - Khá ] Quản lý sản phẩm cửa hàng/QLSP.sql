create database QLSP;

-- Tạo bảng
create table products
(
    id       serial primary key,
    name     varchar(50),
    category varchar(50),
    price    decimal(10, 2),
    stock    int
);

-- Thêm data
insert into products (name, category, price, stock)
values ('Laptop Dell', 'Electronics', 1500.00, 5),
       ('Chuột Logitech', 'Electronics', 25.50, 50),
       ('Bàn phím Lazer', 'Electronics', 120.00, 20),
       ('Tủ lạnh LG', 'Home Appliances', 800.00, 3),
       ('Máy giặt Samsung', 'Home Appliances', 600.00, 2);

-- Câu 1: Thêm sản phẩm mới: 'Điều hòa Panasonic', category 'Home Appliances', giá 400.00, stock 10
insert into products (name, category, price, stock)
VALUES ('Điều hòa Panasonic', 'Home Appliances', 400.00, 10);

-- Câu 2: Cập nhật stock của 'Laptop Dell' thành 7
update products
set stock = 7
where id = 1;

-- Câu 3: Xóa các sản phẩm có stock bằng 0 (nếu có)
delete
from products
where stock = 0;

-- Câu 4: Liệt kê tất cả sản phẩm theo giá tăng dần
select id, name, category, price, stock
from products
order by price;

-- Câu 5: Liệt kê danh mục duy nhất của các sản phẩm (DISTINCT)
select distinct category
from products;

-- Câu 6: Liệt kê sản phẩm có giá từ 100 đến 1000
select id, name, category, price, stock
from products
where price between 100 and 1000;

-- Câu 7: Liệt kê các sản phẩm có tên chứa từ 'LG' hoặc 'Samsung' (sử dụng LIKE/ILIKE)
select id, name, category, price, stock
from products p
where p.name ilike '%LG%'
   or p.name ilike '%samsung%';

-- Câu 8: Hiển thị 2 sản phẩm đầu tiên theo giá giảm dần, hoặc lấy sản phẩm thứ 2 đến thứ 3 bằng LIMIT và OFFSET
select *
from products p
order by p.price desc
limit 2 offset 1;