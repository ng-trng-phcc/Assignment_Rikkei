create database ss09_bai03;

create table products
(
    product_id     serial primary key,
    category_id    int,
    price          numeric(10, 2),
    stock_quantity int
);

-- 1. Tạo Clustered Index trên cột category_id
create index idx_products_category_id on products (product_id);
cluster products using idx_products_category_id;

-- 2. Tạo Non-clustered Index trên cột price
create index idx_products_price on products (price);

-- Thực hiện truy vấn SELECT * FROM Products WHERE category_id = X ORDER BY price; và giải thích cách Index hỗ trợ tối ưu
SELECT * FROM Products WHERE category_id = 1 ORDER BY price;

/*
    Giải thích:
        + Khi cluster category_id thì hệ thống sẽ lưu dữ liệu được sắp xếp theo category_id (chứ không còn là product_id nữa). Nên select theo category sẽ rất nhanh.
        + Khi gặp where category_id = 1. Hệ thống tìm tất cả các dòng với category_id = 1 trên cluster index.
        + Giả sử tìm được n record thỏa mãn. Nhưng price bị lộn xộn.
        + Sau đó price được sắp xếp theo lệnh ORDER BY..
        + Trong câu truy vấn trên thì non-cluster index không được dùng vì nó sẽ sắp xếp dữ liệu theo price nhưng lọc price rồi tìm id sẽ lâu hơn lọc id rồi tìm price.
*/