-- Tạo db
create database qllnv;

-- Tạo bảng
create table employees
(
    id         serial primary key,
    full_name  varchar(100),
    department varchar(50),
    position   varchar(50),
    salary     bigint,
    bonus      bigint,
    join_year  int
);

-- Thêm data
insert into employees (full_name, department, position, salary, bonus, join_year)
values ('Nguyễn Văn Huy', 'IT', 'Developer', 18000000, 1000000, 2021),
       ('Trần Thị Mai', 'HR', 'Recruiter', 12000000, null, 2020),
       ('Lê Quốc Trung', 'IT', 'Tester', 15000000, 800000, 2023),
       ('Nguyễn Văn Huy', 'IT', 'Developer', 18000000, 1000000, 2021),
       ('Phạm Ngọc Hân', 'Finance', 'Accountant', 14000000, null, 2019),
       ('Bùi Thị Lan', 'HR', 'HR Manager', 20000000, 3000000, 2018),
       ('Đặng Hữu Tài', 'IT', 'Developer', 17000000, null, 2022);

-- Câu 2a: Tăng 10% lương cho những nhân viên làm trong phòng IT có mức lương dưới 18,000,000
update employees
set salary = salary * 1.10
where department = 'IT'
  and salary < 18000000;

-- Câu 2b: Với nhân viên có bonus IS NULL, đặt giá trị bonus = 500000
update employees
set bonus = 500000
where bonus is null;

-- Câu 3a: Hiển thị danh sách nhân viên thuộc phòng IT hoặc HR, gia nhập sau năm 2020, và có tổng thu nhập (salary + bonus) lớn hơn 15,000,000
select full_name, department, position, salary, bonus, join_year
from employees
where (department = 'IT' or department = 'HR')
  and join_year > 2020
  and (salary + bonus) > 15000000;

-- Câu 3b: Chỉ lấy 3 nhân viên đầu tiên sau khi sắp xếp giảm dần theo tổng thu nhập
select full_name, department, position, salary, bonus, join_year
from employees
order by (salary + bonus) desc
limit 3;

-- Câu 4: Tìm tất cả nhân viên có tên bắt đầu bằng “Nguyễn” hoặc kết thúc bằng “Hân”
select full_name, department, position, salary, bonus, join_year
from employees
where full_name like 'Nguyễn%'
   or full_name like '%Hân';

-- Câu 5: Liệt kê các phòng ban duy nhất có ít nhất một nhân viên có bonus IS NOT NULL
select distinct department
from employees
where bonus is not null;

-- Câu 6: Hiển thị nhân viên gia nhập trong khoảng từ 2019 đến 2022 (BETWEEN)
select full_name, department, position, salary, bonus, join_year
from employees
where join_year between 2019 and 2022;