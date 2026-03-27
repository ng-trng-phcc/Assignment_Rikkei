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

/* 1.
    Viết truy vấn hiển thị tổng doanh thu (SUM(total_price)) và số lượng sản phẩm bán được (SUM(quantity)) cho từng nhóm danh mục (category)

        Đặt bí danh cột như sau:
            total_sales cho tổng doanh thu
            total_quantity cho tổng số lượng
   2. Chỉ hiển thị những nhóm có tổng doanh thu lớn hơn 2000
   3. Sắp xếp kết quả theo tổng doanh thu giảm dần
*/
select p.category, sum(o.quantity) as "Tổng số lượng", sum(o.total_price) as "Tổng doanh thu"
from products p
         join orders o on p.product_id = o.product_id
group by p.category
having sum(o.total_price) > 2000 -- Câu 2
order by sum(o.total_price) desc; -- Câu 3