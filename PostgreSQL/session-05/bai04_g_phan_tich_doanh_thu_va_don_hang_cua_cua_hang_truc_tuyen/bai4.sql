create database ss05_bai04;

CREATE TABLE customers
(
    customer_id   SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    city          VARCHAR(50)
);

CREATE TABLE orders
(
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT REFERENCES customers (customer_id),
    order_date   DATE,
    total_amount NUMERIC(10, 2)
);

CREATE TABLE order_items
(
    item_id      SERIAL PRIMARY KEY,
    order_id     INT REFERENCES orders (order_id),
    product_name VARCHAR(100),
    quantity     INT,
    price        NUMERIC(10, 2)
);

-- 1. Hiển thị danh sách tất cả các đơn hàng với các cột: Tên khách (customer_name), Ngày đặt hàng (order_date), Tổng tiền (total_amount)
select customer_name, order_date, total_amount
from orders o
         join customers c on c.customer_id = o.customer_id;

/* 2.
Tính các thông tin tổng hợp:

    Tổng doanh thu (SUM(total_amount))
    Trung bình giá trị đơn hàng (AVG(total_amount))
    Đơn hàng lớn nhất (MAX(total_amount))
    Đơn hàng nhỏ nhất (MIN(total_amount))
    Số lượng đơn hàng (COUNT(order_id))
*/
select sum(total_amount), avg(total_amount), max(total_amount), min(total_amount), count(order_id)
from orders;

/* 3.
  GROUP BY / HAVING:
    + Tính tổng doanh thu theo từng thành phố
    + chỉ hiển thị những thành phố có tổng doanh thu lớn hơn 10.000
*/
select city, sum(total_amount)
from orders o
         join customers c on o.customer_id = c.customer_id
group by city
having sum(total_amount) > 10.000;

/* 4.
Liệt kê tất cả các sản phẩm đã bán, kèm:

    Tên khách hàng
    Ngày đặt hàng
    Số lượng và giá
    (JOIN 3 bảng customers, orders, order_items)
*/
select customer_name, order_date, quantity, price
from orders o
         join customers c on c.customer_id = o.customer_id
         join order_items oi on o.order_id = oi.order_id;

-- 5. Tìm tên khách hàng có tổng doanh thu cao nhất.
select customer_name
from customers c
         join orders o on c.customer_id = o.customer_id
having o.customer_id in
       (select o.customer_id, sum(o.total_amount)
        from orders o
        group by o.customer_id);
