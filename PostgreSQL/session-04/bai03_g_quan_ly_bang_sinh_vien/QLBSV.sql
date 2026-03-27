-- Tạo db
create database QLbsv;

-- Tạo bảng students
create table students
(
    id         serial primary key,
    full_name  varchar(50),
    gender     varchar(50),
    birth_year int,
    major      varchar(50),
    gpa        numeric(4, 2)
);

-- Thêm data
insert into students (full_name, gender, birth_year, major, gpa)
values ('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
       ('Trần Thị Bích Ngọc', 'Nữ', 2001, 'Kinh tế', 3.2),
       ('Lê Quốc Cường', 'Nam', 2003, 'CNTT', 2.7),
       ('Phạm Minh Anh', 'Nữ', 2000, 'Luật', 3.9),
       ('Nguyễn Văn A', 'Nam', 2002, 'CNTT', 3.6),
       ('Lưu Đức Tài', '2004', 2004, 'Cơ Khí', null),
       ('Võ Thị Thu Hằng', 'Nữ', 2001, 'CNTT', 3.0);

-- Câu 1: Thêm sinh viên “Phan Hoàng Nam”, giới tính Nam, sinh năm 2003, ngành CNTT, GPA 3.8
insert into students (full_name, gender, birth_year, major, gpa)
values ('Phan Hoàng Nam', 'Nam', 2003, 'CNTT', 3.8);

-- Câu 2: Sinh viên “Lê Quốc Cường” vừa cải thiện học lực, cập nhật gpa = 3.4
update students
set gpa = 3.4
where id = 3;

-- Câu 3: Xóa tất cả sinh viên có gpa IS NULL
delete
from students
where gpa isnull;

-- Câu 4: Hiển thị sinh viên ngành CNTT có gpa >= 3.0, chỉ lấy 3 kết quả đầu tiên
select id, full_name, gender, birth_year, major, gpa
from students s
where s.gpa >= 3.0
order by gpa desc
limit 3;

-- Câu 5: Liệt kê danh sách ngành học duy nhất
select distinct major
from students;

-- Câu 6: Hiển thị sinh viên ngành CNTT, sắp xếp giảm dần theo GPA, sau đó tăng dần theo tên
select *
from students
where major = 'CNTT'
  and id in (select id
             from students
             order by gpa desc)
order by full_name;

-- Câu 7: Tìm sinh viên có tên bắt đầu bằng “Nguyễn”
select id, full_name, gender, birth_year, major, gpa
from students
where full_name ilike 'Nguyễn%';

-- Câu 8: Hiển thị sinh viên có năm sinh từ 2001 đến 2003
select id, full_name, gender, birth_year, major, gpa
from students
where birth_year between 2001 and 2003;