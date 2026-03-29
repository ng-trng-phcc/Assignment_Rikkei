create database ss06_bai04;

CREATE TABLE OrderInfo
(
    id          SERIAL PRIMARY KEY,
    customer_id INT,
    order_date  DATE,
    total       NUMERIC(10, 2),
    status      VARCHAR(20)
);

-- 1. Thêm 5 đơn hàng mẫu với tổng tiền khác nhau
INSERT INTO OrderInfo (customer_id, order_date, total, status)
VALUES
    (1, '2024-10-01', 300000, 'Pending'),
    (2, '2024-10-05', 750000, 'Completed'),
    (3, '2024-09-28', 1200000, 'Processing'),
    (1, '2024-10-15', 550000, 'Completed'),
    (4, '2024-11-02', 450000, 'Cancelled');

-- 2. Truy vấn các đơn hàng có tổng tiền lớn hơn 500,000
SELECT *
FROM OrderInfo
WHERE total > 500000;

-- 3. Truy vấn các đơn hàng có ngày đặt trong tháng 10 năm 2024
SELECT *
FROM OrderInfo
WHERE order_date BETWEEN '2024-10-01' AND '2024-10-31';

-- 4. Liệt kê các đơn hàng có trạng thái khác “Completed”
SELECT *
FROM OrderInfo
WHERE status <> 'Completed';

-- 5. Lấy 2 đơn hàng mới nhất
SELECT *
FROM OrderInfo
ORDER BY order_date DESC
LIMIT 2;