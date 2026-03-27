create database ss05_bai01;

create table products
(
    product_id   serial primary key,
    product_name varchar(50),
    category     varchar(50)
);

create table orders
(
    order_id    int primary key,
    product_id  int,
    quantity    int,
    total_price int,
    foreign key (product_id) references products (product_id)
);

insert into products (product_name, category)
values ('Laptop Dell', 'Electronics'),
       ('Iphone15', 'Electronics'),
       ('Bàn học gỗ', 'Furniture'),
       ('Ghế xoay', 'Furniture');

insert into orders (order_id, product_id, quantity, total_price)
values (101, 1, 2, 2200),
       (102, 2, 3, 3300),
       (103, 3, 5, 2500),
       (104, 4, 4, 1600),
       (105, 1, 1, 1100);

-- 1. Viết truy vấn con (Subquery) để tìm sản phẩm có doanh thu cao nhất trong bảng orders (Hiển thị: product_name, total_revenue)
-- Cách này sẽ đảm bảo nếu có nhiều hơn 1 sản phẩm có cùng total_revenue và đều cao nhất thì sẽ được hiển thị hết thay vì chỉ 1 số nhất định như limit
select p.product_name, t.total_revenue
from products p
         join (select product_id, sum(total_price) as total_revenue
               from orders
               group by product_id) t
              on p.product_id = t.product_id
where t.total_revenue = (select max(total_revenue)
                         from (select sum(total_price) as total_revenue
                               from orders
                               group by product_id) x);

-- 2. Viết truy vấn hiển thị tổng doanh thu theo từng nhóm category (dùng JOIN + GROUP BY)
select p.category, sum(o.total_price) as "Tổng doanh thu"
from products p
         join orders o on p.product_id = o.product_id
group by p.category