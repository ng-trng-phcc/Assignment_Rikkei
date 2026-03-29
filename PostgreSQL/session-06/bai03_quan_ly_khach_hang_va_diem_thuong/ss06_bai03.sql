create database ss06_bai03;

CREATE TABLE Customer
(
    id     SERIAL PRIMARY KEY,
    name   VARCHAR(100),
    email  VARCHAR(100),
    phone  VARCHAR(20),
    points INT

);

-- 1. Thêm 7 khách hàng (1 người không có email)
INSERT INTO Customer (name, email, phone, points)
VALUES
    ('Nguyen Van An', 'an@gmail.com', '0901234567', 120),
    ('Tran Thi Binh', 'binh@gmail.com', '0902345678', 250),
    ('Le Van Cuong', 'cuong@gmail.com', '0903456789', 180),
    ('Pham Thi Dung', NULL, '0904567890', 300), -- không có email
    ('Hoang Minh Duc', 'duc@gmail.com', '0905678901', 90),
    ('Vo Thanh Hai', 'hai@gmail.com', '0906789012', 210),
    ('Do Thi Lan', 'lan@gmail.com', '0907890123', 150);

-- 2. Truy vấn danh sách tên khách hàng duy nhất
SELECT DISTINCT name
FROM Customer;

-- 3. Tìm các khách hàng chưa có email
SELECT *
FROM Customer
WHERE email IS NULL;

-- 4. Hiển thị 3 khách hàng có điểm thưởng cao nhất
--    bỏ qua khách hàng cao điểm nhất
SELECT *
FROM Customer
ORDER BY points DESC
OFFSET 1
    LIMIT 3;

-- 5. Sắp xếp danh sách khách hàng theo tên giảm dần
SELECT *
FROM Customer
ORDER BY name DESC;