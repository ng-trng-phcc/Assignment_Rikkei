# Hệ thống Bán hàng

---

## 1. Thực thể và thuộc tính

### 1.1 Khách hàng

| Thuộc tính  | Ghi chú         |
| ----------- | --------------- |
| SoDienThoai | **Primary Key** |
| HoTen       |                 |
| Email       |                 |
| DiaChi      |                 |

**Chú thích:**
- Trong thực thể này không có thuộc tính nào đại loại **MaKhachHang**.
- Thực tế cũng có nhiều cửa hàng lưu thông tin khách hàng bằng SDT.
- Luật mới của Việt Nam quy định **1 CCCD** chỉ có **1 SDT**.

$\Rightarrow$ **SDT** làm khóa chính là hợp lý.

---

### 1.2 Sản phẩm

| Thuộc tính  | Ghi chú         |
| ----------- | --------------- |
| MaSanPham   | **Primary Key** |
| TenSanPham  |                 |
| Gia         |                 |
| LoaiSanPham |                 |

---

### 1.3 Đơn hàng

| Thuộc tính  | Ghi chú                     |
| ----------- | --------------------------- |
| MaDon       | **Primary Key**             |
| NgayTao     |                             |
| TongTien    |                             |
| SoDienThoai | **Foreign Key → KhachHang** |

---

### 1.4 Chi tiết đơn hàng

| Thuộc tính         | Ghi chú                          |
| ------------------ | -------------------------------- |
| MaDon              | **Foreign Key → DonHang**        |
| MaSanPham          | **Foreign Key → SanPham**        |
| SoLuong            |                                  |
| DonGia             |                                  |
| (MaDon, MaSanPham) | **Primary Key (Khóa chính kép)** |

---

# 2. Mối quan hệ giữa các thực thể

| Thực thể A | Thực thể B        | Quan hệ      | Kiểu                          |
| ---------- | ----------------- | ------------ | ----------------------------- |
| Khách hàng | Đơn hàng          | Đặt hàng     | 1 – N                         |
| Đơn hàng   | Chi tiết đơn hàng | Gồm          | 1 – N                         |
| Sản phẩm   | Chi tiết đơn hàng | Thuộc        | 1 – N                         |
| Đơn hàng   | Sản phẩm          | Mua sản phẩm | N – N (qua Chi tiết đơn hàng) |

---

# 3. Tóm tắt khóa

| Bảng           | Primary Key       | Foreign Key      |
| -------------- | ----------------- | ---------------- |
| KhachHang      | SoDienThoai       |                  |
| SanPham        | MaSanPham         |                  |
| DonHang        | MaDon             | SoDienThoai      |
| ChiTietDonHang | MaDon + MaSanPham | MaDon, MaSanPham |

