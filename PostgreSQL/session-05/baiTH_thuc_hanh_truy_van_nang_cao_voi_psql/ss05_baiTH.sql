create database ss05_baiTH;

create table categories
(
    category_id   serial primary key,
    category_name varchar,
    description   text
);

create table products
(
    product_id     serial primary key,
    product_name   varchar,
    category_id    int references categories (category_id),
    price          numeric(10, 2),
    stock_quantity int
);

create table customers
(
    customer_id   serial primary key,
    customer_name varchar,
    email         varchar,
    city          varchar,
    join_date     date
);

create table orders
(
    order_id     serial primary key,
    customer_id  int references customers (customer_id),
    order_date   date,
    total_amount int,
    status       varchar
);

create table order_items
(
    item_id    serial primary key,
    order_id   int references orders (order_id),
    product_id int references products (product_id),
    unit_price numeric(10, 2)
);


/*
    Phần 1: ALIAS & Aggregate Functions (2 điểm)

        1. Liệt kê danh sách sản phẩm gồm: Tên sản phẩm (Alias: "Tên SP"), Giá niêm yết (Alias: "Đơn giá") và "Giá sau thuế" (Giá * 1.1, Alias: "Giá VAT").

        2. Đếm tổng số khách hàng hiện có theo từng thành phố (Sắp xếp giảm dần theo số lượng).

        3. Tính giá cao nhất, thấp nhất và trung bình của các sản phẩm có trong kho.

        4. Thống kê số lượng đơn hàng theo từng trạng thái (Status).
*/
-- 1.
select product_name as "Tên SP", unit_price as "Đơn giá", unit_price * 1.1 as "Giá sau thuế"
from products p
         join order_items oi on p.product_id = oi.product_id;

-- 2. Đếm tổng số khách hàng hiện có theo từng thành phố (Sắp xếp giảm dần theo số lượng).
select city, count(c.customer_id) as total_orders
from orders o
         join customers c on c.customer_id = o.customer_id
group by city
order by total_orders desc;

-- 3. Tính giá cao nhất, thấp nhất và trung bình của các sản phẩm có trong kho.
select max(price) as "Giá cao nhất", min(price) as "Giá thấp nhất", avg(price) as "Giá trung bình"
from products;

-- 4. Thống kê số lượng đơn hàng theo từng trạng thái (Status).
select o.status, count(oi.product_id) as "Số lượng đơn hàng"
from orders o
         join order_items oi on o.order_id = oi.order_id
group by o.status;



/*
    Phần 2: JOINs & GROUP BY (2 điểm)

        5. (Inner Join): Hiển thị 10 đơn hàng gần nhất gồm: Mã đơn, Tên khách hàng, Email và Tổng giá trị đơn hàng.

        6. (Left Join): Liệt kê tất cả danh mục (Categories) và số lượng sản phẩm thuộc danh mục đó (Kể cả danh mục chưa có sản phẩm).

        7. (Group By & Having): Tìm các khách hàng đã đặt từ 3 đơn hàng trở lên và có tổng chi tiêu (total_amount) > 5.000.000 VNĐ.

        8. Thống kê tổng doanh thu theo từng tên danh mục sản phẩm (Nối 4 bảng: Categories, Products, Order_Items, Orders).
*/

-- 5. (Inner Join): Hiển thị 10 đơn hàng gần nhất gồm: Mã đơn, Tên khách hàng, Email và Tổng giá trị đơn hàng.
select order_id, customer_name, email, total_amount
from orders o
         inner join customers c on c.customer_id = o.customer_id;

-- 6. (Left Join): Liệt kê tất cả danh mục (Categories) và số lượng sản phẩm thuộc danh mục đó (Kể cả danh mục chưa có sản phẩm).
select c.category_id, category_name, count(product_id)
from categories c
         left join products p on c.category_id = p.category_id
group by c.category_id, category_name;

-- 7. (Group By & Having): Tìm các khách hàng đã đặt từ 3 đơn hàng trở lên và có tổng chi tiêu (total_amount) > 5.000.000 VNĐ.
select customer_name, total_amount, count(order_id) as total_orders
from orders o
         join customers c on c.customer_id = o.customer_id
where total_amount > 5000000
group by customer_name, total_amount
having count(order_id) >= 3;

-- 8. Thống kê tổng doanh thu theo từng tên danh mục sản phẩm (Nối 4 bảng: Categories, Products, Order_Items, Orders).
select c.category_name, sum(oi.unit_price) AS total_revenue
from categories c
         join products p on c.category_id = p.category_id
         join order_items oi on p.product_id = oi.product_id
         join orders o on o.order_id = oi.order_id
where o.status = 'completed'
group by c.category_id, c.category_name;


/*
    Phần 3: Subqueries (2 điểm)

        9. Tìm thông tin sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm trong hệ thống.

        10. Tìm các khách hàng chưa từng phát sinh bất kỳ đơn hàng nào (Sử dụng NOT EXISTS).

        11. Liệt kê các sản phẩm có giá cao hơn giá trung bình của chính danh mục mà sản phẩm đó thuộc về (Correlated Subquery).

        12. Tìm khách hàng đã thực hiện đơn hàng có giá trị lớn nhất trong toàn bộ hệ thống.
*/

