create database ss08_bai04;

CREATE TABLE products
(
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(100),
    price            NUMERIC,
    discount_percent INT
);

insert into products (name, price, discount_percent)
values ('laptop', 1000, 50);

create or replace procedure calculate_discount(p_id int, out p_final_price numeric)
    language plpgsql
as
$$
declare
    v_price            numeric;
    v_discount_percent int;
begin
    select price into v_price from products p where p.id = p_id;
    select discount_percent into v_discount_percent from products p2 where p2.id = p_id;

    if v_discount_percent > 50
    then
        p_final_price := v_price - (v_price * 50 / 100);
    else
        p_final_price := v_price - (v_price * v_discount_percent / 100);
    end if;

    update products set price = p_final_price where id = p_id;
end;
$$;

do
$$
    declare
        v_final_price numeric;
    begin
        call calculate_discount(1, v_final_price);
        raise notice 'Giá của sản phẩm sau khi được giảm là: %', v_final_price;
    end;
$$;

select *
from products;