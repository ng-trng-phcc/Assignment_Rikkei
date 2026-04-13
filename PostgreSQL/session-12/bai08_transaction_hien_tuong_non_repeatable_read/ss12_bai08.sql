create database ss12_bai08;

create table accounts
(
    account_id   serial primary key,
    account_name varchar(50)    not null,
    balance      numeric(12, 2) not null
);

insert into accounts (account_name, balance)
values ('nguyen van a', 1000);

begin;
select balance from accounts where account_id = 1;
-- Chờ session B update
/* Ở session B (tab console khác) em chạy lệnh này
    UPDATE accounts SET balance = 2000 WHERE account_id = 1;
    COMMIT;
*/
select balance from accounts where account_id = 1;

/*
    Session B: UPDATE balance cùng account và COMMIT
        Thử với isolation levels khác nhau: READ COMMITTED, REPEATABLE READ
        Ghi nhận kết quả và nêu cách tránh Non-Repeatable Read
*/

/*
    1. Sau khi chạy đúng quy trình thì:
        a. Đối với Isolation READ COMMITTED (xảy ra Non-Repeatable Read):
            + Lần 1 đọc được 1000
            + Lần 2 đọc được 2000 (khác với lần 1)
        b. Đối với Isolation REPEATABLE READ (không xảy ra Non-Repeatable Read):
            + Lần 1 đọc được 1000
            + Lần 2 vẫn đọc được 1000 (giữ nguyên snapshot cũ)
    2. Cách tránh Non-Repeatable Read:
        + Dùng REPEATABLE READ.
        + Dùng SERIALIZABLE.
        + Dùng Lock row (khóa hàng, không cho update).
*/