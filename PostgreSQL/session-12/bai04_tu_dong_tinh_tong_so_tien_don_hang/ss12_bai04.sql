create database ss12_bai04;

create table products
(
    product_id serial primary key,
    name       varchar(50),
    price      numeric(10, 2),
    stock      int
);

create table orders
(
    order_id     serial primary key,
    product_id   int references products (product_id),
    quantity     int,
    total_amount numeric
);

-- Viết TRIGGER BEFORE INSERT để tự động tính total_amount
create or replace function fn_calculate_total_amount_before_insert()
    returns trigger as
$$
    declare
        v_price numeric(10, 2);
begin

    -- Lấy price
    select price into v_price
    from products p
    where p.product_id = new.product_id;

    update orders
    set total_amount = new.quantity * v_price
    where product_id = new.product_id;

    return new;
end;
$$ language plpgsql;

-- tạo trigger
create trigger trg_calculate_total_amount_before_insert
    after insert
    on orders
    for each row
execute function fn_calculate_total_amount_before_insert();

select * from products;
select * from orders;

insert into products (name, price, stock)
values ('laptop', 1000, 50);

insert into orders (product_id, quantity)
values (1, 2);