create database ss07_baiTH;

create table sinh_vien
(
    id         serial primary key,
    ma_sv      varchar(20) unique,
    ho_ten     varchar(100) not null,
    email      varchar(150) not null,
    gioi_tinh  varchar(10),
    que_quan   varchar(100),
    ngay_sinh  date,
    lop_id     int,
    created_at timestamp default now()
);

create table lop_hoc
(
    id      serial primary key,
    ma_lop  varchar(20) unique,
    ten_lop varchar(100),
    khoa_id int
);

create table bang_diem
(
    id           serial primary key,
    sinh_vien_id int,
    mon_hoc_id   int,
    diem_so      decimal(4, 2),
    hoc_ky       varchar(10),
    created_at   timestamp default now()
);

create table mon_hoc
(
    id      serial primary key,
    ma_mon  varchar(20) unique,
    ten_mon varchar(100)
);

-- ================= INSERT DATA =================
INSERT INTO lop_hoc (ma_lop, ten_lop, khoa_id)
SELECT 'LOP' || LPAD(i::TEXT, 3, '0'),
       'Lớp ' || LPAD(i::TEXT, 3, '0'),
       (i % 10) + 1 -- 10 khoa
FROM generate_series(1, 500) AS i;

INSERT INTO mon_hoc (ma_mon, ten_mon)
SELECT 'MH' || LPAD(i::TEXT, 3, '0'),
       'Môn học ' || LPAD(i::TEXT, 3, '0')
FROM generate_series(1, 200) AS i;

-- Tạo 2.999.999 sinh viên ngẫu nhiên
INSERT INTO sinh_vien (ma_sv, ho_ten, email, gioi_tinh, que_quan, ngay_sinh, lop_id)
SELECT 'SV' || LPAD(i::TEXT, 7, '0'),
       CASE (i % 2)
           WHEN 0 THEN 'Nguyễn Văn ' || chr(65 + (i % 26))
           ELSE 'Trần Thị ' || chr(65 + (i % 26))
           END,
       'student' || i || '@example.com',
       CASE (i % 3) WHEN 0 THEN 'Nam' WHEN 1 THEN 'Nữ' ELSE 'Khác' END,
       CASE (i % 10)
           WHEN 0 THEN 'Hà Nội'
           WHEN 1 THEN 'Hồ Chí Minh'
           WHEN 2 THEN 'Đà Nẵng'
           WHEN 3 THEN 'Hải Phòng'
           WHEN 4 THEN 'Cần Thơ'
           WHEN 5 THEN 'Nghệ An'
           WHEN 6 THEN 'Bình Dương'
           WHEN 7 THEN 'Đồng Nai'
           WHEN 8 THEN 'Thái Nguyên'
           ELSE 'Thanh Hóa'
           END,
       DATE('1990-01-01') + (i % 10000) * INTERVAL '1 day',
       (i % 500) + 1
FROM generate_series(1, 2999999) AS i;

-- Chèn chính xác 1 sinh viên có email theo yêu cầu
INSERT INTO sinh_vien (ma_sv, ho_ten, email, gioi_tinh, que_quan, ngay_sinh, lop_id)
VALUES ('SV0000000',
        'Nguyễn Văn Nam',
        'nam.nguyen@techmaster.edu.vn',
        'Nam',
        'Hà Nội',
        '1995-05-15',
        1);

INSERT INTO bang_diem (sinh_vien_id, mon_hoc_id, diem_so, hoc_ky)
SELECT (random() * 2999999 + 1)::INT,    -- sinh_vien_id (bao gồm cả id của nam.nguyen)
       (random() * 199 + 1)::INT,        -- mon_hoc_id
       (random() * 40 + 10)::INT / 10.0, -- diem_so từ 1.0 đến 5.0
       'HK' || (random() * 7 + 1)::INT
FROM generate_series(1, 15000000);

-- ========================================================================================
-- 1. Index cho email (tìm kiếm nhanh)
create index idx_sinhvien_email on sinh_vien (email);

EXPLAIN ANALYZE
SELECT *
FROM sinh_vien
WHERE email = 'nam.nguyen@techmaster.edu.vn';

-- (Trước khi tạo index)
-- Planning Time: 0.227 ms
-- Execution Time: 270.974 ms

-- (Sau khi tạo index)
-- Planning Time: 0.227 ms
-- Execution Time: 0.079 ms


-- 2. Index cho khóa ngoại lop_id (JOIN nhanh)
create index idx_sinhvien_lop_id on sinh_vien(lop_id);

explain analyze
select * from sinh_vien where lop_id = 100;

-- (Trước khi có index)
-- Planning Time: 0.068 ms
-- Execution Time: 308.201 ms

-- (Sau khi có index)
-- Planning Time: 0.313 ms
-- Execution Time: 82.550 ms


-- 3. Index cho que_quan (báo cáo theo địa phương)
create index idx_sinhvien_que_quan on sinh_vien(que_quan);

explain analyze
select *
from sinh_vien
where que_quan = 'Hà Nội';

-- (Trước khi có index)
-- Planning Time: 0.233 ms
-- Execution Time: 540.327 ms

-- (Sau khi có index)
-- Planning Time: 0.173 ms
-- Execution Time: 437.037 ms


-- 4. Index composite cho (gioi_tinh, que_quan) (báo cáo kết hợp)
create index idx_sinhvien_gioi_tinh_que_quan on sinh_vien(gioi_tinh, que_quan);

explain analyze
select *
from sinh_vien
where gioi_tinh = 'Nam' and que_quan = 'Hà Nội';

-- (Trước khi có index)
-- Planning Time: 0.178 ms
-- Execution Time: 389.166 ms

-- (Sau khi có index)
-- Planning Time: 0.260 ms
-- Execution Time: 320.882 ms

