create database ss10_bai02;

create table customers
(
    id           serial primary key,
    name         varchar,
    credit_limit serial
);

create table orders
(
    id           serial primary key,
    customer_id  int,
    order_amount serial
);

-- 1. tao function kiem tra han muc tin dung
create or replace function check_credit_limit()
    returns trigger as
$$
declare
    total_orders    integer;
    customer_credit integer;
begin
    -- lấy hạn mức tín dụng của khách hàng
    select credit_limit
    into customer_credit
    from customers
    where id = new.customer_id;

    -- tính tổng giá trị đơn hàng tại của đn hàng hiện tại (không bao gồm đơn hàng đang insert)
    select coalesce(sum(order_amount), 0)
    into total_orders
    from orders
    where customer_id = new.customer_id;

    -- kiểm trả có vượt hạn mức không
    if (total_orders + new.order_amount) > customer_credit then
        raise exception 'Tổng giá trị đơn hàng đã vượt quá hạn mức.',
            customer_credit, total_orders, new.order_amount;
    end if;

    return new;
end;
$$ language plpgsql;

-- 2. tao trigger truoc khi insert
create trigger trg_check_credit
    before insert
    on orders
    for each row
execute function check_credit_limit();


/*
    Thực hành:
        a. Chèn dữ liệu mẫu vào customers
        b. Thử insert các đơn hàng, bao gồm cả trường hợp vượt hạn mức
        c. Kiểm tra Trigger có ngăn chặn insert khi vượt hạn mức không
*/
insert into customers (name, credit_limit)
values ('nguyen van a', 1000);

insert into orders (customer_id, order_amount)
values (1, 500);

insert into orders (customer_id, order_amount)
values (1, 600);