-- 9. Tìm thông tin sản phẩm có giá cao hơn giá trung bình của tất cả sản phẩm trong hệ thống.
select product_id, product_name, category_id, price, stock_quantity
from products
where price > (select avg(price)
               from products);

-- 10. Tìm các khách hàng chưa từng phát sinh bất kỳ đơn hàng nào (Sử dụng NOT EXISTS).
select customer_id, customer_name, email, city, join_date
from customers c
where not exists(select 1
                 from orders o
                 where o.customer_id = c.customer_id);

-- 11. Liệt kê các sản phẩm có giá cao hơn giá trung bình của chính danh mục mà sản phẩm đó thuộc về (Correlated Subquery).
select product_id, product_name, category_id, price, stock_quantity
from products p
where p.price > (select avg(p2.price)
                 from products p2
                 where p2.category_id = p.category_id);

-- 12. Tìm khách hàng đã thực hiện đơn hàng có giá trị lớn nhất trong toàn bộ hệ thống.
select c.customer_id, customer_name, o.total_amount
from customers c
         join orders o on c.customer_id = o.customer_id
where o.total_amount = (select max(o.total_amount) from orders);



/*
    Phần 4: Set Operators - UNION/INTERSECT/EXCEPT (2 điểm)

        13. (UNION): Gộp danh sách Email của khách hàng và Email của các nhà cung cấp (giả sử có bảng suppliers) để làm danh sách gửi tin NewsLetter.

        14. (INTERSECT): Tìm danh sách customer_id vừa mua sản phẩm thuộc danh mục 'Electronics' vừa mua sản phẩm thuộc danh mục 'Books'.

        15. (EXCEPT): Tìm danh sách các sản phẩm có trong kho (products) nhưng chưa từng xuất hiện trong bất kỳ đơn hàng nào (order_items).
*/

-- 13. (UNION): Gộp danh sách Email của khách hàng và Email của các nhà cung cấp (giả sử có bảng suppliers) để làm danh sách gửi tin NewsLetter.
select email
from customers
union
select email
from suppliers;

-- 14. (INTERSECT): Tìm danh sách customer_id vừa mua sản phẩm thuộc danh mục 'Electronics' vừa mua sản phẩm thuộc danh mục 'Books'.
select customer_id
from products p
         join categories c on c.category_id = p.category_id
         join order_items oi on p.product_id = oi.product_id
         join orders o on o.order_id = oi.order_id
where category_name = 'Electronics'
intersect
select customer_id
from products p
         join categories c on c.category_id = p.category_id
         join order_items oi on p.product_id = oi.product_id
         join orders o on o.order_id = oi.order_id
where category_name = 'Books';

-- 15. (EXCEPT): Tìm danh sách các sản phẩm có trong kho (products) nhưng chưa từng xuất hiện trong bất kỳ đơn hàng nào (order_items).
select product_id
from products
except
select product_id
from order_items;



/*
    Phần 5: SQL Logic & Clean Code (2 điểm)

        16. Viết truy vấn cập nhật lại total_amount trong bảng orders dựa trên tổng tiền từ bảng order_items tương ứng.

        17. Tạo một View tên là vw_customer_summary hiển thị: Tên khách hàng, Tổng số đơn đã mua, Tổng số tiền đã chi tiêu.

        18. Viết truy vấn tìm thành phố có doanh thu cao nhất trong năm 2026.
*/

-- 16. Viết truy vấn cập nhật lại total_amount trong bảng orders dựa trên tổng tiền từ bảng order_items tương ứng.
update orders o
set total_amount = total_revenue
from (select order_id, sum(unit_price) as total_revenue
      from order_items
      group by order_id) oi
where o.order_id = oi.order_id;

-- 17. Tạo một View tên là vw_customer_summary hiển thị: Tên khách hàng, Tổng số đơn đã mua, Tổng số tiền đã chi tiêu.
create view vw_customer_summary as
select customer_name, count(order_id) as total_orders, sum(total_amount) as total_spent
from customers c
         join orders o on c.customer_id = o.customer_id
group by c.customer_id, customer_name;

-- 18. Viết truy vấn tìm thành phố có doanh thu cao nhất trong năm 2026.
select city, sum(total_amount) as total_revenue
from customers c
         join orders o on c.customer_id = o.customer_id
where order_date between '2026-01-01' and '2026-12-31'
group by city
order by sum(total_amount) desc
limit 1;

-- Trong trường hợp có nhiều city cùng có doanh thu cao nhất
select city, sum(total_amount) as total_revenue
from customers c
         join orders o on c.customer_id = o.customer_id
where order_date between '2026-01-01' and '2026-12-31'
group by city
having sum(total_amount) = (
    select max(total_revenue)      -- Tìm ra doanh thu cao nhất
    from (
        select sum(total_amount) as total_revenue       -- tính tổng doanh thu
        from orders o2
        join customers c2 on c2.customer_id = o2.customer_id
        where order_date between '2026-01-01' and '2026-12-31'
        group by c2.city
    ) city_totals
);