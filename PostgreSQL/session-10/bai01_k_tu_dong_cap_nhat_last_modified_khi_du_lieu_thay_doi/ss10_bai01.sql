create database ss10_bai01;

create table products
(
    id            serial primary key,
    name          varchar,
    price         decimal,
    last_modified date
);

-- 1. tao function update_last_modified
create or replace function update_last_modified()
    returns trigger as
$$
begin
    new.last_modified = current_date;
    return new;
end;
$$ language plpgsql;

-- 2. tao trigger truoc khi update
create trigger trg_update_last_modified
    before update
    on products
    for each row
execute function update_last_modified();

-- 3. thuc hanh

-- chen du lieu mau
insert into products (name, price, last_modified)
values ('san pham a', 100000, '2024-01-01');

insert into products (name, price, last_modified)
values ('san pham b', 200000, '2024-01-01');

insert into products (name, price, last_modified)
values ('san pham c', 300000, '2024-01-01');

-- kiem tra du lieu truoc khi update
select *
from products;

-- thu update gia san pham
update products
set price = 150000
where name = 'san pham a';

-- kiem tra lai xem last_modified da duoc cap nhat chua
select *
from products
where name = 'san pham a';

-- thu update them san pham khac
update products
set price = 250000
where id = 2;
