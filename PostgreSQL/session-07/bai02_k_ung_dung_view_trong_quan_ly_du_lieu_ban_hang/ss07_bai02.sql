create database ss07_bai02;

CREATE TABLE customer
(
    customer_id SERIAL PRIMARY KEY,
    full_name   VARCHAR(100),
    email       VARCHAR(100),
    phone       VARCHAR(15)

);

CREATE TABLE orders
(
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT REFERENCES customer (customer_id),
    total_amount DECIMAL(10, 2),
    order_date   DATE

);

/*
   1. Tạo một View tên v_order_summary hiển thị:

        full_name, total_amount, order_date
        (ẩn thông tin email và phone)
*/
create view v_order_summary as
select full_name, total_amount, order_date
from orders o
join customer c on o.customer_id = c.customer_id;

-- 2. Viết truy vấn để xem tất cả dữ liệu từ View
select full_name, total_amount, order_date
from v_order_summary;

/*
    3. Tạo 1 view lấy về thông tin của tất cả các đơn hàng với điều kiện total_amount ≥ 1 triệu.
       Sau đó bạn hãy cập nhật lại thông tin 1 bản ghi trong view đó nhé .
*/

-- a. Tạo 1 view lấy về thông tin của tất cả các đơn hàng với điều kiện total_amount ≥ 1 triệu.
select full_name, total_amount, order_date
from v_order_summary vos
where vos .total_amount > 1000000;

-- Sau đó bạn hãy cập nhật lại thông tin 1 bản ghi trong view đó nhé.
update orders
set total_amount = 1000001
where order_date = current_date;