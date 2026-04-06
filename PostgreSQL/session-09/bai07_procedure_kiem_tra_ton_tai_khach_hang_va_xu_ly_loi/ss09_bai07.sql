create database ss09_bai07;

create table customers
(
    customer_id serial primary key,
    name        varchar(50),
    email       varchar(50)
);

create table orders
(
    order_id    serial primary key,
    customer_id int,
    amount      int,
    order_date  date
);

-- 1. Tạo Procedure add_order(p_customer_id INT, p_amount NUMERIC) để thêm đơn hàng
create or replace procedure add_order(
    p_customer_id int,
    p_amount numeric
)
    language plpgsql
as
$$
begin
    if not exists(select 1 from customers where customer_id = p_customer_id) then
        raise exception 'Không tìm thấy khách hàng với customer_id: %', p_customer_id;
    end if;

    insert into orders (customer_id, amount, order_date)
    values (add_order.p_customer_id, p_amount, now());

    raise notice 'Thêm đơn hàng thành công';
end;
$$;

