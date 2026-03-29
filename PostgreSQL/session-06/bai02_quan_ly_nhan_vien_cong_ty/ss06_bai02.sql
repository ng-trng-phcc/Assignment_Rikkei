create database ss06_bai02;

CREATE TABLE Employee
(
    id         SERIAL PRIMARY KEY,
    full_name  VARCHAR(100),
    department VARCHAR(50),
    salary     NUMERIC(10, 2),
    hire_date  DATE
);

-- 1. Thêm 6 nhân viên mới
INSERT INTO Employee (full_name, department, salary, hire_date)
VALUES
    ('Nguyen Van An', 'IT', 12000000, '2023-02-15'),
    ('Tran Thi Binh', 'HR', 8000000, '2022-06-10'),
    ('Le Van Cuong', 'IT', 15000000, '2023-07-20'),
    ('Pham Thi An', 'Marketing', 7000000, '2023-03-05'),
    ('Hoang Minh Duc', 'Finance', 9000000, '2021-11-01'),
    ('Vo Thanh An', 'IT', 5000000, '2023-09-12');

-- 2. Cập nhật tăng 10% lương cho phòng IT
UPDATE Employee
SET salary = salary * 1.10
WHERE department = 'IT';

-- 3. Xóa nhân viên có lương < 6,000,000
DELETE FROM Employee
WHERE salary < 6000000;

-- 4. Tìm nhân viên có tên chứa “An” (không phân biệt hoa thường)
SELECT *
FROM Employee
WHERE full_name ILIKE '%an%';

-- 5. Nhân viên vào làm trong năm 2023
SELECT *
FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31';