# Session 01 – Bài 4: Hệ Thống Nền Tảng Học Trực Tuyến

# 1. Entities

Hệ thống học trực tuyến gồm các thực thể chính sau:

| Entity      | Mô tả                                      |
|-------------|---------------------------------------------|
| NguoiDung   | Lưu thông tin người dùng trong hệ thống     |
| GiangVien   | Lưu thông tin mở rộng của giảng viên        |
| KhoaHoc     | Lưu thông tin các khóa học                  |
| DanhMuc     | Phân loại khóa học                          |
| BaiHoc      | Lưu các bài học trong khóa học              |
| Quiz        | Lưu các bài kiểm tra của bài học            |
| KetQua      | Lưu kết quả làm quiz của học viên           |
| DangKyHoc   | Lưu thông tin học viên đăng ký khóa học     |

---

# 2. Attributes

## NguoiDung

| Attribute | Key | Mô tả |
|---|---|---|
| **MaNguoiDung** | **PK** | Mã người dùng |
| HoTen | | Họ tên |
| Email | | Email |
| MatKhau | | Mật khẩu |
| VaiTro | | Vai trò (student / instructor / admin) |

---

## GiangVien

| Attribute | Key | Mô tả |
|---|---|---|
| **MaNguoiDung** | **PK, FK** | Tham chiếu NguoiDung |
| HocVi | | Học vị |
| ChuyenMon | | Chuyên môn |

---

## DanhMuc

| Attribute | Key | Mô tả |
|---|---|---|
| **MaDanhMuc** | **PK** | Mã danh mục |
| TenDanhMuc | | Tên danh mục |

---

## KhoaHoc

| Attribute | Key | Mô tả |
|---|---|---|
| **MaKhoaHoc** | **PK** | Mã khóa học |
| TenKhoaHoc | | Tên khóa học |
| MoTa | | Mô tả |
| CapDo | | Cấp độ |
| Gia | | Giá khóa học |
| NgayPhatHanh | | Ngày phát hành |
| **MaGiangVien** | **FK** | Giảng viên phụ trách |
| **MaDanhMuc** | **FK** | Thuộc danh mục |

---

## BaiHoc

| Attribute | Key | Mô tả |
|---|---|---|
| **MaBaiHoc** | **PK** | Mã bài học |
| TieuDe | | Tiêu đề |
| NoiDung | | Nội dung |
| ThoiLuong | | Thời lượng |
| **MaKhoaHoc** | **FK** | Thuộc khóa học |

---

## Quiz

| Attribute | Key | Mô tả |
|---|---|---|
| **MaQuiz** | **PK** | Mã quiz |
| TieuDe | | Tiêu đề |
| SoCauHoi | | Số câu hỏi |
| **MaBaiHoc** | **FK** | Thuộc bài học |

---

## DangKyHoc

| Attribute | Key | Mô tả |
|---|---|---|
| **MaDangKy** | **PK** | (**MaNguoiDung, MaKhoaHoc**) |
| NgayDangKy | | Ngày đăng ký |
| TrangThai | | Trạng thái học |
| **MaNguoiDung** | **FK** | Học viên |
| **MaKhoaHoc** | **FK** | Khóa học |

---

## KetQua

| Attribute | Key | Mô tả |
|---|---|---|
| **MaKetQua** | **PK** | (**MaNguoiDung, MaQuiz**) |
| Diem | | Điểm số |
| NgayLam | | Ngày làm bài |
| **MaNguoiDung** | **FK** | Học viên |
| **MaQuiz** | **FK** | Quiz được làm |

---

# 3. Relationships

| Relationship | Entities Involved | Cardinality | Notes |
|---|---|---|---|
| **NguoiDung** có **GiangVien** | NguoiDung – GiangVien | 1 – 1 | Chỉ user có vai trò instructor |
| **GiangVien** dạy **KhoaHoc** | GiangVien – KhoaHoc | 1 – N | Một giảng viên có nhiều khóa |
| **DanhMuc** có **KhoaHoc** | DanhMuc – KhoaHoc | 1 – N | Một danh mục có nhiều khóa |
| **KhoaHoc** có **BaiHoc** | KhoaHoc – BaiHoc | 1 – N | Một khóa học có nhiều bài |
| **BaiHoc** có **Quiz** | BaiHoc – Quiz | 1 – N | Một bài học có thể có nhiều quiz |
| **NguoiDung** đăng ký **KhoaHoc** | NguoiDung – KhoaHoc | N – N | Thông qua bảng DangKyHoc |
| **NguoiDung** làm **Quiz** | NguoiDung – Quiz | N – N | Kết quả lưu tại KetQua |

---

# 4. Primary Keys

| Entity | Primary Key |
|---|---|
| NguoiDung | MaNguoiDung |
| GiangVien | MaNguoiDung |
| DanhMuc | MaDanhMuc |
| KhoaHoc | MaKhoaHoc |
| BaiHoc | MaBaiHoc |
| Quiz | MaQuiz |
| KetQua | MaKetQua |
| DangKyHoc | MaDangKy |

---

# 5. Foreign Keys

| Table | Foreign Key | Reference |
|---|---|---|
| GiangVien | MaNguoiDung | **NguoiDung**(MaNguoiDung) |
| KhoaHoc | MaGiangVien | **GiangVien**(MaNguoiDung) |
| KhoaHoc | MaDanhMuc | **DanhMuc**(MaDanhMuc) |
| BaiHoc | MaKhoaHoc | **KhoaHoc**(MaKhoaHoc) |
| Quiz | MaBaiHoc | **BaiHoc**(MaBaiHoc) |
| DangKyHoc | MaNguoiDung | **NguoiDung**(MaNguoiDung) |
| DangKyHoc | MaKhoaHoc | **KhoaHoc**(MaKhoaHoc) |
| KetQua | MaNguoiDung | **NguoiDung**(MaNguoiDung) |
| KetQua | MaQuiz | **Quiz**(MaQuiz) |

---

# 6. Multi-valued Attributes

Trong mô hình này **không tồn tại thuộc tính đa trị**.

---

# 7. Business Rule (Optional)

Một học viên **không thể đăng ký cùng một khóa học nhiều lần**.

#### Logic ràng buộc:

Trong bảng **DangKyHoc** cần đảm bảo:
UNIQUE (MaNguoiDung, MaKhoaHoc)

Điều này đảm bảo mỗi học viên chỉ có **một bản ghi đăng ký cho mỗi khóa học**.

---

# 8. ER Diagram

Sơ đồ ERD được lưu tại:
```
report.md
```
