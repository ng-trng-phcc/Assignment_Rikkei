create database ss11_bai02;

create table account
(
    account_id serial primary key,
    owner_name varchar(100),
    balance    numeric(10, 2)
);

insert into account (owner_name, balance)
values ('A', 500.00),
       ('B', 300.00);

/*
    Giả sử cần thực hiện giao dịch chuyển 100.00 từ tài khoản A sang B.

    Giao dịch này bao gồm 2 bước:

    Giảm số dư tài khoản A đi 100.00
    Tăng số dư tài khoản B thêm 100.00
*/
create or replace procedure remittance(
    p_send_account_id int,
    p_receive_account_id int,
    p_amount numeric(10, 2)
)
    language plpgsql as
$$
    begin
        -- Kiểm tra xem 2 tài khoản có tồn tại không
        if not exists(select 1 from account where account_id = p_send_account_id) then
            raise exception 'Tài khoản người gửi không hợp lệ';
        elseif not exists(select 1 from account where account_id = p_receive_account_id) then
            raise exception 'Tài khoản người nhận không hợp lệ';
        end if;

        -- Kiểm tra số tiền chuyển có vượt quá số dư hay không
        if (select balance from account where account_id = p_send_account_id) < p_amount then
            raise exception 'Số dư không đủ để chuyển tiền';
        end if;

        -- Trừ tiền tài khoản gửi (A)
        update account
        set balance = balance - p_amount
        where account_id = p_send_account_id;

        -- Cộng tiền tài khoản nhận (B)
        update account
        set balance = balance + p_amount
        where account_id = p_receive_account_id;

    -- Nếu một trong hai thao tác thất bại (ví dụ: tài khoản B không tồn tại), toàn bộ giao dịch phải bị hủy
    exception
        when others then
            rollback;
            raise;
    end;
$$;

select * from account;

call remittance(2, 1, 100);