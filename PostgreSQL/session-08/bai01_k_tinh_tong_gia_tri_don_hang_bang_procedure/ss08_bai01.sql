create database ss08_bai01;

CREATE TABLE order_detail
(
    id           SERIAL PRIMARY KEY,
    order_id     INT,
    product_name VARCHAR(100),
    quantity     INT,
    unit_price   NUMERIC

);

-- 1 + 2. Viết một Stored Procedure có tên calculate_order_total(order_id_input INT, OUT total NUMERIC) + Viết câu lệnh tính tổng tiền theo order_id
create or replace procedure calculate_order_total(
    in order_id_input INT,
    OUT total NUMERIC
)
    language plpgsql
as
$$
begin
    select sum(quantity * unit_price)
    into total
    from order_detail
    where order_id = order_id_input;
end;
$$;

-- 3. Gọi Procedure để kiểm tra hoạt động với một order_id cụ thể
call calculate_order_total(1);