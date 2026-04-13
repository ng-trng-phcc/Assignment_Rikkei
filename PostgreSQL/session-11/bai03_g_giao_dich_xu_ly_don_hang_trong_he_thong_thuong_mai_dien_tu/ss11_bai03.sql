create database ss11_bai03;

create table products
(
    product_id   serial primary key,
    product_name varchar(100),
    stock        int,
    price        numeric(10, 2)
);

create table orders
(
    order_id      serial primary key,
    customer_name varchar(100),
    total_amount  numeric(10, 2),
    created_at    timestamp default now()
);

create table order_items
(
    order_item_id serial primary key,
    order_id      int references orders (order_id),
    product_id    int references products (product_id),
    quantity      int,
    subtotal      numeric(10, 2)
);

/*
    Yêu cầu:

        Viết Transaction thực hiện toàn bộ quy trình đặt hàng cho khách "Nguyen Van A" gồm:
        Mua 2 sản phẩm:
        product_id = 1, quantity = 2
        product_id = 2, quantity = 1
        Nếu một trong hai sản phẩm không đủ hàng, toàn bộ giao dịch phải bị ROLLBACK
        Nếu thành công, COMMIT và cập nhật chính xác số lượng tồn kho
*/

create or replace procedure create_order(
    p_customer_name varchar(100),
    p_items jsonb
)
    language plpgsql as
$$
    declare
        v_item record;
        v_order_id int;
        v_product_name varchar(100);
        v_product_price numeric(10, 2);
        v_total_amount numeric(10, 2) := 0;
        v_subtotal numeric(10, 2) := 0;
    begin
        begin
            -- Kiểm tra tồn kho cho từng sản phẩm
            for v_item in select * from jsonb_to_recordset(p_items) as product_items(product_id int, quantity int)
            loop
                    -- Kiểm tra xem sản phẩm có tồn tại không
                    select price into v_product_price
                    from products
                    where product_id = v_item.product_id;

                    if not found then
                        raise exception 'Sản phẩm không tồn tại';
                    end if;

                    -- Kiểm tra stock có đủ không
                    select product_name into v_product_name from products where product_id = v_item.product_id;

                    if (select stock from products where product_id = v_item.product_id) < v_item.quantity then
                        raise exception 'Hàng trong kho không đủ cho sản phẩm: %', v_product_name;
                    end if;

                    v_subtotal := v_product_price * v_item.quantity;                 -- Tính tổng từng đơn hàng
                    v_total_amount := v_total_amount + v_subtotal;                   -- Tính tổng tiền toàn bộ đơn hàng
            end loop;

            -- Tạo bản ghi trong orders
            insert into orders (customer_name, total_amount, created_at)
            values (p_customer_name, v_total_amount, now())
            returning order_id into v_order_id;     -- dòng này giành cho insert order items

            -- Giảm số lượng tồn kho tương ứng
            for v_item in select * from jsonb_to_recordset(p_items) as product_items(product_id int, quantity int)
                loop

                    -- Giảm số lượng trong products
                    update products
                    set stock = stock - v_item.quantity
                    where product_id = v_item.product_id;

                    -- Thêm chi tiết sản phẩm vào order_items
                    select price into v_product_price from products where product_id = v_item.product_id;

                    insert into order_items (order_id, product_id, quantity, subtotal)
                    values (v_order_id, v_item.product_id, v_item.quantity, v_product_price * v_item.quantity);
                end loop;

        -- Nếu một trong hai sản phẩm không đủ hàng, toàn bộ giao dịch phải bị ROLLBACK
        exception
            when others then
                rollback;
                raise;
        end;
    end;
$$;

insert into products (product_name, stock, price)
values ('Iphone 15 promax', 100, 1000),
       ('Dell Precision', 50, 880);

call create_order('Nguyễn Văn A', '[{"product_id": 1, "quantity": 2}, {"product_id": 2, "quantity": 1}]');

select * from orders;
select * from order_items;

delete
from order_items;

delete
from orders;