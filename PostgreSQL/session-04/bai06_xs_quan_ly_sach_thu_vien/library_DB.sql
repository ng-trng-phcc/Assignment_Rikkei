-- Thêm dữ liệu vào bảng
insert INTO library.books(title, author, published_year, category, price, stock)
values ('Lập trình C cơ bản', 'Nguyễn Văn Nam', 2018, 'CNTT', 95000, 20),
       ('Học SQL qua ví dụ', 'Trần Thị Hạnh', 2020, 'CSDL', 125000, 12),
       ('Lập trình C cơ bản', 'Nguyễn Văn Nam', 2018, 'CNTT', 95000, 20),
       ('Phân tích dữ liệu với Python', 'Lê Quốc Bảo', 2022, 'CNTT', 95000, null),
       ('Quản trị cơ sở dữ liệu', 'Nguyễn Thị Minh', 2021, 'CSDL', 150000, 5),
       ('Học máy cho người mới bắt đầu', 'Nguyễn Văn Nam', 2023, 'AI', 220000, 8),
       ('Khoa học dữ liệu cơ bản', 'Nguyễn Văn Nam', 2023, 'AI', 220000, null);

-- Câu 2
update library.books
set price = price * 1.1
where published_year >= 2021
  and price < 200000;

-- Câu 3 cập nhật lại những record nào có stock is null thì thành 0
update library.books
set stock = 0
where stock is null;

-- Câu 4a: Liệt kê danh sách sách thuộc chủ đề CNTT hoặc AI có giá trong khoảng 100000 - 250000
select book_id, title, author, published_year, category, price, stock
from library.books
where category in ('CNTT', 'AI')
  AND price between 100000 and 250000;

-- Câu 4b: Sắp xếp giảm dần theo price, rồi tăng dần theo title
select book_id, title, author, published_year, category, price, stock
from library.books
where book_id in (select book_id
                  from library.books
                  order by price desc)
order by title;

-- Câu 5: Tìm các sách có tiêu đề chứa từ “học” (không phân biệt hoa thường)
select book_id, title, author, published_year, category, price, stock
from library.books
where title ilike '%học%';

-- Câu 6: Liệt kê các thể loại duy nhất (DISTINCT) có ít nhất một cuốn sách xuất bản sau năm 2020
select distinct category
from library.books
where published_year > 2020;

-- Câu 7: Chỉ hiển thị 2 kết quả đầu tiên, bỏ qua 1 kết quả đầu tiên (dùng LIMIT + OFFSET)
select distinct category
from library.books
where published_year > 2020
limit 2 offset 1
