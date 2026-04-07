create database ss10_bai06;

create table products
(
    id    serial primary key,
    name  varchar,
    stock int
);

create table orders
(
    id           serial primary key,
    product_id   int,
    quantity     int,
    order_status varchar
);

-- 1. Khi tạo đơn hàng mới: giảm tồn kho theo số lượng
create or replace function fn_ins_stock_by_quanitty()
    returns trigger as
$$
declare
    v_ck_stock int;
begin
    select stock
    into v_ck_stock
    from products
    where id = New.product_id;

    if v_ck_stock < new.quantity then
        raise exception 'Kho không đủ hàng';
    end if;

    update products
    set stock = stock - new.quantity
    where id = new.product_id;
end;
$$ language plpgsql;

-- 1.1 tạo trigger
create or replace trigger trg_ins_stock_by_quantity
    before insert
    on orders
    for each row
execute function fn_ins_stock_by_quanitty();

-- 2. Khi chỉnh sửa đơn hàng: điều chỉnh tồn kho theo sự thay đổi số lượng
create or replace function fn_adj_stock_by_quantity_before_upd()
    returns trigger as
$$
begin
    if (select stock from products where id = new.product_id) + old.quantity < new.quantity then
        raise exception 'Kho không đủ hàng';
    end if;

    update products
    set stock = stock + old.quantity - new.quantity
    where id = new.product_id;

    return new;
end;
$$ language plpgsql;

-- 2.2 Tạo trigger
create or replace trigger trg_adj_stock_by_quantity_before_upd
    before update
    on orders
    for each row
execute function fn_adj_stock_by_quantity_before_upd();

-- 3. Khi hủy/xóa đơn hàng: trả lại tồn kho tương ứng
create or replace function fn_cancel_order_restore_stock()
    returns trigger as
$$
begin
    if new.order_status = 'cancelled' and new.order_status is distinct from 'cancelled' then
        update products
        set stock = stock + old.quantity
        where id = new.product_id;
    end if;
    return new;
end;
$$ language plpgsql;

-- 3.2 Tạo trigger
create or replace trigger trgg_adj_stock_by_qty_before_del
    before update on orders
    for each row
    execute function fn_cancel_order_restore_stock();