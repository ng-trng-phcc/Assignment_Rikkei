create database ss09_bai02;

create table users
(
    user_id  serial primary key,
    email    varchar(50),
    username varchar(50)
);

-- 1. Tạo Hash Index trên cột email
create index idx_user_email_hash on users using hash (email);

-- 2. So sánh hiệu năng (1 triệu user)
explain analyze
select *
from users
where email = 'example@example.com';

/*
    a. Khi không có index:
        Planning Time: 0.053 ms
        Execution Time: 77.335 ms
    b. Khi có index:
        Planning Time: 0.172 ms
        Execution Time: 0.036 ms
*/

-- Lệnh insert 1 triệu user
INSERT INTO Users (email, username)
SELECT CASE
           WHEN i = 500000 THEN 'example@example.com'
           ELSE 'user' || i || '@' ||
                CASE floor(random() * 5)::int
                    WHEN 0 THEN 'gmail.com'
                    WHEN 1 THEN 'yahoo.com'
                    WHEN 2 THEN 'outlook.com'
                    WHEN 3 THEN 'example.com'
                    ELSE 'company.net'
                    END
           END                                             AS email,
       'user_' || i || '_' || floor(random() * 10000)::int AS username
FROM generate_series(1, 1000000) AS i;

