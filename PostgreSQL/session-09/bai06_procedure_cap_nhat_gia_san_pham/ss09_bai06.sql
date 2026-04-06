create database ss09_bai06;

create table products
(
    product_id  serial primary key,
    name        varchar(50),
    price       numeric(10, 2),
    category_id int
);

-- 1. Tạo Procedure update_product_price(p_category_id INT, p_increase_percent NUMERIC) để tăng giá tất cả sản phẩm trong một category_id theo phần trăm
create or replace procedure update_product_price(
    p_category_id int,
    p_increase_percent numeric
)
    language plpgsql
as
$$
declare
    rec record;
begin
    for rec in
        select product_id, price
        from products
        where category_id = p_category_id
    loop
        update products
        set price = price + (price * p_increase_percent / 100)
        where product_id = rec.product_id;
    end loop;
end;
$$;

-- 2. Thử gọi Procedure với các tham số mẫu
call update_product_price(1, 25);