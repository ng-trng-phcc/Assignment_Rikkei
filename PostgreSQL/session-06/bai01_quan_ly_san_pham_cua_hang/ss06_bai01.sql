create database ss06_bai01;

CREATE TABLE Product
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(100),
    category VARCHAR(50),
    price    NUMERIC(10, 2),
    stock    INT
);

-- 1. Thêm 5 sản phẩm vào bảng bằng lệnh INSERT
INSERT INTO Product (name, category, price, stock)
VALUES
    ('iPhone 15', 'Điện tử', 25000000, 10),
    ('Laptop Dell XPS', 'Điện tử', 35000000, 5),
    ('Chuột Logitech', 'Phụ kiện', 500000, 50),
    ('Bàn phím cơ', 'Phụ kiện', 1500000, 30),
    ('Tai nghe Sony', 'Điện tử', 3000000, 20);

-- 2. Hiển thị danh sách toàn bộ sản phẩm
SELECT *
FROM Product;

-- 3. Hiển thị 3 sản phẩm có giá cao nhất
-- Cách đơn giản, đúng 100% yêu cầu
SELECT *
FROM Product
ORDER BY price DESC
LIMIT 3;

-- Cách tối ưu, cách này sẽ xử lý được trường hợp nếu tồn tại nhiều hơn 3 sản phẩm cùng có mức giá cao nhất
SELECT *
FROM Product
WHERE price IN (
    SELECT DISTINCT price -- Khối này sẽ trả về 3 price cao nhất
    FROM Product
    ORDER BY price DESC
    LIMIT 3
)
ORDER BY price DESC;

-- 4. Hiển thị các sản phẩm thuộc danh mục “Điện tử” có giá < 10,000,000
SELECT *
FROM Product
WHERE category = 'Điện tử'
  AND price < 10000000;

-- 5. Sắp xếp sản phẩm theo số lượng tồn kho tăng dần
SELECT *
FROM Product
ORDER BY stock;