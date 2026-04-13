create database ss12_bai05;

create table employees
(
    emp_id   serial primary key,
    name     varchar(50),
    position varchar(50)
);

create table employee_log
(
    log_id      serial primary key,
    emp_name    varchar(50),
    action_time timestamp
);

-- Viết TRIGGER AFTER UPDATE để ghi log khi thông tin nhân viên thay đổi
create or replace function fn_insert_employee_log_after_update()
    returns trigger as
$$
begin
    insert into employee_log (emp_name, action_time)
    values (new.name, current_timestamp);

    return new;
end;
$$ language plpgsql;

-- Tạo trigger
create trigger trg_insert_employee_log_after_update
    after update
    on employees
    for each row
execute function fn_insert_employee_log_after_update();

select * from employees;
select * from employee_log;

insert into employees (name, position)
values ('Nguyen van a', 'staff');

update employees
set position = 'leader'
where emp_id = 1;