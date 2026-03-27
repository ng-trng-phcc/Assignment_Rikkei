create database ss05_bai05;

CREATE TABLE students
(
    student_id SERIAL PRIMARY KEY,
    full_name  VARCHAR(100),
    major      VARCHAR(50)
);

CREATE TABLE courses
(
    course_id   SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credit      INT
);

CREATE TABLE enrollments
(
    student_id INT REFERENCES students (student_id),
    course_id  INT REFERENCES courses (course_id),
    score      NUMERIC(5, 2)
);

-- 1: Liệt kê danh sách sinh viên cùng tên môn học và điểm
select s.full_name as "Tên sinh viên", c.course_name as "Tên môn học", e.score as "Điểm"
from enrollments e
         join courses c on c.course_id = e.course_id
         join students s on s.student_id = e.student_id;

-- 2: Tính cho từng sinh viên: Điểm trung bình, Điểm cao nhất, Điểm thấp nhất
select student_id, avg(score), max(score), min(score)
from enrollments
group by student_id;

-- 3: Tìm ngành học (major) có điểm trung bình cao hơn 7.5
select major, avg(score)
from enrollments e
         join students s on s.student_id = e.student_id
group by major
having avg(score) > 7.5;

-- 4: Liệt kê tất cả sinh viên, môn học, số tín chỉ và điểm (JOIN 3 bảng)
select full_name, course_name, credit, score
from enrollments e
         join students s on s.student_id = e.student_id
         join courses c on c.course_id = e.course_id;

-- 5: Tìm sinh viên có điểm trung bình cao hơn điểm trung bình toàn trường
select student_id, avg(score)
from enrollments e
group by student_id
having avg(score) > (select avg(score)
                     from enrollments);