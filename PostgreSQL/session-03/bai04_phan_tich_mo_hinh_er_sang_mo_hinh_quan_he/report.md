# Hệ thống Quản lý Khám bệnh

## 1. Các bảng quan hệ và thuộc tính

### 1.1 Bệnh nhân

| Thuộc tính  | Ghi chú         |
| ----------- | --------------- |
| MaBenhNhan  | **Primary Key** |
| HoTen       |                 |
| NgaySinh    |                 |
| GioiTinh    |                 |
| SoDienThoai |                 |
| DiaChi      |                 |

---

### 1.2 Bác sĩ

| Thuộc tính  | Ghi chú                |
| ----------- | ---------------------- |
| MaBacSi     | **Primary Key**        |
| HoTen       |                        |
| ChuyenKhoa  |                        |
| SoDienThoai |                        |
| MaKhoa      | **Foreign Key → Khoa** |

---

### 1.3 Khoa

| Thuộc tính | Ghi chú         |
| ---------- | --------------- |
| MaKhoa     | **Primary Key** |
| TenKhoa    |                 |
| DienThoai  |                 |

---

### 1.4 Hồ sơ khám bệnh

| Thuộc tính | Ghi chú                    |
| ---------- | -------------------------- |
| MaHoSo     | **Primary Key**            |
| MaBenhNhan | **Foreign Key → BenhNhan** |
| MaBacSi    | **Foreign Key → BacSi**    |
| NgayKham   |                            |
| ChanDoan   |                            |
| DonThuoc   |                            |

---

# 2. Mối quan hệ giữa các bảng

| Thực thể A | Thực thể B | Quan hệ   | Kiểu                   |
| ---------- | ---------- | --------- | ---------------------- |
| Khoa       | Bác sĩ     | Quản lý   | 1 – N                  |
| Bệnh nhân  | Hồ sơ khám | Có        | 1 – N                  |
| Bác sĩ     | Hồ sơ khám | Lập hồ sơ | 1 – N                  |
| Bệnh nhân  | Bác sĩ     | Khám bệnh | N – N (qua Hồ sơ khám) |

---

# 3. Biểu diễn quan hệ 1-N và N-N

## Quan hệ 1 – N
> Giải pháp: đặt **khóa ngoại** ở phía **N**

| Quan hệ           | Cách biểu diễn          |
| ----------------- | ----------------------- |
| Khoa – Bác sĩ     | **MaKhoa** trong bảng **BacSi** |
| Bệnh nhân – Hồ sơ | **MaBenhNhan** trong **HoSo**   |
| Bác sĩ – Hồ sơ    | **MaBacSi** trong **HoSo**      |

---

## Quan hệ N – N
> Giải pháp: **tạo bảng trung gian**

| Bệnh nhân | Hồ sơ khám | Bác sĩ |
| --------- | ---------- | ------ |
| 1         | N          | 1      |

→ **Hồ sơ khám bệnh** chính là **bảng trung gian** cho quan hệ N–N giữa **Bệnh nhân** và **Bác sĩ**.
