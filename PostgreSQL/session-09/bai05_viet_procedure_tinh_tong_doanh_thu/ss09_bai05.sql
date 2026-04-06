create database ss09_bai05;

create table sales
(
    sale_id     serial primary key,
    customer_id int,
    sale_date   date,
    amount      int
);

-- 1. Tạo Procedure calculate_total_sales(start_date DATE, end_date DATE, OUT total NUMERIC) để tính tổng amount trong khoảng start_date đến end_date
create or replace procedure calculate_total_sales(
    start_date date,
    end_date date,
    out total numeric
)
    language plpgsql
as
$$
begin
    select sum(amount)
    into total
    from sales
    where sale_date between start_date and end_date;
end;
$$;

-- 2. Gọi Procedure với các ngày mẫu và hiển thị kết quả
do
$$
    declare
        v_total numeric;
    begin
        call calculate_total_sales('2025-01-01', '2025-01-31', v_total);
        raise notice 'Tổng các đơn đã bán được = %', v_total;
    end;
$$;
end;