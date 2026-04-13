create database ss12_bai06;

create table accounts
(
    account_id   serial primary key,
    account_name varchar(50),
    balance      numeric
);

-- Thêm 2 bản ghi vào accounts với số dư ban đầu
insert into accounts (account_name, balance)
values ('Nguyen van a', 1000),
       ('Nguyen van b', 2000);

/*
    Viết một transaction:

        Kiểm tra số dư tài khoản gửi
        Nếu đủ tiền, trừ số tiền từ tài khoản gửi, cộng vào tài khoản nhận và COMMIT
        Nếu không đủ tiền, ROLLBACK
*/
create or replace procedure remittance(
    p_send_account_id int,
    p_receive_account_id int,
    p_amount numeric
)
    language plpgsql as
$$
    begin
        -- Kiểm tra xem tài khoản gửi có tồn tại không (đề không yêu cầu)
        if not exists(select 1 from accounts where account_id = p_send_account_id) then
            raise exception 'Tài khoản gửi không hợp lệ';
        end if;

        -- Kiểm tra xem tài khoản nhận có tồn tại không (đề không yêu cầu)
        if not exists(select 1 from accounts where account_id = p_receive_account_id) then
            raise exception 'Tài khoản nhận không hợp lệ';
        end if;

        -- Kiểm tra xem tài khoản gửi có đủ tiền để chuyển hay không
        if (select balance from accounts where account_id = p_send_account_id) < p_amount then
            raise exception 'Số dư tài khoản không đủ tiền để chuyển tiền';
        end if;

        -- Thực hiện trừ tiền tài khoản gửi khi đã đủ tiền
        update accounts
        set balance = balance - p_amount
        where account_id = p_send_account_id;

        -- Thực hiêện cộng tiền tài khoản nhận
        update accounts
        set balance = balance + p_amount
        where account_id = p_receive_account_id;

    -- Nếu có lỗi thì rollback
    exception
        when others then rollback;
        raise;
    end;
$$;

-- test
call remittance(2, 1, 300);

select * from accounts;