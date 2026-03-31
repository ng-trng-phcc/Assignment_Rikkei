create database ss07_bai05;

CREATE TABLE customers
(
    customer_id SERIAL PRIMARY KEY,
    full_name   VARCHAR(100),
    email       VARCHAR(100) UNIQUE,
    city        VARCHAR(50)

);

CREATE TABLE products
(
    product_id   SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category     TEXT[],
    price        NUMERIC(10, 2)

);

CREATE TABLE orders
(
    order_id    SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers (customer_id),
    product_id  INT REFERENCES products (product_id),
    order_date  DATE,
    quantity    INT

);

-- 1. Thêm dữ liệu mẫu (ít nhất 5 khách hàng, 5 sản phẩm, 10 đơn hàng)
INSERT INTO customers (full_name, email, city)
VALUES ('Nguyen Van A', 'a@gmail.com', 'Ha Noi'),
       ('Tran Thi B', 'b@gmail.com', 'Ho Chi Minh'),
       ('Le Van C', 'c@gmail.com', 'Da Nang'),
       ('Pham Thi D', 'd@gmail.com', 'Hai Phong'),
       ('Hoang Van E', 'e@gmail.com', 'Can Tho');
INSERT INTO products (product_name, category, price)
VALUES ('Laptop Dell', ARRAY ['electronics','computer'], 1500.00),
       ('iPhone 15', ARRAY ['electronics','phone'], 1200.00),
       ('Office Chair', ARRAY ['furniture'], 200.00),
       ('Mechanical Keyboard', ARRAY ['electronics','accessory'], 150.00),
       ('Running Shoes', ARRAY ['fashion','sport'], 100.00);
INSERT INTO orders (customer_id, product_id, order_date, quantity)
VALUES (1, 1, '2025-01-10', 1),
       (1, 3, '2025-01-15', 2),
       (2, 2, '2025-02-01', 1),
       (2, 5, '2025-02-03', 1),
       (3, 4, '2025-02-10', 1),
       (3, 1, '2025-02-15', 1),
       (4, 3, '2025-03-01', 4),
       (5, 2, '2025-03-05', 1),
       (5, 5, '2025-03-07', 2),
       (1, 4, '2025-03-10', 1);

-- 2a. Tạo chỉ mục B-tree trên cột email để tối ưu tìm khách hàng theo email
create index idx_customers_email on customers (email);

-- 2b. Tạo chỉ mục Hash trên cột city để lọc theo thành phố
create index idx_customers_city_hash on customers using hash (city);

-- 2c. Tạo chỉ mục GIN trên cột category của products để hỗ trợ tìm theo danh mục (mảng)
create index idx_products_category_gin on products using gin (category);

-- 2d. Tạo chỉ mục GiST trên cột price để hỗ trợ tìm sản phẩm trong khoảng giá.
create index idx_products_price_gist on products using gist (numrange(price, price));

-- 4. Thực hiện Clustered Index trên bảng orders theo cột order_date
create index idx_orders_order_date on orders (order_date desc);
cluster orders using idx_orders_order_date;

/*
    5. :

    Xem top 3 khách hàng mua nhiều nhất
    Xem tổng doanh thu theo từng sản phẩm
*/
-- 5a. Sử dụng View để Xem top 3 khách hàng mua nhiều nhất
create view vw_top3_customer as
select c.customer_id, full_name, sum(o.quantity) as total_quantity
from customers c
         join orders o on c.customer_id = o.customer_id
group by c.customer_id, full_name
order by total_quantity desc
limit 3;

-- 5b. Sử dụng View để Xem tổng doanh thu theo từng sản phẩm
create view vw_doanh_thu_theo_sp as
select p.product_id, product_name, sum(price * quantity) as total_revenue
from products p
join orders o on p.product_id = o.product_id
group by p.product_id, product_name
order by total_revenue desc;