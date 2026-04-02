create database ss07_bai04;

CREATE TABLE customer
(
    customer_id SERIAL PRIMARY KEY,
    full_name   VARCHAR(100),
    region      VARCHAR(50)

);

CREATE TABLE orders
(
    order_id     SERIAL PRIMARY KEY,
    customer_id  INT REFERENCES customer (customer_id),
    total_amount DECIMAL(10, 2),
    order_date   DATE,
    status       VARCHAR(20)

);

CREATE TABLE product
(
    product_id SERIAL PRIMARY KEY,
    name       VARCHAR(100),
    price      DECIMAL(10, 2),
    category   VARCHAR(50)

);

CREATE TABLE order_detail
(
    order_id   INT REFERENCES orders (order_id),
    product_id INT REFERENCES product (product_id),
    quantity   INT

);

-- 1. tạo view
CREATE VIEW v_revenue_by_region AS
SELECT c.region, SUM(o.total_amount) AS total_revenue
FROM customer c
         JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.region;

-- 1a. Viết truy vấn xem top 3 khu vực có doanh thu cao nhất
select region, total_revenue
from v_revenue_by_region
order by total_revenue desc
limit 3;

-- 2. Từ v_revenue_by_region, tạo View mới v_revenue_above_avg chỉ hiển thị khu vực có doanh thu > trung bình toàn quốc
create view v_revenue_above_avg as
select region, avg(total_revenue) as avg_revenue
from v_revenue_by_region
group by region
having avg(total_revenue) > (select region, avg(total_revenue) as avg_total_revenue
                             from v_revenue_by_region
                             group by region);



