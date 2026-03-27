# Session 01 - Bài 2: Hệ Thống Quản Lý Đơn Hàng Thương Mại Điện Tử

## 1. Entities

Hệ thống bán hàng trực tuyến gồm các thực thể chính sau:

| Entity         | Mô tả                                        |
| -------------- | -------------------------------------------- |
| KhachHang      | Lưu thông tin khách hàng sử dụng hệ thống    |
| SanPham        | Lưu thông tin sản phẩm được bán              |
| DonHang        | Lưu thông tin đơn hàng của khách             |
| ChiTietDonHang | Lưu chi tiết các sản phẩm trong mỗi đơn hàng |
| NhanVien       | Lưu thông tin nhân viên xử lý đơn hàng       |

---

# 2. Attributes

## KhachHang

| Attribute   | Key | Mô tả             |
| ----------- | --- | ----------------- |
| **MaKhachHang** | **PK**  | Mã khách hàng     |
| HoTen       |     | Họ tên khách hàng |
| Email       |     | Email khách hàng  |
| SoDienThoai |     | Số điện thoại     |
| DiaChi      |     | Địa chỉ           |

---

## SanPham

| Attribute  | Key | Mô tả              |
| ---------- | --- | ------------------ |
| **MaSanPham**  | **PK**  | Mã sản phẩm        |
| TenSanPham |     | Tên sản phẩm       |
| Gia        |     | Giá bán            |
| MoTa       |     | Mô tả sản phẩm     |
| LoaiHang   |     | Phân loại sản phẩm |

---

## DonHang

| Attribute   | Key | Mô tả                           |
| ----------- | --- | ------------------------------- |
| **MaDonHang**   | **PK**  | Mã đơn hàng                     |
| NgayDatHang |     | Ngày khách đặt hàng             |
| TongTien    |     | Tổng tiền đơn hàng              |
| TrangThai   |     | Trạng thái đơn hàng             |
| MaKhachHang | FK  | Khóa ngoại tham chiếu KhachHang |
| MaNhanVien  | FK  | Nhân viên xử lý đơn             |

---

## ChiTietDonHang

| Attribute | Key    | Mô tả                     |
| --------- | ------ | ------------------------- |
| **MaDonHang** | **PK, FK** | Tham chiếu DonHang        |
| **MaSanPham** | **PK, FK** | Tham chiếu SanPham        |
| SoLuong   |        | Số lượng sản phẩm         |
| DonGia    |        | Đơn giá tại thời điểm mua |

Khóa chính của bảng này là **khóa kết hợp (MaDonHang, MaSanPham)**.

---

## NhanVien

| Attribute  | Key | Mô tả                 |
| ---------- | --- | --------------------- |
| **MaNhanVien** | **PK**  | Mã nhân viên          |
| HoTen      |     | Họ tên                |
| ViTri      |     | Vị trí công việc      |
| NgayVaoLam |     | Ngày bắt đầu làm việc |

---

# 3. Relationships

| Relationship                              | Entities Involved                  | Cardinality | Notes                                                                           |
| ----------------------------------------- | ---------------------------------- | ----------- | ------------------------------------------------------------------------------- |
| **KhachHang** đặt **DonHang**                     | KhachHang – DonHang                | 1 – N       | Một khách hàng có thể đặt nhiều đơn hàng                                        |
| **DonHang** chứa **SanPham**                      | DonHang – SanPham                  | N – N       | Một đơn hàng có nhiều sản phẩm và một sản phẩm có thể xuất hiện trong nhiều đơn |
| **NhanVien** xử lý **DonHang**                    | NhanVien – DonHang                 | 1 – N       | Một nhân viên có thể xử lý nhiều đơn hàng                                       |
| **ChiTietDonHang** kết nối **DonHang** và **SanPham** | ChiTietDonHang – DonHang / SanPham | 1 – N       | Bảng trung gian giải quyết quan hệ N–N                                          |

---

# 4. Primary Keys

| Entity         | Primary Key            |
| -------------- | ---------------------- |
| **KhachHang**      | MaKhachHang            |
| **SanPham**        | MaSanPham              |
| **DonHang**        | MaDonHang              |
| **NhanVien**       | MaNhanVien             |
| **ChiTietDonHang** | (MaDonHang, MaSanPham) |

---

# 5. Foreign Keys

| Table          | Foreign Key | Reference              |
| -------------- | ----------- | ---------------------- |
| DonHang        | MaKhachHang | KhachHang(MaKhachHang) |
| DonHang        | MaNhanVien  | NhanVien(MaNhanVien)   |
| ChiTietDonHang | MaDonHang   | DonHang(MaDonHang)     |
| ChiTietDonHang | MaSanPham   | SanPham(MaSanPham)     |

---

# 6. Multi-valued Attributes

Trong mô hình hiện tại **không tồn tại thuộc tính đa trị**.

---

# 7. ER Diagram

ER Diagram được thể hiện trong file:

```
docs/erd.png
```
