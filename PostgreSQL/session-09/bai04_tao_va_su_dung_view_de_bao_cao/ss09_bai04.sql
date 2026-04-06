create database ss09_bai04;

create table sales
(
    sale_id     serial primary key,
    customer_id int,
    product_id  int,
    sale_date   date,
    amount      int
);

-- 1. Tạo View CustomerSales tổng hợp tổng amount theo từng customer_id
create view vw_CustomerSales as
select customer_id, sum(amount) as total_amount
from sales
group by customer_id;

-- 2. Viết truy vấn SELECT * FROM CustomerSales WHERE total_amount > 1000; để xem khách hàng mua nhiều
select *
from vw_CustomerSales
where total_amount > 1000;

-- 3. Thử cập nhật một bản ghi qua View và quan sát kết quả
update vw_CustomerSales
set total_amount = 1
where customer_id = 1;