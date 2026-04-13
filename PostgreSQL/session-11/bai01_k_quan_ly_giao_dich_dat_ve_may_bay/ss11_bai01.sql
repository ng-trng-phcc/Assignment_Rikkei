create database ss11_bai01;

create table flights
(
    flight_id      serial primary key,
    flight_name    varchar(100),
    available_seat int
);

create table bookings
(
    booking_id    serial primary key,
    flight_id     int references flights (flight_id),
    customer_name varchar(100)
);

insert into flights (flight_name, available_seat)
values ('VN123', 3),
       ('VN456', 2);

/*
    Yêu cầu:

        Tạo Transaction đặt vé thành công
        Bắt đầu transaction bằng BEGIN;
        Giảm số ghế của chuyến bay 'VN123' đi 1
        Thêm bản ghi đặt vé của khách hàng 'Nguyen Van A'
        Kết thúc bằng COMMIT;
        Kiểm tra lại dữ liệu bảng flights và bookings
*/
create or replace procedure booking(
    p_flight_id int,
    p_seat_numbers int
)
    language plpgsql as
$$
    begin
        -- Kiểm tra xem chuyến bay có tồn tại hay không
        if not exists(select 1 from flights where flight_id = p_flight_id) then
            raise exception 'Chuyến bay này không tồn tại';
        end if;

        -- Kiểm tra xem số lượng chỗ ngồi có vượt quá số lượng chỗ nồi khả dụng hay không
        if (select available_seat from flights where flight_id = p_flight_id) < p_seat_numbers then
            raise exception 'Số lượng chỗ ngồi còn lại không đủ';
        end if;

        -- Giảm chỗ ngồi của chuyến bay đi
        update flights
        set available_seat = available_seat - p_seat_numbers
        where flight_id = p_flight_id;

        -- Thêm bản ghi đặt vé vào bookings của khách hàng 'Nguyen Van A'
        insert into bookings (flight_id, customer_name)
        values (p_flight_id, 'Nguyễn Văn A');
    end;
$$;

select *
from flights;

select *
from bookings;

call booking(1, 1);