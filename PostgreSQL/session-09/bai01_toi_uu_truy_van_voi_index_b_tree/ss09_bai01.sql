create database ss09_bai01;

create table orders
(
    order_id     serial primary key,
    customer_id  int,
    order_date   date,
    total_amount numeric(10, 2)
);

-- 1. Tạo một B-Tree Index trên cột customer_id
create index idx_orders_customer_id on Orders (customer_id);

-- 2. So sánh hiệu năng (với 1 triệu order)
explain analyze
select *
from orders o
where o .customer_id = 1;

/*
    a. Trước khi có index
        Planning Time: 0.257 ms
        Execution Time: 62.211 ms

    b. Sau khi có index
        Planning Time: 0.068 ms
        Execution Time: 0.038 ms
*/




-- Lệnh insert 1 triệu order
INSERT INTO Orders (customer_id, order_date, total_amount)
SELECT
    floor(random() * 100000) + 1,
    CURRENT_DATE - (floor(random() * 1095) || ' days')::interval,
    round((10 + random() * 9990)::numeric, 2)
FROM generate_series(1, 1000000);

