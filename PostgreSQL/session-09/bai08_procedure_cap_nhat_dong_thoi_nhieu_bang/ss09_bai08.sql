create database ss09_bai08;

create table orders (
    order_id serial primary key ,
    customer_id int,
    total_amount numeric(10,2)
);

create table customers (
    customer_id serial primary key ,
    name varchar(50),
    total_spend numeric(10,2)
);

/*
    1. Tạo Procedure add_order_and_update_customer(p_customer_id INT, p_amount NUMERIC) để:
        a. Thêm đơn hàng mới vào bảng Orders
        b. Cập nhật total_spent trong bảng Customers
    2. Sử dụng biến và xử lý điều kiện để đảm bảo khách hàng tồn tại
    3. Sử dụng EXCEPTION để báo lỗi nếu thêm đơn hàng thất bại
*/
create or replace procedure add_order_and_update_customer(
    p_customer_id int,
    p_amount numeric
)
    language plpgsql
as
$$
declare
    v_customer_exists int;
begin
    -- Kiểm tra khách hàng tồn tại
    select customer_id into v_customer_exists
    from customers
    where customer_id = p_customer_id;

    if not found then
        raise exception 'Không tìm thấy khách hàng với customer_id = %', p_customer_id;
    end if;

    -- Thêm đơn hàng
        insert into orders (customer_id, total_amount)
        values (p_customer_id, p_amount);

    -- Cập nhật total_spend
    update customers
    set total_spend = coalesce(total_spend, 0) + p_amount
    where customer_id = p_customer_id;
end;
$$;

-- 4. Gọi hàm
call add_order_and_update_customer(1, 15);