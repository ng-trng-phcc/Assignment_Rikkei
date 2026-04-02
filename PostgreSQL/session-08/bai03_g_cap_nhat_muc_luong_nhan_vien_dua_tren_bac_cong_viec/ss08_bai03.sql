create database ss08_bai03;

CREATE TABLE employees
(
    emp_id    SERIAL PRIMARY KEY,
    emp_name  VARCHAR(100),
    job_level INT,
    salary    NUMERIC

);

/*
    1. Tạo Procedure adjust_salary(p_emp_id INT, OUT p_new_salary NUMERIC) để:

    a. Nhận emp_id của nhân viên
    b. Cập nhật lương theo quy tắc trên
    c. Trả về p_new_salary (lương mới) sau khi cập nhật
*/
create or replace procedure adjust_salary(
    in p_emp_id INT,
    OUT p_new_salary NUMERIC
)
    language plpgsql
as
$$
declare
    v_sal numeric;
    v_lv  int;
begin
    select salary into v_sal from employees e where e.emp_id = p_emp_id;
    select job_level into v_lv from employees e2 where e2.emp_id = p_emp_id;

    if v_lv = 1 then
        v_sal := v_sal * 1.05;
    elseif v_lv = 2 then
        v_sal := v_sal * 1.1;
    elseif v_lv = 3 then
        v_sal := v_sal * 1.15;
    else
        v_sal := v_sal;
    end if;

    update employees
    set salary = v_sal
    where emp_id = p_emp_id
    returning salary into p_new_salary;


end;
$$;

do
$$
    declare
        v_new_sal numeric;
    begin
        call adjust_salary(1, v_new_sal);
        raise notice 'Lương mới: %', v_new_sal;
    end;
$$;
