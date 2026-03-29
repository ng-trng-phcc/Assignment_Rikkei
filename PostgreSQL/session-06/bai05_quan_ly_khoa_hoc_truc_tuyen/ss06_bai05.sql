create database ss06_bai05;

CREATE TABLE Course
(
    id         SERIAL PRIMARY KEY,
    title      VARCHAR(100),
    instructor VARCHAR(50),
    price      NUMERIC(10, 2),
    duration   INT
);

-- 1. Thêm ít nhất 6 khóa học vào bảng
INSERT INTO Course (title, instructor, price, duration)
VALUES ('SQL Cơ Bản', 'Nguyen Van A', 500000, 20),
       ('SQL Nâng Cao', 'Tran Thi B', 1200000, 40),
       ('Java Backend', 'Le Van C', 2000000, 50),
       ('Python Data Analysis', 'Pham Thi D', 1500000, 35),
       ('Demo Web Development', 'Hoang Van E', 300000, 10),
       ('Spring Boot Mastery', 'Vo Van F', 1800000, 45);

-- 2. Cập nhật giá tăng 15% cho các khóa học có thời lượng trên 30 giờ
UPDATE Course
SET price = price * 1.15
WHERE duration > 30;

-- 3. Xóa khóa học có tên chứa từ khóa “Demo”
DELETE
FROM Course
WHERE title ILIKE '%demo%';

-- 4. Hiển thị các khóa học có tên chứa từ “SQL” (không phân biệt hoa thường)
SELECT *
FROM Course
WHERE title ILIKE '%sql%';

-- 5. Lấy 3 khóa học có giá từ 500,000 đến 2,000,000, sắp xếp theo giá giảm dần
SELECT *
FROM Course
WHERE price BETWEEN 500000 AND 2000000
ORDER BY price DESC
LIMIT 3;