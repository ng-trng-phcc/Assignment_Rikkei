create database ss12_bai07;

create table products
(
    product_id serial primary key,
    name       varchar(50)    not null,
    price      numeric(10, 2) not null,
    stock      int            not null
);

create table orders
(
    order_id     serial primary key,
    product_id   int references products (product_id),
    quantity     int not null,
    total_amount numeric(10, 2)
);

create table order_log
(
    log_id      serial primary key,
    order_id    int,
    action_time timestamp
);

/*
    Viết transaction thực hiện:

        Thêm đơn hàng vào orders
        Giảm stock trong products
        Ghi log vào order_log
*/
create or replace procedure create_order(
    p_product_id int,
    p_quantity int
)
    language plpgsql as
$$
    declare
        v_product_price numeric(10, 2);
        v_order_id int;
    begin
        -- Kiểm tra xem sản phẩm có tồn tại không
        if not exists(select 1 from products where product_id = p_product_id) then
            raise exception 'Sản phẩm không hợp lệ';
        end if;

        -- Kiểm tra xem stock có đủ hàng không
        if (select stock from products where product_id = p_product_id) < p_quantity then
            raise exception 'Số hàng trong kho không đủ để đặt sản phẩm này';
        end if;

        -- Khi đã pass các validate trên thì mới tạo orders
        select price
        into v_product_price
        from products p
        where p.product_id = p_product_id;

        insert into orders (product_id, quantity, total_amount)
        values (p_product_id, p_quantity, v_product_price * p_quantity)
        returning order_id into v_order_id;         -- Lấy order_id để ghi log

        -- Thực hiện giảm stock trong products sau khi đảm bảo đã đủ stock
        update products
        set stock = stock - p_quantity
        where product_id = p_product_id;

        -- Ghi log vào order_log
        insert into order_log (order_id, action_time)
        values (v_order_id, current_timestamp);

    -- Nếu lỗi thì báo lỗi và rollback
    exception
        when others then
            rollback;
            raise;
    end;
$$;

select * from products;
select * from orders;
select * from order_log;

insert into products (name, price, stock)
values ('Laptop', 1200, 50),
       ('Iphone', 1000, 500),
       ('Ipad', 1100, 150),
       ('Smart watch', 200, 250),
       ('Shoes', 300, 10);

call create_order(5, 2);