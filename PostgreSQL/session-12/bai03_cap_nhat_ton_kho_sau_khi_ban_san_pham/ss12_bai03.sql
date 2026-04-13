create database ss12_bai03;

-- Dùng bảng products và sales từ bài tập 2
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

-- Viết TRIGGER AFTER INSERT để giảm số lượng stock trong products
create or replace function fn_update_stock_after_insert()
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
    end if;

    update products
    set stock = stock - new.quantity
    where product_id = new.product_id;

    return new;
end;
$$ language plpgsql;

-- Tạo trigger
create trigger trg_update_stock_after_insert
    before insert       -- Nếu làm đúng 100% yêu cầu thì chỗ này nên là after insert nhưng vì trong function em cũng có viết cả check stock nên em để là before insert
    on sales
    for each row
execute function fn_update_stock_after_insert();

select * from products;
select * from sales;

insert into products (name, stock)
values ('Laptop', 50);

insert into sales (product_id, quantity)
values (1, 10);