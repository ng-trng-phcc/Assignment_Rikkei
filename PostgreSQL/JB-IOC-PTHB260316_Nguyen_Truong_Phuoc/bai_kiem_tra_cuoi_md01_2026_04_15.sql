create database ktra_cuoi_md01;

-- ================ PHẦN 1: Thao tác với dữ liệu các bảng ================

create table customers
(
    customer_id        varchar(5) primary key,
    customer_full_name varchar(100)        not null,
    customer_email     varchar(100) unique not null,
    customer_phone     varchar(15)         not null,
    customer_address   varchar(255)        not null
);

create table rooms
(
    room_id     varchar(5) primary key,
    room_type   varchar(50)    not null,
    room_price  decimal(10, 2) not null,
    room_status varchar(20)    not null,
    room_area   int            not null
);

create table bookings
(
    booking_id     serial primary key,
    customer_id    varchar(5) not null references customers (customer_id),
    room_id        varchar(5) not null references rooms (room_id),
    check_in_date  date       not null,
    check_out_date date       not null,
    total_amount   decimal(10, 2)
);

create table payments
(
    payment_id     serial primary key,
    booking_id     int            not null references bookings (booking_id),
    payment_method varchar(50)    not null,
    payment_date   date           not null,
    payment_amount decimal(10, 2) not null
);

-- 2. Chèn dữ liệu (6 điểm) Thêm dữ liệu vào 4 bảng đã tạo
insert into customers (customer_id, customer_full_name, customer_email, customer_phone, customer_address)
values ('C001', 'Nguyen Anh Tu', 'tu.nguyen@example.com', '0912345678', 'Hanoi, Vietnam'),
       ('C002', 'Tran Thi Mai', 'mai.tran@example.com', '0923456789', 'Ho Chi Minh, Vietnam'),
       ('C003', 'Le Minh Hoang', 'hoang.le@example.com', '0934567890', 'Danang, Vietnam'),
       ('C004', 'Pham Hoang Nam', 'nam.phan@example.com', '0945678901', 'Hue, Vietnam'),
       ('C005', 'Vu Minh Thu', 'thu.vu@example.com', '0956789012', 'Hai Phong, Vietnam'),
       ('C006', 'Nguyen Thi Lan', 'lan.nguyen@example.com', '0967890123', 'Quang Ninh, Vietnam'),
       ('C007', 'Bui Minh Tuan', 'tuan.bui@example.com', '0978901234', 'Bac Giang, Vietnam'),
       ('C008', 'Pham Quang Hieu', 'hieu.pham@example.com', '0989012345', 'Quang Nam, Vietnam'),
       ('C009', 'Le Thi Lan', 'lan.le@example.com', '0990123456', 'Da Lat, Vietnam'),
       ('C010', 'Nguyen Thi Mai', 'mai.nguyen@example.com', '0901234567', 'Can Tho, Vietnam');

insert into rooms (room_id, room_type, room_price, room_status, room_area)
values ('R001', 'Single', 100.0, 'Available', 25),
       ('R002', 'Double', 150.0, 'Booked', 40),
       ('R003', 'Suite', 250.0, 'Available', 60),
       ('R004', 'Single', 120.0, 'Booked', 30),
       ('R005', 'Double', 160, 'Available', 35);

insert into bookings (customer_id, room_id, check_in_date, check_out_date, total_amount)
values ('C001', 'R001', '2025-03-01', '2025-03-05', 400.0),
       ('C002', 'R002', '2025-03-02', '2025-03-06', 600.0),
       ('C003', 'R003', '2025-03-03', '2025-03-07', 1000.0),
       ('C004', 'R004', '2025-03-04', '2025-03-08', 480.0),
       ('C005', 'R005', '2025-03-05', '2025-03-09', 800.0),
       ('C006', 'R001', '2025-03-06', '2025-03-10', 400.0),
       ('C007', 'R002', '2025-03-07', '2025-03-11', 600.0),
       ('C008', 'R003', '2025-03-08', '2025-03-12', 1000.0),
       ('C009', 'R004', '2025-03-09', '2025-03-13', 480.0),
       ('C010', 'R005', '2025-03-10', '2025-03-14', 800.0);

insert into payments (booking_id, payment_method, payment_date, payment_amount)
values (1, 'Cash', '2025-03-05', 400.0),
       (2, 'Credit Card', '2025-03-06', 600.0),
       (3, 'Bank Transfer', '2025-03-07', 1000.0),
       (4, 'Cash', '2025-03-08', 480.0),
       (5, 'Credit Card', '2025-03-09', 800.0),
       (6, 'Bank Transfer', '2025-03-10', 400.0),
       (7, 'Cash', '2025-03-11', 600.0),
       (8, 'Credit Card', '2025-03-12', 1000.0),
       (9, 'Bank Transfer', '2025-03-13', 480.0),
       (10, 'Cash', '2025-03-14', 800.0);

