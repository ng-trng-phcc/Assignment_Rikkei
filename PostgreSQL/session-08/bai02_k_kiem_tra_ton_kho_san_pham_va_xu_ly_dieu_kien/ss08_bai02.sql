create database ss08_bai02;

CREATE TABLE inventory
(
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    quantity     INT
);
insert into inventory (product_name, quantity)
values ('iphone15', 10),
       ('laptop dell', 5);
/*
    1. Viết một Procedure có tên check_stock(p_id INT, p_qty INT) để:

    a. Kiểm tra xem sản phẩm có đủ hàng không
    b. Nếu quantity < p_qty, in ra thông báo lỗi bằng RAISE EXCEPTION ‘Không đủ hàng trong kho’
*/
create OR REPLACE procedure check_stock(
    in p_id INT,
    in p_qty INT
)
    language plpgsql
as
$$
declare
    v_quantity int;
begin
    select quantity into v_quantity from inventory i where i.product_id = p_id;
    if v_quantity < p_qty then
        raise exception 'Sản phẩm không đủ hàng!!';
    else
        raise notice 'Sản phẩm đủ hàng.';
    end if;
end;
$$;

call check_stock(1, 10);
call check_stock(2, 100);