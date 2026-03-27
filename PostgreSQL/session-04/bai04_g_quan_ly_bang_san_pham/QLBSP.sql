-- Tạo DB
create database qlbsp;

-- Tạo bảng
create table products
(
    id           int primary key,
    name         varchar(255),
    category     varchar(100),
    price        bigint,
    stock        int,
    manufacturer varchar(100)
);

-- Thêm data
insert into products (id, name, category, price, stock, manufacturer)
values (1, 'Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
       (2, 'Chuột Logitech M90', 'Phụ kiện', 150000, 50, 'Logitech'),
       (3, 'Bàn phím cơ Razer', 'Phụ kiện', 2200000, 0, 'Razer'),
       (4, 'Macbook Air M2', 'Laptop', 32000000, 7, 'Apple'),
       (5, 'iPhone 14 Pro Max', 'Điện thoại', 35000000, 15, 'Apple'),
       (6, 'Laptop Dell XPS 13', 'Laptop', 25000000, 12, 'Dell'),
       (7, 'Tai nghe AirPods 3', 'Phụ kiện', 4500000, null, 'Apple');

-- Câu 1: Thêm sản phẩm “Chuột không dây Logitech M170”, loại Phụ kiện, giá 300000, tồn kho 20, hãng Logitech
insert into products (name, category, price, stock, manufacturer)
values ('Chuột không dây Logitech M170', 'Phụ kiện', 300000, 20, 'Logitech');

-- Câu 2: Tăng giá tất cả sản phẩm của Apple thêm 10%
update products
set price = price * 1.10
where manufacturer = 'Apple';

-- Câu 3: Xóa sản phẩm có stock = 0
delete
from products
where stock = 0;

-- Câu 4: Hiển thị sản phẩm có price BETWEEN 1000000 AND 30000000
select id, name, category, price, stock, manufacturer
from products
where price between 1000000 and 30000000;

-- Câu 5: Hiển thị sản phẩm có stock IS NULL
select id, name, category, price, stock, manufacturer
from products
where stock is null;

-- Câu 6: Liệt kê danh sách hãng sản xuất duy nhất
select distinct manufacturer
from products;

-- Câu 7: Hiển thị toàn bộ sản phẩm, sắp xếp giảm dần theo giá, sau đó tăng dần theo tên
select id, name, category, price, stock, manufacturer
from products
order by price desc, name;

-- Câu 8: Tìm sản phẩm có tên chứa từ “laptop” (không phân biệt hoa thường)
select id, name, category, price, stock, manufacturer
from products
where name ilike '%laptop%';

-- Câu 9: Lấy về 2 sản phẩm đầu tiên sau khi sắp xếp theo giá giảm dần
select id, name, category, price, stock, manufacturer
from products
order by price desc
limit 2;