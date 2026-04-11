create database ss11_bai06;

CREATE TABLE accounts
(
    account_id SERIAL PRIMARY KEY,
    owner_name VARCHAR(100),
    balance    NUMERIC(12, 2),
    status     VARCHAR(10) DEFAULT 'ACTIVE'

);

CREATE TABLE transactions
(
    trans_id     SERIAL PRIMARY KEY,
    from_account INT REFERENCES accounts (account_id),
    to_account   INT REFERENCES accounts (account_id),
    amount       NUMERIC(12, 2),
    status       VARCHAR(20) DEFAULT 'PENDING',
    created_at   TIMESTAMP   DEFAULT NOW()
);

create or replace procedure fund_sending(
    p_from_account int,
    p_to_account int,
    p_amount numeric(12, 2)
)
    language plpgsql as
$$
declare
    ktra_account int;
begin
    begin
        -- Kiểm tra tài khoản gửi và tài khoản đích
        select count(account_id)
        into ktra_account
        from accounts
        where (account_id = p_to_account or account_id = p_from_account)
          and status like 'ACTIVE';

        if ktra_account < 2 then
            raise exception 'Tài khoản không hợp lệ';
        end if;

        -- Kiểm tra xem có đủ số dư không
        if (select balance from accounts where account_id = p_from_account) < p_amount then
            raise exception 'Tài khoản không đủ số dư';
        end if;

        -- Giảm balance tài khoản gửi
        update accounts set balance = balance - p_amount where account_id = p_from_account;

        -- Tăng balance tài khoản nhận
        update accounts set balance = balance + p_amount where account_id = p_to_account;

        -- Ghi log giao dịch vào bảng transactions
        insert into transactions (from_account, to_account, amount, status, created_at)
        values (p_from_account, p_to_account, p_amount, 'COMPLETED', now());

    exception
        when others then
            rollback;
            raise;
    end;
end;
$$