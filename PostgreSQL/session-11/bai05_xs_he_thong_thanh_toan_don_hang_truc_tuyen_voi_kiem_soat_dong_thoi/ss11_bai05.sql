create database ss11_bai05;

create table customers
(
    customer_id serial primary key,
    name        varchar(100),
    balance     numeric(12, 2)
);

create table products
(
    product_id serial primary key,
    name       varchar(100),
    stock      int,
    price      numeric(10, 2)
);

create table orders
(
    order_id     serial primary key,
    customer_id  int references customers (customer_id),
    total_amount numeric(12, 2),
    created_at   timestamp   default now(),
    status       varchar(20) default 'PENDING'
);

create table order_items
(
    item_id    serial primary key,
    order_id   int references orders (order_id),
    product_id int references products (product_id),
    quantity  int,
    subtotal   numeric(10, 2)
);


/*
    1. Viết Transaction hoàn chỉnh thực hiện toàn bộ quy trình trên với khách hàng "Tran Thi B":
        a. Mua 2 sản phẩm:
            product_id = 1, quantity = 1
            product_id = 3, quantity = 2
        b. Nếu trong lúc tạo đơn hàng có lỗi gì xảy ra thì rollback để hủy lệnh tạo mới đơn hàng .
        c. Nếu toàn bộ đơn hàng thành công, cập nhật status = 'COMPLETED' và commit
*/
create or replace procedure create_order (
    p_customer_id int,
    p_product_items jsonb
)
    language plpgsql as
$$
    declare
        v_order_id int;
        v_product_name varchar(100);
        v_total_amount numeric(12, 2) := 0;
        v_item record;
        v_product_price numeric(10, 2);
        v_subtotal numeric(10, 2);
    begin
        begin
            -- Kiểm tra customer có tồn tại không
            if not exists (select 1 from customers where customer_id = p_customer_id) then
                raise exception 'Khách hàng không tồn tại';
            end if;

            -- Kiểm tra hóa đơn (tất cả các đơn hàng)
            for v_item in select * from jsonb_to_recordset(p_product_items) as product_items(product_id int, quantity int)
            loop
                -- Kiểm tra sản phẩm có tồn tại không
                select price into v_product_price
                from products
                where product_id = v_item.product_id
                for update;

                if not found then
                    raise exception 'Sản phẩm không tồn tại';
                end if;

                -- Kiểm tra stock
                select name into v_product_name from products where product_id = v_item.product_id;

                if (select stock from products where product_id = v_item.product_id) < v_item.quantity then
                    raise exception 'Số hàng trong kho của sản phẩm % không đủ', v_product_name;
                end if;

                v_subtotal := v_product_price * v_item.quantity;    -- tổng giá trị 1 đơn hàng đơn hàng = số lượng * đơn giá
                v_total_amount := v_total_amount + v_subtotal;       -- tổng giá trị của toàn bộ đơn hàng
            end loop;

            -- Tạo đơn hàng mới trong orders
            insert into orders (customer_id, total_amount, created_at, status)
            values (p_customer_id, v_total_amount, now(), 'PENDING')
            returning order_id into v_order_id;     -- dòng này để cho lát nữa insert vào order_items đúng order

            -- Giảm tồn kho sản phẩm và thêm dòng chi tiết vào order_items
            for v_item in select * from jsonb_to_recordset(p_product_items) as product_items(product_id int, quantity int)
            loop
                -- Giảm tồn kho sản phẩm
                update products
                set stock = stock - v_item.quantity
                where product_id = v_item.product_id;

                -- thêm dòng chi tiết vào order_items
                select price into v_product_price from products where product_id = v_item.product_id;

                insert into order_items (order_id, product_id, quantity, subtotal)
                values (v_order_id, v_item.product_id, v_item.quantity, v_product_price * v_item.quantity);
            end loop;

            -- Kiểm tra số dư sau khi đã biết số tiền tổng toàn bộ hóa đơn
            if (select balance from customers where customer_id = p_customer_id) < v_total_amount then
                raise exception 'Số dư trong tài khoản của quý khách không đủ';
            end if;

            -- Trừ tiền khách hàng
            update customers
            set balance = balance - v_total_amount
            where customer_id = p_customer_id;

            -- Nếu toàn bộ đơn hàng thành công, cập nhật status = 'COMPLETED' và commit
            update orders
            set status = 'COMPLETED'
            where order_id = v_order_id;

            raise notice 'Đơn hàng đã được đặt thành công';

        -- Nếu có bất kỳ lỗi nào → rollback.
        exception
            when others then
                rollback;
                raise;
        end;
    end;
$$;

-- Chuẩn bị data
insert into customers (customer_id, name, balance)
values (1, 'Tran Thi B', 5000000);

insert into products (product_id, name, stock, price)
values (1, 'Laptop Dell XPS', 10, 15000000),
       (2, 'Chuột không dây Logitech', 50, 500000),
       (3, 'Bàn phím cơ Keychron', 20, 2500000);

select * from customers;
select * from products;
select * from orders;
select * from order_items;

update customers
set balance = 50000000
where customer_id = 1;

delete
from orders;

delete
from order_items;

-- Thực hiện mua 2 sản phẩm
call create_order(1, '[{"product_id": 1, "quantity": 1}, {"product_id": 3, "quantity": 2}]');

call create_order(1, '[{"product_id": 2, "quantity": 50}]');

call create_order(1, '[{"product_id": 1, "quantity": 1}, {"product_id": 3, "quantity": 1}]');