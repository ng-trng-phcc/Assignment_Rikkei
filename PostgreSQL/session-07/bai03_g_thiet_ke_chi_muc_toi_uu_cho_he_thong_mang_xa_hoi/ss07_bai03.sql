create database ss07_bai03;

CREATE TABLE post
(
    post_id    SERIAL PRIMARY KEY,
    user_id    INT NOT NULL,
    content    TEXT,
    tags       TEXT[],
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_public  BOOLEAN   DEFAULT TRUE

);

CREATE TABLE post_like
(
    user_id  INT NOT NULL,
    post_id  INT NOT NULL,
    liked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, post_id)

);

-- 1. Tối ưu hóa truy vấn tìm kiếm bài đăng công khai theo từ khóa: (content)

-- a. Tạo Expression Index sử dụng LOWER(content) để tăng tốc tìm kiếm
create index idx_post_public_content_lower on post (lower(content)) where is_public = true;

-- b.
--     Kết quả (với 1 triệu dữ liệu - lênh insert bên dưới cùng file sql này):
explain analyze
SELECT * FROM post
WHERE is_public = TRUE AND content ILIKE '%du lich%' ;

/* Trước khi tạo index:
   Seq Scan on post  (cost=0.00..30682.00 rows=700797 width=110) (actual time=0.011..1071.802 rows=700320 loops=1)
      Filter: (is_public AND (content ~~* '%du lich%'::text))
      Rows Removed by Filter: 299680
    Planning Time: 0.189 ms
    Execution Time: 1085.778 ms

   Sau khi có index:
   Seq Scan on post  (cost=0.00..30682.00 rows=700797 width=110) (actual time=0.014..1112.997 rows=700320 loops=1)
      Filter: (is_public AND (content ~~* '%du lich%'::text))
      Rows Removed by Filter: 299680
    Planning Time: 0.194 ms
    Execution Time: 1079.800 ms
*/

-- 2. Tạo GIN Index cho cột tags
create index idx_post_tags on post using gin(tags);

explain analyze SELECT * FROM post WHERE tags @> ARRAY['travel'];

-- Planning Time: 0.128 ms
-- Execution Time: 292.725 ms

-- Planning Time: 0.108 ms (sau khi đã có index)
-- Execution Time: 266.366 ms

--     3.
explain analyze
SELECT * FROM post
WHERE is_public = TRUE AND created_at >= NOW() - INTERVAL '7 days';

-- Planning Time: 0.127 ms
-- Execution Time: 160.014 ms

CREATE INDEX idx_post_recent_public
    ON post(created_at DESC)
    WHERE is_public = TRUE;

-- Hiệu suất của created_at sau khi tạo index
-- Planning Time: 0.300 ms
-- Execution Time: 40.553 ms

-- 4. Tạo chỉ mục (user_id, created_at DESC)
CREATE INDEX idx_post_user_created
    ON post (user_id, created_at DESC);

explain analyze
SELECT *
FROM post
WHERE user_id = 10
ORDER BY created_at DESC;

-- Planning Time: 0.149 ms
-- Execution Time: 107.242 ms

-- sau khi tạo index thì:
-- Planning Time: 0.250 ms
-- Execution Time: 2.998 ms







-- insert 1 triệu record
INSERT INTO post (user_id, content, tags, created_at, is_public)
SELECT
    (random() * 1000)::int,
    'Post content about du lich number ' || g,
    ARRAY['travel', 'food', 'review'],
    NOW() - (random() * INTERVAL '365 days'),
    random() > 0.3
FROM generate_series(1, 1000000) AS g;
