create database ss12_bai02;

create table products
(
    product_id serial primary key,
    name       varchar(50),
    stock      int
);

create table sales
(
    sale_id    serial primary key,
    product_id int references products (product_id),
    quantity   int
);

-- Viết TRIGGER BEFORE INSERT để kiểm tra tồn kho
create or replace function fn_check_stock_before_insert()
    returns trigger as
$$
declare
    v_current_stock int;
begin
    -- Kiểm tra stock
    select stock
    into v_current_stock
    from products
    where product_id = new.product_id;

    if v_current_stock < new.quantity then
        raise exception 'Số hàng trong kho không đủ';
    else
        raise notice 'Đủ hàng!';
    end if;

    return new;
end;
$$ language plpgsql;

-- Tạo trigger
create trigger trg_check_stock_before_insert
    before insert
    on sales
    for each row
execute function fn_check_stock_before_insert();

select * from products;
select * from sales;

insert into products (name, stock)
values ('Laptop', 50);

insert into sales (product_id, quantity)
values (1, 10);