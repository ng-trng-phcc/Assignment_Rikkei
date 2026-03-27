# Hệ thống Quản lý Đào tạo

## 1. Các thực thể

Hệ thống gồm 4 thực thể:

* Sinh viên
* Môn học
* Giảng viên
* Lớp học phần

---

# 2. Các mối quan hệ

| Thực thể A | Thực thể B   | Quan hệ   | Kiểu  |
| ---------- | ------------ | --------- | ----- |
| Sinh viên  | Lớp học phần | Đăng ký   | N – N |
| Giảng viên | Lớp học phần | Giảng dạy | 1 – N |
| Môn học    | Lớp học phần | Thuộc     | 1 – N |
| Giảng viên | Môn học      | Giảng dạy | N – N |

---

# 3. Ý nghĩa thực tế của từng mối quan hệ

| Quan hệ                   | Kiểu  | Ý nghĩa thực tế                          |
| ------------------------- | ----- | ---------------------------------------- |
| Sinh viên – Lớp học phần  | N – N | Sinh viên đăng ký lớp để học             |
| Giảng viên – Lớp học phần | 1 – N | Giảng viên dạy các lớp                   |
| Môn học – Lớp học phần    | 1 – N | Một môn mở nhiều lớp                     |
| Giảng viên – Môn học      | N – N | Giảng viên có thể dạy nhiều môn          |
| Sinh viên – Môn học       | N – N | Sinh viên học môn thông qua lớp học phần |


Ví dụ:

* SinhVien_LopHocPhan (bảng trung gian)
* GiangVien_MonHoc (bảng trung gian)

---