-- 3. Cập nhật dữ liệu (8 điểm) Viết câu lệnh UPDATE để cập nhật lại total_amount trong bảng Booking theo công thức: total_amount = room_price * (số ngày lưu trú).
update bookings b
set total_amount = r.room_price * (check_out_date - check_in_date)
from rooms r
where r.room_id = b.room_id and room_status = 'Booked' and check_in_date < current_date;

select *
from bookings;

/*
    4. Xóa dữ liệu (6 điểm) Viết câu lệnh DELETE để xóa các thanh toán trong bảng Payment nếu:
      - Phương thức thanh toán (payment_method) là "Cash".
      - Và tổng tiền thanh toán (payment_amount) nhỏ hơn 500.
*/
delete
from payments
where payment_method = 'Cash' and payment_amount < 500;


-- ========== PHẦN 2: Truy vấn dữ liệu ==========

-- 5. (3 điểm) Lấy thông tin khách hàng gồm mã khách hàng, họ tên, email, số điện thoại và địa chỉ được sắp xếp theo họ tên khách hàng tăng dần.
select customer_id, customer_full_name, customer_email, customer_phone, customer_address
from customers
order by customer_full_name;

-- 6. (3 điểm) Lấy thông tin các phòng khách sạn gồm mã phòng, loại phòng, giá phòng và diện tích phòng, sắp xếp theo giá phòng giảm dần.
select room_id, room_type, room_price, room_area
from rooms
order by room_price desc;

-- 7. (3 điểm) Lấy thông tin khách hàng và phòng khách sạn đã đặt, gồm mã khách hàng, họ tên khách hàng, mã phòng, ngày nhận phòng.
select c.customer_id, customer_full_name, room_id, check_in_date
from bookings b
join customers c on c.customer_id = b.customer_id;

-- 8. (3 điểm) Lấy danh sách khách hàng và tổng tiền đã thanh toán khi đặt phòng, gồm mã khách hàng, họ tên khách hàng, phương thức thanh toán và số tiền thanh toán, sắp xếp theo số tiền thanh toán giảm dần.
select c.customer_id, customer_full_name, payment_method, payment_amount
from payments p
         join bookings b on b.booking_id = p.booking_id
         join customers c on c.customer_id = b.customer_id
order by payment_amount desc;

-- 9. (3 điểm) Lấy thông tin khách hàng từ vị trí thứ 2 đến thứ 4 trong bảng Customer được sắp xếp theo tên khách hàng.
select customer_id, customer_full_name, customer_email, customer_phone, customer_address
from customers
order by customer_full_name desc
limit 3 offset 1;

-- 10. (5 điểm) Lấy danh sách khách hàng đã đặt ít nhất 2 phòng và có tổng số tiền thanh toán trên 1000, gồm mã khách hàng, họ tên khách hàng và số lượng phòng đã đặt.
select b.customer_id, customer_full_name, count(booking_id) as "Số lượng phòng đã đặt"
from customers c
         join bookings b on c.customer_id = b.customer_id
where total_amount > 1000
group by b.customer_id, customer_full_name
having count(booking_id) >= 2;

-- 11. (5 điểm) Lấy danh sách các phòng có tổng số tiền thanh toán dưới 1000 và có ít nhất 3 khách hàng đặt, gồm mã phòng, loại phòng, giá phòng và tổng số tiền thanh toán.
select r.room_id, room_type, room_price, total_amount
from bookings b
         join rooms r on r.room_id = b.room_id
where total_amount < 1000
group by r.room_id, room_type, room_price, total_amount
having count(customer_id) >= 3;

-- 12. (5 điểm) Lấy danh sách các khách hàng có tổng số tiền thanh toán lớn hơn 1000, gồm mã khách hàng, họ tên khách hàng, mã phòng, tổng số tiền thanh toán.
select c.customer_id, customer_full_name, room_id, total_amount
from customers c
         join bookings b on c.customer_id = b.customer_id
where total_amount > 1000;

-- 13. (6 điểm) Lấy danh sách các khách hàng Mã KH, Họ tên, Email, SĐT) có họ tên chứa chữ "Minh" hoặc địa chỉ (address) ở "Hanoi". Sắp xếp kết quả theo họ tên tăng dần.
select customer_id, customer_full_name, customer_email, customer_phone
from customers c
where c.customer_full_name ilike '%Minh%' or customer_address like 'Hanoi%'
order by customer_full_name;

-- 14. (4 điểm)  Lấy danh sách tất cả các phòng (Mã phòng, Loại phòng, Giá), sắp xếp theo giá phòng giảm dần. Hiển thị 5 phòng tiếp theo sau 5 phòng đầu tiên (tức là lấy kết quả của trang thứ 2, biết mỗi trang có 5 phòng).
select room_id, room_type, room_price
from rooms
order by room_price desc
limit 5 offset 5;


-- =================== PHẦN 3: Tạo View ===================

-- 15. (5 điểm) Hãy tạo một view để lấy thông tin các phòng và khách hàng đã đặt, với điều kiện ngày nhận phòng nhỏ hơn ngày 2025-03-10.
-- Cần hiển thị các thông tin sau: Mã phòng, Loại phòng, Mã khách hàng, họ tên khách hàng
create view vw_ttin_khach_hang_va_phong_da_dat_truoc_10_3_2025 as
select r.room_id, room_type, c.customer_id, customer_full_name
from bookings b
         join rooms r on r.room_id = b.room_id
         join customers c on c.customer_id = b.customer_id
