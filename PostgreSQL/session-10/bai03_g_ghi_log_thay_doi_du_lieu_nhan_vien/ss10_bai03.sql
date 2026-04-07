create database ss10_bai03;

create table employees
(
    id       serial primary key,
    name     varchar,
    position varchar,
    salary   numeric(10, 2)
);

create table employees_log
(
    employee_id int,
    operation   varchar check ( operation in ('INSERT', 'UPDATE', 'DELETE') ),
    old_data    jsonb,
    new_data    jsonb,
    change_time date
);

-- Tạo hàm khi INSERT employees
create or replace function employees_log_insert()
    returns trigger as
$$
begin
    insert into employees_log (employee_id, operation, old_data, new_data, change_time)
    values (new.id, 'INSERT', null, to_json(new), now());
    return new;
end;
$$ language plpgsql;

-- Tạo trigger cho INSERT
create or replace trigger trg_employees_log_insert
    after insert
    on employees
    for each row
execute function employees_log_insert();



-- Tạo hàm khi UPDATE employees
create or replace function employees_log_update()
    returns trigger as
$$
begin
    insert into employees_log (employee_id, operation, old_data, new_data, change_time)
    values (new.id, 'UPDATE', to_json(old), to_json(new), now());
    return new;
end;
$$ language plpgsql;

-- Tạo trigger cho UPDATE
create or replace trigger trg_employees_log_update
    after insert
    on employees
    for each row
execute function employees_log_update();



-- Tạo hàm khi DELETE employees
create or replace function employees_log_delete()
    returns trigger as
$$
begin
    insert into employees_log (employee_id, operation, old_data, new_data, change_time)
    values (new.id, 'DELETE', to_json(old), null, now());
    return new;
end;
$$ language plpgsql;

-- Tạo trigger cho DELETE
create or replace trigger trg_employees_log_delete
    after insert
    on employees
    for each row
execute function employees_log_delete();