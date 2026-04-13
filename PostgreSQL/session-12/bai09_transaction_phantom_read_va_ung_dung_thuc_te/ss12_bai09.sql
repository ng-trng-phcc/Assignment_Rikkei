create database ss12_bai09;

create table customers (
    customer_id serial primary key ,
    name varchar(50) not null ,
    email varchar(50)
);

create table products (
    product_id serial primary key ,
    name varchar(50) not null ,
    price numeric(10, 2) not null ,
    stock int not null
);

create table orders (
    order_id serial primary key ,
    customer_id int references customers(customer_id),
    product_id int references products(product_id),
    quantity int not null ,
    total_amount numeric(12, 2),
    order_date timestamp default now()
);

insert into customers (name, email)
values ('Nguyễn Văn A', 'a@gmail.com'),
       ('Trần Thị B', 'b@gmail.com');

insert into products (name, price, stock)
values ('Laptop', 15000000, 10),
       ('Mouse', 200000, 50);

insert into orders (customer_id, product_id, quantity, total_amount)
values (1, 1, 2, 30000000),
       (1, 2, 3, 600000);

-- Session A:
begin;
select count(*)
from orders
where quantity > 5;
-- chờ session B thêm đơn hàng

select count(*)
from orders
where quantity > 5;
commit;


/*
    Phần quan sát được;
    1. Đối với READ COMMITTED thì:
        + sau khi lúc ở session A với dữ liệu bên trên không có record nào thỏa mãn:
        + tức là count = 0
        Sau khi qua session B (ở console khác) và insert thêm cho quantity > 5 + commit
        + sau đó quay lại session A này vào chạy lại lệnh select thì count lúc này là 1

    2. Đối với REPEATABLE READ:
        + nếu làm y quy trình trên ở (1.) thì kết quả cả trước lẫn sau đều là 0
*/