
# Hệ thống Quản lý Khóa học

## 1. Thực thể và thuộc tính

### 1.1 Khóa học

| Thuộc tính | Ghi chú         |
| ---------- | --------------- |
| MaKhoaHoc  | **Primary Key** |
| TenKhoaHoc |                 |
| MoTa       |                 |
| HocPhi     |                 |

---

### 1.2 Giảng viên

| Thuộc tính  | Ghi chú         |
| ----------- | --------------- |
| MaGiangVien | **Primary Key** |
| HoTen       |                 |
| ChuyenNganh |                 |
| SoDienThoai |                 |

---

### 1.3 Học viên

| Thuộc tính | Ghi chú         |
| ---------- | --------------- |
| MaHocVien  | **Primary Key** |
| HoTen      |                 |
| Email      |                 |
| NgayDangKy |                 |

---

### 1.4 Lớp học

| Thuộc tính  | Ghi chú                     |
| ----------- | --------------------------- |
| MaLop       | **Primary Key**             |
| TenLop |                             |
| MaGiangVien | **Foreign Key → GiangVien** |
| MaKhoaHoc   | **Foreign Key → KhoaHoc**   |

---

# 2. Mối quan hệ giữa các thực thể

| Thực thể A | Thực thể B | Quan hệ   | Kiểu                      |
| ---------- | ---------- | --------- | ------------------------- |
| Khóa học   | Lớp học    | Mở lớp    | 1 – N                     |
| Giảng viên | Lớp học    | Giảng dạy | 1 – N                     |
| Học viên   | Lớp học    | Đăng ký   | N – N                     |
| Học viên   | Khóa học   | Học       | N – N (thông qua Lớp học) |

---

# 3. Chuyển mô hình ER sang mô hình quan hệ

## Các bảng quan hệ

**KhoaHoc**(**MaKhoaHoc**, TenKhoaHoc, MoTa, HocPhi)

**GiangVien**(**MaGiangVien**, HoTen, ChuyenNganh, SoDienThoai)

**HocVien**(**MaHocVien**, HoTen, Email, NgayDangKy)

**LopHoc**(**MaLop**, TenLop, *MaGiangVien*, *MaKhoaHoc*)

**DangKy**(***MaHocVien*** , ***MaLop***, ThoiGianHoc)

##### Chú thích:
+ Chữ được bôi đen = khóa chính (PKey) (trừ tên **thực thể/bảng**).
+ Chữ in nghiêng = khóa ngoại (FKey)

---

# 4. Giải thích kiểu quan hệ

| Thực thể A | Thực thể B | Kiểu quan hệ | Giải thích                                                                                                                               |
| ---------- | ---------- | ------------ | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Khóa học   | Lớp học    | 1 – N        | Một khóa học có thể mở nhiều lớp học khác nhau theo thời gian hoặc lịch học khác nhau, nhưng mỗi lớp học chỉ thuộc một khóa học.         |
| Giảng viên | Lớp học    | 1 – N        | Một giảng viên có thể dạy nhiều lớp học, nhưng mỗi lớp học chỉ có một giảng viên phụ trách.                                              |
| Học viên   | Lớp học    | N – N        | Một học viên có thể đăng ký nhiều lớp học, và một lớp học có nhiều học viên → cần bảng trung gian **DangKy**.                                |
