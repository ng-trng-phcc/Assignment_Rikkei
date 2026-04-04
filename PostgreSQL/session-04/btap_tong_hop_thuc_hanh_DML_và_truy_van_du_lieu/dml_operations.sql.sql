create
    database btap_tong_hop;

create table customers
(
    customer_id SERIAL primary key,
    full_name   varchar(50),
    email       varchar(50) unique,
    phone       varchar(11),
    city        varchar(100),
    join_date   date
);

create table products
(
    product_id     serial primary key,
    product_name   varchar(50),
    category       varchar(50),
    price          numeric(10, 2),
    stock_quantity int
);

create table orders
(
    order_id     serial primary key,
    customer_id  int references customers (customer_id),
    order_date   date,
    total_amount numeric(10, 2),
    status       varchar(50) CHECK (status IN ('pending', 'confirmed', 'shipped', 'delivered', 'cancelled', 'refunded'))
);

-- 1a. Insert 10 khách hàng.
insert into customers (full_name, email, phone, city, join_date)
values ('Nguyễn Văn An', 'nguyenvanan@email.com', '0901234567', 'Hà Nội', '2024-01-15'),
       ('Trần Thị Bình', 'tranthibinh@email.com', '0912345678', 'Hồ Chí Minh', '2024-02-20'),
       ('Lê Văn Cường', 'levancuong@email.com', '0923456789', 'Đà Nẵng', '2024-03-10'),
       ('Phạm Thị Dung', 'phamthidung@email.com', '0934567890', 'Hải Phòng', '2024-01-05'),
       ('Hoàng Văn Em', 'hoangvanem@email.com', '0945678901', 'Cần Thơ', '2024-02-28'),
       ('Vũ Thị Phượng', 'vuthiphuong@email.com', '0956789012', 'Hà Nội', '2024-03-15'),
       ('Đặng Văn Giang', 'dangvangiang@email.com', '0967890123', 'Hồ Chí Minh', '2024-01-20'),
       ('Bùi Thị Hoa', 'buithihoa@email.com', '0978901234', 'Đà Nẵng', '2024-02-10'),
       ('Ngô Văn Inh', 'ngovaninh@email.com', '0989012345', 'Hải Phòng', '2024-03-01'),
       ('Đỗ Thị Khánh', 'dothikhanh@email.com', '0990123456', 'Cần Thơ', '2024-01-25');

-- 1b. Insert 15 sản phẩm thuộc ít nhất 3 danh mục khác nhau.
insert into products (product_name, category, price, stock_quantity)
values ('iPhone 14 Pro', 'Electronics', 25000000, 50),
       ('Samsung Galaxy S23', 'Electronics', 22000000, 35),
       ('Laptop Dell XPS', 'Electronics', 35000000, 20),
       ('Tai nghe Sony', 'Electronics', 3500000, 100),
       ('Chuột không dây Logitech', 'Electronics', 850000, 150),
       ('Áo sơ mi nam', 'Fashion', 350000, 200),
       ('Quần jean nữ', 'Fashion', 450000, 150),
       ('Váy đầm dự tiệc', 'Fashion', 890000, 80),
       ('Giày thể thao Nike', 'Fashion', 2200000, 60),
       ('Túi xách da', 'Fashion', 1800000, 40),
       ('Nồi cơm điện', 'Home & Living', 1200000, 90),
       ('Máy xay sinh tố', 'Home & Living', 950000, 70),
       ('Bàn ủi hơi nước', 'Home & Living', 750000, 55),
       ('Máy lọc không khí', 'Home & Living', 4500000, 25),
       ('Bộ dao kéo cao cấp', 'Home & Living', 550000, 120);

-- 1c. Insert 8 order với các trạng thái khác nhau
insert into orders (customer_id, order_date, total_amount, status)
values (1, '2024-03-01', 28500000, 'delivered'),
       (2, '2024-03-05', 4500000, 'shipped'),
       (3, '2024-03-10', 890000, 'pending'),
       (4, '2024-03-12', 25500000, 'confirmed'),
       (5, '2024-03-15', 1800000, 'cancelled'),
       (6, '2024-03-18', 5650000, 'delivered'),
       (7, '2024-03-20', 350000, 'refunded'),
       (8, '2024-03-22', 850000, 'shipped'),
       (1, '2024-03-25', 1200000, 'pending'),
       (3, '2024-03-28', 35000000, 'confirmed'),
       (5, '2024-04-01', 4500000, 'delivered'),
       (9, '2024-04-02', 950000, 'shipped'),
       (10, '2024-04-03', 550000, 'pending'),
       (2, '2024-04-04', 22000000, 'confirmed'),
       (4, '2024-04-05', 750000, 'cancelled');

-- 2a. Cập nhật giá sản phẩm thuộc category 'Electronics' tăng 10%
update products
set price = price * 1.1
where category ilike 'Electronics';

-- 2b. Cập nhật số điện thoại cho khách hàng có email cụ thể
update customers
set phone = '123123123'
where email is not null;

-- 2c. Cập nhật trạng thái đơn hàng từ 'PENDING' sang 'CONFIRMED'
update orders
set status = 'CONFIRMED'
where status ilike 'PENDING';

-- 3a. Xóa các sản phẩm có số lượng tồn kho = 0
delete
from products
where stock_quantity = 0;

-- 3b. Xóa khách hàng không có đơn hàng nào
delete
from customers
where customer_id in (select c.customer_id
                      from customers c
                               left join orders o on c.customer_id = o.customer_id
                      where o.customer_id is null);


-- ============================ PHẦN 2 ============================

-- 1. Tìm khách hàng theo tên (sử dụng ILIKE)
select customer_id, full_name, email, phone, city, join_date
from customers
where full_name ilike 'Phước';

-- 2. Lọc sản phẩm theo khoảng giá (sử dụng BETWEEN)
select product_id, product_name, category, price, stock_quantity
from products
where price between 1000 and 2000;

-- 3. Tìm khách hàng chưa có số điện thoại (IS NULL)
select customer_id, full_name, email, phone, city, join_date
from customers
where phone isnull;

-- 4. Top 5 sản phẩm có giá cao nhất (ORDER BY + LIMIT)
select product_id, product_name, category, price, stock_quantity
from products
order by price desc
limit 5;

-- 5. Phân trang danh sách đơn hàng (LIMIT + OFFSET)
select order_id, customer_id, order_date, total_amount, status
from orders o
order by o.order_date desc
limit 5 offset 0;

-- 6. Đếm số khách hàng theo thành phố (DISTINCT + COUNT)
select distinct city, count(customer_id) as "number_of_customers"
from customers
group by city;

-- 7. Tìm đơn hàng trong khoảng thời gian (BETWEEN với DATE)
select *
from orders
where order_date between '2024-02-01' and '2024-04-30';

-- 8. Sản phẩm chưa được bán (NOT EXISTS)
-- Câu này không thể giải được vì không có baảng chi tiết đơn hàng (order_detail) nên không thể xác định trong các đơn hàng đã bán những sản phẩm nào.