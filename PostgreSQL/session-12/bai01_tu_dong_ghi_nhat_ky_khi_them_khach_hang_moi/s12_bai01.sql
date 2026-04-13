create database s12_bai01;

create table customers
(
    customer_id serial primary key,
    name        varchar(50),
    email       varchar(50)
);

create table customer_log
(
    log_id        serial primary key,
    customer_name varchar(50),
    action_time   timestamp
);

-- Tạo TRIGGER để tự động ghi log khi INSERT vào customers
create or replace function log_customer_insert()
    returns trigger as
$$
begin
    insert into customer_log (customer_name, action_time)
    values (NEW.name, current_timestamp);
    return new;
end;
$$ language plpgsql;

create trigger after_customer_insert
    after insert
    on customers
    for each row
execute function log_customer_insert();

-- Thêm vài bản ghi vào customers và kiểm tra customer_log
insert into customers (name, email)
values ('Nguyen van a', 'a@gmail.com');

select * from customers;
select * from customer_log;