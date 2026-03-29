create database ss06_bai06;

CREATE TABLE Orders
(
    id           SERIAL PRIMARY KEY,
    customer_id  INT,
    order_date   DATE,
    total_amount NUMERIC(10, 2)
);

-- 1. Hiển thị tổng doanh thu, số đơn hàng, giá trị trung bình mỗi đơn
SELECT SUM(total_amount) AS total_revenue,
       COUNT(*)          AS total_orders,
       AVG(total_amount) AS average_order_value
FROM Orders;

-- 2. Nhóm dữ liệu theo năm đặt hàng, hiển thị doanh thu từng năm
SELECT EXTRACT(YEAR FROM order_date) AS year,
       SUM(total_amount)             AS total_revenue
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date);

-- 3. Chỉ hiển thị các năm có doanh thu trên 50 triệu
SELECT EXTRACT(YEAR FROM order_date) AS year,
       SUM(total_amount)             AS total_revenue
FROM Orders
GROUP BY EXTRACT(YEAR FROM order_date)
HAVING SUM(total_amount) > 50000000;

-- 4. Hiển thị 5 đơn hàng có giá trị cao nhất
SELECT *
FROM Orders
ORDER BY total_amount DESC
LIMIT 5;