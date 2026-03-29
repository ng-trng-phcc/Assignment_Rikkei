create database ss06_bai08;

CREATE TABLE Customer
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- Bảng này lấy ở ss05_bai04
CREATE TABLE orders
(
    order_id     SERIAL PRIMARY KEY,
    id           INT REFERENCES Customer (id),
    order_date   DATE,
    total_amount NUMERIC(10, 2)
);

-- 1. Hiển thị tên khách hàng và tổng tiền đã mua, sắp xếp theo tổng tiền giảm dần
SELECT
    c.name,
    SUM(o.total_amount) AS total_spent
FROM Customer c
         JOIN orders o ON c.id = o.id
GROUP BY c.name
ORDER BY total_spent DESC;

-- 2. Tìm khách hàng có tổng chi tiêu cao nhất
SELECT *
FROM (
         SELECT
             c.name,
             SUM(o.total_amount) AS total_spent
         FROM Customer c
                  JOIN orders o ON c.id = o.id
         GROUP BY c.name
     ) t
WHERE total_spent = (
    SELECT MAX(total_spent)
    FROM (
             SELECT SUM(total_amount) AS total_spent
             FROM orders
             GROUP BY id
         ) sub
);

-- 3. Liệt kê khách hàng chưa từng mua hàng
SELECT c.*
FROM Customer c
         LEFT JOIN orders o ON c.id = o.id
WHERE o.order_id IS NULL;

-- 4. Hiển thị khách hàng có tổng chi tiêu > trung bình của toàn bộ khách hàng
SELECT
    c.name,
    SUM(o.total_amount) AS total_spent
FROM Customer c
         JOIN orders o ON c.id = o.id
GROUP BY c.name
HAVING SUM(o.total_amount) > (
    SELECT AVG(total_spent)
    FROM (
             SELECT SUM(total_amount) AS total_spent
             FROM orders
             GROUP BY id
         ) sub
);