where check_in_date < '2025-03-10';

select *
from vw_ttin_khach_hang_va_phong_da_dat_truoc_10_3_2025;

-- 16. (5 điểm) Hãy tạo một view để lấy thông tin khách hàng và phòng đã đặt, với điều kiện diện tích phòng lớn hơn 30 m².
-- Cần hiển thị các thông tin sau: Mã khách hàng, Họ tên khách hàng, Mã phòng, Diện tích phòng
create view vw_ttin_khach_hang_va_phong_lon_hon_30m²_da_dat as
select c.customer_id, customer_full_name, r.room_id, room_area
from bookings b
         join rooms r on r.room_id = b.room_id
         join customers c on c.customer_id = b.customer_id
where room_area > 30;

select *
from vw_ttin_khach_hang_va_phong_lon_hon_30m²_da_dat;


-- ==================== PHẦN 4: Tạo Trigger ====================

-- 17. (5 điểm) Hãy tạo một trigger check_insert_booking để kiểm tra dữ liệu mối khi chèn vào bảng Booking.
-- Kiểm tra nếu ngày đặt phòng mà sau ngày trả phòng thì thông báo lỗi với nội dung “Ngày đặt phòng không thể sau ngày trả phòng được !” và hủy thao tác chèn dữ liệu vào bảng.
create or replace function fn_check_insert_booking()
    returns trigger as
$$
begin
    if new.check_in_date > new.check_out_date then
        raise exception 'Ngày đặt phòng không thể sau ngày trả phòng được !';
    end if;

    return new;
end;
$$ language plpgsql;

-- Tao trigger
create trigger trg_check_insert_booking
    before insert
    on bookings
    for each row
execute function fn_check_insert_booking();

-- Thử insert lỗi xem trigeer có báo và có hủy thao tác không
insert into bookings (customer_id, room_id, check_in_date, check_out_date, total_amount)
values ('C001', 'R001', '2025-01-02', '2025-01-01', 1000);

select *
from bookings;


-- 18. (5 điểm) Hãy tạo một trigger có tên là update_room_status_on_booking
-- để tự động cập nhật trạng thái phòng thành "Booked" khi một phòng được đặt (khi có bản ghi được INSERT vào bảng Booking).
create or replace function fn_update_room_status_on_booking()
    returns trigger as
$$
begin
    -- Bình thường thì em sẽ làm chuẩn theo quy trình bên dưới nhưng vì đề không yêu cầu kiểm tra nên em vẫn sẽ làm và để phẩn này trong cmt

    -- Kiểm tra xem phòng đó có tồn tại không
    -- if not exists(select 1 from rooms where room_id = new.room_id) then
    --     raise exception 'Phòng không tồn tại';
    -- end if;

    -- Kiểm tra xem phòng đó đã được đặt (booked) chưa
    -- if (select room_status from rooms where room_id = new.room_id) = 'Booked' then
    --     raise exception 'Phòng này đã được đặt rồi, vui lòng đặt phòng khác';
    -- end if;

    -- Chuyển trạng thái phòng sau khi đặt phòng thành công
    update rooms
    set room_status = 'Booked'
    where room_id = new.room_id;

    return new;
end;
$$ language plpgsql;

-- Tạo trigger
create trigger trg_update_room_status_on_booking
    after insert
    on bookings
    for each row
execute function fn_update_room_status_on_booking();

select * from rooms;
select * from bookings;

insert into bookings (customer_id, room_id, check_in_date, check_out_date, total_amount)
values ('C001', 'R005', '2025-05-15', '2025-05-16', 1000);


-- ================= PHẦN 5: Tạo Store Procedure =================

-- 19. (5 điểm) Viết store procedure có tên add_customer để thêm mới một khách hàng với đầy đủ các thông tin cần thiết.
create or replace procedure add_customer(
    p_customer_id varchar(5),
    p_customer_full_name varchar(100),
    p_customer_email varchar(100),
    p_customer_phone varchar(15),
    p_customer_address varchar(255)
)
    language plpgsql as
$$
begin
    insert into customers (customer_id, customer_full_name, customer_email, customer_phone, customer_address)
    values (p_customer_id, p_customer_full_name, p_customer_email, p_customer_phone, p_customer_address);

    raise notice 'Thêm khách hàng thành công';
end;
$$;

-- 20. (5 điểm) Hãy tạo một Stored Procedure  có tên là add_payment để thực hiện việc thêm một thanh toán mới cho một lần đặt phòng.
create or replace procedure add_payment(
    p_booking_id int,
    p_payment_method varchar(50),
    p_payment_amount decimal(10, 2),
    p_payment_date date
)
    language plpgsql as
$$
begin
    insert into payments (booking_id, payment_method, payment_date, payment_amount)
    values (p_booking_id, p_payment_method, p_payment_date, p_payment_amount);
end;
$$;