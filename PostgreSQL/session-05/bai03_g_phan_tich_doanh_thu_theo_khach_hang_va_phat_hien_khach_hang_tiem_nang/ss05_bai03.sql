create database ss05_bai03;

create table customers
(
    customer_id   int primary key,
    customer_name varchar(100),
    city          varchar(100)
);

create table orders
(
    order_id    int primary key,
    customer_id int,
    order_date  date,
    total_price int,
    foreign key (customer_id) references customers (customer_id)
);

create table order_items
(
    item_id    int primary key,
    order_id   int,
    product_id int,
    quantity   int,
    price      int,
    foreign key (order_id) references orders (order_id)
);

insert into customers (customer_id, customer_name, city)
values (1, 'Nguyễn Văn A', 'Hà Nội'),
       (2, 'Trần Thị B', 'Đà Nẵng'),
       (3, 'Lê Văn C', 'Hồ Chí Minh'),
       (4, 'Phạm Thị D', 'Hà Nội');

insert into orders (order_id, customer_id, order_date, total_price)
values (101, 1, '2024-12-20', 3000),
       (102, 2, '2025-01-05', 1500),
       (103, 1, '2025-02-10', 2500),
       (104, 3, '2025-02-15', 4000),
       (105, 4, '2025-03-01', 800);

insert into order_items (item_id, order_id, product_id, quantity, price)
values (1, 101, 1, 2, 1500),
       (2, 102, 2, 1, 1500),
       (3, 103, 3, 5, 500),
       (4, 104, 2, 4, 1000);

/*
    1. Viết truy vấn hiển thị tổng doanh thu và tổng số đơn hàng của mỗi khách hàng:

    a. Chỉ hiển thị khách hàng có tổng doanh thu > 2000
    b. Dùng ALIAS: total_revenue và order_count
*/
select customer_id, count(order_id) as order_count, sum(total_price) as total_revenue -- câu b
from orders o
group by customer_id
having sum(total_price) > 2000;
-- câu a

/*
    2. Viết truy vấn con (Subquery) để tìm doanh thu trung bình của tất cả khách hàng

    +) Sau đó hiển thị những khách hàng có doanh thu lớn hơn mức trung bình đó
*/
select customer_id, avg(total_price)
from orders
group by customer_id
having avg(total_price) > (select avg(total_price)
                           from orders);

-- 3. Dùng HAVING + GROUP BY để lọc ra thành phố có tổng doanh thu cao nhất
select city, sum(total_price) as "Tổng doanh thu"
from orders o
         join customers c on c.customer_id = o.customer_id
group by city
having sum(total_price) = (
    select max(total_revenue)
    from (
             select sum(total_price) as total_revenue
             from orders o
                      join customers c on c.customer_id = o.customer_id
             group by city
         ) t
);
