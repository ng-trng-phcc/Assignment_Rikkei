# Hệ thống Quản lý Thư viện

## 1. Các thực thể chính

Hệ thống có 3 thực thể chính:

* Sách
* Độc giả
* Phiếu mượn sách

---

## 2. Thuộc tính của từng thực thể

### Thực thể: Sách

| Thuộc tính | Mô tả            | Loại        |
| ---------- | ---------------- | ----------- |
| ISBN       | Mã ISBN của sách | Primary Key |
| TenSach    | Tên sách         |             |
| TacGia     | Tác giả          |             |
| NamXuatBan | Năm xuất bản     |             |
| TheLoai    | Thể loại         |             |

---

### Thực thể: Độc giả

| Thuộc tính  | Mô tả         | Loại        |
| ----------- | ------------- | ----------- |
| MaDocGia    | Mã độc giả    | Primary Key |
| HoTen       | Họ tên        |             |
| NgaySinh    | Ngày sinh     |             |
| DiaChi      | Địa chỉ       |             |
| SoDienThoai | Số điện thoại |             |

---

### Thực thể: Phiếu mượn sách

| Thuộc tính    | Mô tả            | Loại        |
| ------------- | ---------------- | ----------- |
| MaPhieu       | Mã phiếu mượn    | Primary Key |
| NgayMuon      | Ngày mượn        |             |
| NgayTraDuKien | Ngày trả dự kiến |             |
| TrangThai     | Trạng thái       |             |
| MaDocGia      | Mã độc giả       | Foreign Key |
| ISBN          | Mã sách          | Foreign Key |

---

## 3. Khóa chính và khóa ngoại

### Primary Key

* Sách: **ISBN**
* Độc giả: **MaDocGia**
* Phiếu mượn: **MaPhieu**

### Foreign Key

* **MaDocGia** → tham chiếu Độc giả
* **ISBN** → tham chiếu Sách

---

## 4. Quan hệ giữa các thực thể

* Độc giả **mượn** Sách thông qua Phiếu mượn
* Quan hệ:

  * Độc giả (1) —— (N) Phiếu mượn
  * Sách (1) —— (N) Phiếu mượn (**vì không có bảng trung gian đại loại như chi tiết phiếu mượn và đề cũng không đề cập nên em giả định trường hợp 1 phiếu mượn chỉ có thể mượn 1 cuốn sách**)

---
