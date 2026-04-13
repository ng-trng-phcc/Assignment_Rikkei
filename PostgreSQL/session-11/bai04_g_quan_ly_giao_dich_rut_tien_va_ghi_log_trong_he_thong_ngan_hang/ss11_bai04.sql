create database ss11_bai04;

create table accounts
(
    account_id    serial primary key,
    customer_name varchar(100),
    balance       numeric(12, 2)
);

create table transactions
(
    trans_id   serial primary key,
    account_id int references accounts (account_id),
    amount     numeric(12, 2),
    trans_type varchar(20) check ( trans_type in ('WITHDRAW', 'DEPOSIT') ),
    created_at timestamp default now()
);

/*
    Quy trình:
        Hệ thống kiểm tra số dư tài khoản
        Nếu đủ tiền, trừ số dư
        Ghi log vào bảng transactions
        Nếu ghi log thất bại, việc trừ tiền cũng phải bị hoàn tác (rollback)
*/


/*
    Yêu cầu:
        1. Viết Transaction thực hiện rút tiền
            Bắt đầu BEGIN;
            Kiểm tra balance của tài khoản
            Nếu đủ, trừ số dư và ghi vào bảng transactions
            Nếu bất kỳ bước nào thất bại → ROLLBACK;
            Nếu thành công → COMMIT;
*/
create or replace procedure withdraw(
    p_account_id int,
    p_amount numeric(12, 2)
)
    language plpgsql as
$$
    declare
        v_balance numeric(12, 2);
    begin
        begin
            -- Kểm tra tài khoản có tồn tại không
            if not exists(select 1 from accounts where account_id = p_account_id) then
                raise exception 'Tài khoản không tồn tại';
            end if;

            -- Kiểm tra số dư có đủ không
            select balance into v_balance
            from accounts
            where account_id = p_account_id;

            if v_balance < p_amount then
                raise exception 'Số dư không đủ để rút tiền';
            end if;

            -- Thực hiện rút tiền
            update accounts
            set balance = balance - p_amount
            where account_id = p_account_id;

            -- Ghi lại vào bảng transaction
            insert into transactions (account_id, amount, trans_type, created_at)
            values (p_account_id, p_amount, 'WITHDRAW', now());

        -- Nếu bất kỳ bước nào thất bại → ROLLBACK;
        exception
            when others then
                rollback;
                raise;
        end;
    end;
$$;

insert into accounts (customer_name, balance)
values ('Nguyễn Văn A', 5000);

select * from accounts;
select * from transactions;

call withdraw(1, 40000);