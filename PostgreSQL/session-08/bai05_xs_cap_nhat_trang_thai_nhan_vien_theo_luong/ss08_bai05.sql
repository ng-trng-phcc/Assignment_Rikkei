create database ss08_bai05;

CREATE TABLE employees
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary     NUMERIC(10, 2),
    bonus      NUMERIC(10, 2) DEFAULT 0
);

INSERT INTO employees (name, department, salary)
VALUES ('Nguyen Van A', 'HR', 4000),
       ('Tran Thi B', 'IT', 6000),
       ('Le Van C', 'Finance', 10500),
       ('Pham Thi D', 'IT', 8000),
       ('Do Van E', 'HR', 12000);

-- Đề cho cấu trúc bảng thiếu status + sau khi trao đổi với trợ giảng thì em tự thêm cho đúng yêu cầu bài
alter TABLE employees
    add column status text;

-- Tạo procedure
create or replace procedure update_employee_status(
    in p_emp_id int,
    out p_status text
)
    language plpgsql
as
$$
declare
    v_status text;
    v_sal    numeric;
begin
    -- Lấy input
    select salary into v_sal from employees e2 where e2.id = p_emp_id;

    -- Khối bắt Exception
    if not FOUND then
        raise exception 'Employee not found';
    end if;

    -- Khối xét status
    if v_sal < 5000 then
        v_status := 'Junior';
    elseif v_sal < 10000 then
        v_status := 'Mid-level';
    else
        v_status := 'Senior';
    end if;

    update employees
    set status = v_status
    where id = p_emp_id
    returning employees.status into p_status;
end;
$$;

do
$$
    declare
        v_status text;
    begin
        call update_employee_status(9, v_status);
        raise notice 'Status của nhân viên này là: %', v_status;
    end;
$$;

select *
from employees;