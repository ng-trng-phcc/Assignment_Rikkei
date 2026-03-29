create database ss06_bai10;

CREATE TABLE OldCustomers
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE NewCustomers
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

-- 1. Lấy danh sách tất cả khách hàng (cũ + mới) không trùng lặp
SELECT name, city
FROM OldCustomers
UNION
SELECT name, city
FROM NewCustomers;

-- 2. Tìm khách hàng vừa thuộc OldCustomers vừa thuộc NewCustomers
SELECT name, city FROM OldCustomers
INTERSECT
SELECT name, city FROM NewCustomers;

-- 3. Tính số lượng khách hàng ở từng thành phố
SELECT
    city,
    COUNT(*) AS total_customers
FROM (
         SELECT city FROM OldCustomers
         UNION ALL
         SELECT city FROM NewCustomers
     ) t
GROUP BY city;

-- 4. Tìm thành phố có nhiều khách hàng nhất
SELECT city, COUNT(*) AS total_customers
FROM (
         SELECT city FROM OldCustomers
         UNION ALL
         SELECT city FROM NewCustomers
     ) t
GROUP BY city
HAVING COUNT(*) = (
    SELECT MAX(city_count)
    FROM (
             SELECT COUNT(*) AS city_count
             FROM (
                      SELECT city FROM OldCustomers
                      UNION ALL
                      SELECT city FROM NewCustomers
                  ) x
             GROUP BY city
         ) y
);