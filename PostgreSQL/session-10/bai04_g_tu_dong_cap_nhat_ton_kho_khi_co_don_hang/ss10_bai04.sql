create database ss10_bai04;

create table products
(
    id    serial primary key,
    name  varchar,
    stock int
);

create table orders
(
    id         serial primary key,
    product_id int,
    quantity   int
);

-- 1. hàm thay đổi stock khi insert
create or replace function update_stock_on_insert()
    returns trigger as
$$
begin
    update products
    set stock = stock - new.quantity
    where id = new.product_id;
    return new;
end;
$$ language plpgsql;

-- 1.2 Tạo trigger thay đổi stock sau khi insert
create trigger trigger_update_stock_insert
    after insert
    on orders
    for each row
execute function update_stock_on_insert();



-- 2. Tạo hàm xử lý stock khi update
create or replace function update_stock_on_update()
    returns trigger as
$$
begin
    update products
    set stock = stock + old.quantity - new.quantity
    where id = new.product_id;
    return new;
end;
$$ language plpgsql;

-- 2.2 Tạo trigger xử lý stock sau khi update
create trigger trigger_update_stock_update
    after update
    on orders
    for each row
execute function update_stock_on_update();



-- 3. Tạo hàm xử lý stock khi delete
create or replace function update_stock_on_delete()
    returns trigger as
$$
begin
    update products
    set stock = stock + old.quantity
    where id = old.product_id;
    return old;
end;
$$ language plpgsql;

-- 3.2 Tạo trigger xử lý stock sau khi delete
create trigger trigger_update_stock_delete
    after delete
    on orders
    for each row
execute function update_stock_on_delete();