create database ss07_baiTH_phan2_view;

create table sinh_vien
(
    id         serial primary key,
    ma_sv      varchar(20) unique,
    ho_ten     varchar(100) not null,
    email      varchar(150) not null,
    gioi_tinh  varchar(10),
    que_quan   varchar(100),
    ngay_sinh  date,
    lop_id     int references lop_hoc (id),
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
    sinh_vien_id int references sinh_vien (id),
    mon_hoc_id   int references mon_hoc (id),
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


-- View phức tạp: Thông tin SV + Lớp + Điểm TB
create view vw_bao_cao_diem as
select sv.id,
       sv.ma_sv,
       sv.ho_ten,
       sv.gioi_tinh,
       sv.email,
       sv.que_quan,
       lh.ten_lop,
       count(bd.id) as "Số môn đã học",
       avg(diem_so) as "Điểm TB"
from sinh_vien sv
         join lop_hoc lh on sv.lop_id = lh.id
         join bang_diem bd on sv.id = bd.sinh_vien_id
group by sv.id, sv.ma_sv, sv.ho_ten, sv.email, ten_lop;

-- View thống kê sĩ số + điểm trung bình lớp từng lớp
create view vw_thong_ke_si_so_dtb_theo_lop as
select lh.id,
       ma_lop,
       ten_lop,
       count(sv.id)                        as "Sỉ số",
       coalesce(round(avg(diem_so), 2), 0) as "Điểm trung bình toàn lớp"
from lop_hoc lh
         left join sinh_vien sv on lh.id = sv.lop_id
         left join bang_diem bd on sv.id = bd.sinh_vien_id
group by lh.id, ma_lop, ten_lop
order by lh.id;

-- 2.3. Tạo Materialized View cho báo cáo:

-- Dùng Materialized View cho báo cáo tổng hợp toàn trường
CREATE MATERIALIZED VIEW mv_thong_ke_toan_truong AS
SELECT que_quan,
       gioi_tinh,
       COUNT(*)       as so_luong,
       AVG("Điểm TB") as diem_tb_tinh
FROM vw_bao_cao_diem
GROUP BY que_quan, gioi_tinh;

-- View cho sinh viên - chỉ xem được thông tin của mình
CREATE VIEW vw_sinh_vien_ca_nhan AS
SELECT ma_sv, ho_ten, email, ten_lop, "Điểm TB"
FROM vw_bao_cao_diem
WHERE email = CURRENT_USER;  -- Giả sử user = email

-- View cho giảng viên - ẩn thông tin nhạy cảm
CREATE VIEW vw_giang_vien AS
SELECT
    ma_sv, ho_ten, ten_lop, "Điểm TB"
FROM vw_bao_cao_diem;