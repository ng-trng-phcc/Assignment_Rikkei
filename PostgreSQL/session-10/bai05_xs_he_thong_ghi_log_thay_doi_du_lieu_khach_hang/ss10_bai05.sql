create database ss10_bai05;

create table customers
(
    id      serial primary key,
    name    varchar,
    email   varchar,
    phone   varchar,
    address varchar
);

create table customers_log
(
    customer_id int,
    operation   varchar check ( operation in ('INSERT', 'UPDATE', 'DELETE') ),
    old_data    jsonb,
    new_data    jsonb,
    changed_by  varchar,
    change_time date
);

-- Tạo hàm khi INSERT customer
create or replace function customers_log_insert()
    returns trigger as
$$
begin
    insert into customers_log (customer_id, operation, old_data, new_data, changed_by, change_time)
    values (new.id, 'INSERT', null, to_json(new), current_user, now());
    return new;
end;
$$ language plpgsql;

-- Tạo trigger cho INSERT
create or replace trigger trg_customer_log_insert
    after insert
    on customers
    for each row
execute function customers_log_insert();



-- Tạo hàm khi UPDATE
create or replace function customers_log_update()
    returns trigger as
$$
begin
    insert into customers_log (customer_id, operation, old_data, new_data, changed_by, change_time)
    values (new.id, 'UPDATE', to_json(old), to_json(new), current_user, now());
    return new;
end;
$$ language plpgsql;

-- Tạo trigger cho UPDATE
create or replace trigger trg_customer_log_update
    after insert
    on customers
    for each row
execute function customers_log_update();



-- Tạo hàm khi DELETE
create or replace function customers_log_delete()
    returns trigger as
$$
begin
    insert into customers_log (customer_id, operation, old_data, new_data, changed_by, change_time)
    values (new.id, 'DELETE', to_json(old), null, current_user, now());
    return new;
end;
$$ language plpgsql;

-- Tạo trigger cho DELETE
create or replace trigger trg_customer_log_delete
    after insert
    on customers
    for each row
execute function customers_log_delete();