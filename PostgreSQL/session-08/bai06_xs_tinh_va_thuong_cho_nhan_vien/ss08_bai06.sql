create database ss08_bai06;

-- Sử dụng lại cấu trúc của bài trước (Bài 5 - [ Xuất sắc ] Cập nhật trạng thái nhân viên theo lương)
CREATE TABLE employees
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(100) NOT NULL,
    department VARCHAR(50),
    salary     NUMERIC(10, 2),
    bonus      NUMERIC(10, 2) DEFAULT 0,
    status     TEXT
);

INSERT INTO employees (name, department, salary)
VALUES ('Nguyen Van A', 'HR', 4000),
       ('Tran Thi B', 'IT', 6000),
       ('Le Van C', 'Finance', 10500),
       ('Pham Thi D', 'IT', 8000),
       ('Do Van E', 'HR', 12000);

-- Tạo procedure
create or replace procedure calculate_bonus(
    p_emp_id INT,
    p_percent NUMERIC,
    out p_bonus NUMERIC
)
    language plpgsql
as
$$
declare
    v_sal numeric(10, 2);
begin
    select salary into v_sal from employees e where e.id = p_emp_id;
    -- Nếu nhân viên không tồn tại → ném lỗi "Employee not found"
    if not FOUND then
        raise exception 'Employee not found';
    end if;

    -- Khối tính p_bonus
    if p_percent <= 0 then
        p_bonus := 0;
    else
        p_bonus := v_sal * p_percent / 100;
    end if;

    update employees set bonus = p_bonus where id = p_emp_id;
end;
$$;

do
$$
    declare
        v_bonus numeric;
    begin
        call calculate_bonus(1, 15, v_bonus);
        raise notice 'Bonus của nhân viên này là: %', v_bonus;
    end;
$$;

select *
from employees;