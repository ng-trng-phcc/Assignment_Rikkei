create database ss07_bai01;

CREATE TABLE book
(
    book_id     SERIAL PRIMARY KEY,
    title       VARCHAR(255),
    author      VARCHAR(100),
    genre       VARCHAR(50),
    price       DECIMAL(10, 2),
    description TEXT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

-- 1. Tạo các chỉ mục phù hợp để tối ưu truy vấn sau:
-- a. SELECT * FROM book WHERE author ILIKE '%Rowling%' ;
CREATE INDEX idx_author_fts
    ON book
        USING gin (to_tsvector('english', author));

-- b. SELECT * FROM book WHERE genre = 'Fantasy' ;
create index idx_genre on book (genre);


-- 2. So sánh thời gian truy vấn trước và sau khi tạo Index (dùng EXPLAIN ANALYZE)
explain analyze
SELECT *
FROM book
WHERE author ILIKE '%Rowling%';
/*
    a. Khi không có index:
        Seq Scan on book  (cost=0.00..13270.00 rows=99733 width=79) (actual time=0.011..472.859 rows=100369 loops=1)
            Filter: ((author)::text ~~* '%Rowling%'::text)
            Rows Removed by Filter: 399631
        Planning Time: 0.104 ms
        Execution Time: 475.238 ms

    b. Khi có index (full-text-search):
        Seq Scan on book  (cost=0.00..13270.00 rows=99733 width=79) (actual time=0.013..469.709 rows=100369 loops=1)
            Filter: ((author)::text ~~* '%Rowling%'::text)
            Rows Removed by Filter: 399631
        Planning Time: 0.211 ms
        Execution Time: 472.029 ms
*/

explain analyze
SELECT *
FROM book
WHERE genre = 'Fantasy';
/*
    a. Khi không có index:
        Seq Scan on book  (cost=0.00..13270.00 rows=124533 width=79) (actual time=0.010..54.380 rows=125275 loops=1)
            Filter: ((genre)::text = 'Fantasy'::text)
            Rows Removed by Filter: 374725
        Planning Time: 0.095 ms
        Execution Time: 56.723 ms

    b. Khi có index:
        Bitmap Heap Scan on book  (cost=1393.55..9970.22 rows=124533 width=79) (actual time=4.751..23.879 rows=125275 loops=1)
            Recheck Cond: ((genre)::text = 'Fantasy'::text)
            Heap Blocks: exact=7020
            ->  Bitmap Index Scan on idx_genre  (cost=0.00..1362.42 rows=124533 width=0) (actual time=3.955..3.955 rows=125275 loops=1)
                Index Cond: ((genre)::text = 'Fantasy'::text)
        Planning Time: 0.259 ms
        Execution Time: 26.347 ms
*/

-- 3. Thử nghiệm các loại chỉ mục khác nhau:
--  a. B-tree cho genre: đã tạo ở câu 2.
--  b. GIN cho title hoặc description (phục vụ tìm kiếm full-text)
CREATE INDEX idx_book_fts
    ON book
        USING gin (
                   to_tsvector('english', title || ' ' || description) -- cả title và description index chung 1 vector
            );

-- 4. Tạo một Clustered Index (sử dụng lệnh CLUSTER) trên bảng book theo cột genre và kiểm tra sự khác biệt trong hiệu suất
cluster book using idx_genre;

-- Khi chạy lại lệnh explain thì:
/*
Bitmap Heap Scan on book  (cost=1393.55..9980.22 rows=124533 width=79) (actual time=3.255..21.954 rows=125275 loops=1)
  Recheck Cond: ((genre)::text = 'Fantasy'::text)
  Heap Blocks: exact=1755
  ->  Bitmap Index Scan on idx_genre  (cost=0.00..1362.42 rows=124533 width=0) (actual time=3.042..3.042 rows=125275 loops=1)
        Index Cond: ((genre)::text = 'Fantasy'::text)
Planning Time: 0.338 ms
Execution Time: 24.265 ms

*/



