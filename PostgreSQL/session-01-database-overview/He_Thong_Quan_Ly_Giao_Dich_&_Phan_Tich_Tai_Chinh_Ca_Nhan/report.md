# Session 01 – Bài 5: Hệ Thống Quản Lý Giao Dịch & Phân Tích Tài Chính Cá Nhân

---

# 1. Entities

| Entity               | Mô tả                               |
| -------------------- | ----------------------------------- |
| User                 | Lưu thông tin người dùng            |
| Wallet               | Lưu các ví tài chính của người dùng |
| Category             | Phân loại giao dịch                 |
| Transaction          | Lưu các giao dịch thu chi           |
| Budget               | Lưu ngân sách theo tháng            |
| Goal                 | Lưu mục tiêu tiết kiệm              |
| RecurringTransaction | Lưu các giao dịch định kỳ           |
|UserCategory| Kết nối giữa User và Category|

---

# 2. Attributes

## User

| Attribute       | Key    | Mô tả              |
| --------------- | ------ | ------------------ |
| **MaNguoiDung** | **PK** | Mã người dùng      |
| HoTen           |        | Họ tên             |
| Email           |        | Email              |
| NgayTaoTaiKhoan |        | Ngày tạo tài khoản |

---

## Wallet

| Attribute       | Key    | Mô tả         |
| --------------- | ------ | ------------- |
| **MaVi**        | **PK** | Mã ví         |
| TenVi           |        | Tên ví        |
| SoDuBanDau      |        | Số dư ban đầu |
| LoaiTienTe      |        | Loại tiền tệ  |
| **MaNguoiDung** | **FK** | Chủ sở hữu ví |

---

## Category

| Attribute     | Key    | Mô tả            |
| ------------- | ------ | ---------------- |
| **MaDanhMuc** | **PK** | Mã danh mục      |
| TenDanhMuc    |        | Tên danh mục     |
| Loai          |        | Loại (Thu / Chi) |

---

## Transaction

| Attribute       | Key    | Mô tả              |
| --------------- | ------ | ------------------ |
| **MaGiaoDich**  | **PK** | Mã giao dịch       |
| NgayGiaoDich    |        | Ngày giao dịch     |
| SoTien          |        | Số tiền            |
| MoTa            |        | Mô tả              |
| Loai            |        | Thu / Chi (đặt trong **CHECK**)         |
| **MaVi**        | **FK** | Ví sử dụng         |
| **MaDanhMuc**   | **FK** | Danh mục giao dịch |
| **MaNguoiDung** | **FK** | Người thực hiện    |

---

## Budget

| Attribute       | Key    | Mô tả             |
| --------------- | ------ | ----------------- |
| **MaNganSach**  | **PK** | Mã ngân sách      |
| Thang           |        | Tháng             |
| Nam             |        | Năm               |
| GioiHanChiTieu  |        | Giới hạn chi tiêu |
| **MaNguoiDung** | **FK** | Người dùng        |
| **MaDanhMuc**   | **FK** | Danh mục áp dụng  |

---

## Goal

| Attribute       | Key    | Mô tả        |
| --------------- | ------ | ------------ |
| **MaMucTieu**   | **PK** | Mã mục tiêu  |
| TenMucTieu      |        | Tên mục tiêu |
| SoTienCan       |        | Số tiền cần  |
| HanDat          |        | Hạn đạt      |
| **MaNguoiDung** | **FK** | Chủ mục tiêu |

---

## RecurringTransaction (Optional)

| Attribute            | Key    | Mô tả          |
| -------------------- | ------ | -------------- |
| **MaGiaoDichLapLai** | **PK** | Mã giao dịch   |
| TenGiaoDich          |        | Tên giao dịch  |
| SoTien               |        | Số tiền        |
| ChuKy                |        | Chu kỳ (tháng) |
| **MaVi**             | **FK** | Ví sử dụng     |
| **MaDanhMuc**        | **FK** | Danh mục       |
| **MaNguoiDung**      | **FK** | Người dùng     |

---
## UserCategory
| Attribute          | Key    | Mô tả       |
| ------------------ | ------ | ----------- |
| **MaUserCategory** | **PK** | Mã liên kết |
| **MaNguoiDung**    | **FK** | Người dùng  |
| **MaDanhMuc**      | **FK** | Danh mục    |

---

# 3. Relationships

| Relationship                        | Entities Involved              | Cardinality | Notes                                  |
| ----------------------------------- | ------------------------------ | ----------- | -------------------------------------- |
| **User** có **Wallet**              | **User** – **Wallet**          | 1 – N       | Một người dùng có nhiều ví             |
| **Wallet** có **Transaction**       | **Wallet** – **Transaction**   | 1 – N       | Một ví có nhiều giao dịch              |
| **Category** có **Transaction**     | **Category** – **Transaction** | 1 – N       | Một danh mục có nhiều giao dịch        |
| **User** có **Budget**              | **User** – **Budget**          | 1 – N       | Một người dùng có nhiều ngân sách      |
| **User** có **Goal**                | **User** – **Goal**            | 1 – N       | Một người dùng có nhiều mục tiêu       |
| **Category** áp dụng cho **Budget** | **Category** – **Budget**      | 1 – N       | Một danh mục có thể có nhiều ngân sách |
| **User** sử dụng **Category** | **User – Category** | N – N       | Được triển khai thông qua bảng **UserCategory** |


#### Lưu ý:
+ **RecurringTransaction** không được liệt kê trong bảng **Relationships** này và cũng không được thể hiện trực tiếp trong **ERD** vì nó không tạo ra quan hệ dữ liệu trực tiếp với **Transaction**.
+ Trong thiết kế hệ thống này, **RecurringTransaction** là giải pháp giúp tối ưu hiệu năng hệ thống cho những transaction có tính chu kỳ (lặp đi lặp lại) chứ không nằm trong thiết kế hệ thống tĩnh ban đầu.
+ Và vì bảng **Transaction** không chứa khóa ngoại tham chiếu tới **RecurringTransaction**, nên quan hệ này không được mô hình hóa trong **ERD** và cũng không xuất hiện trong bảng **Relationships**.
---

# 4. Primary Keys

| Entity               | Primary Key      |
| -------------------- | ---------------- |
| User                 | MaNguoiDung      |
| Wallet               | MaVi             |
| Category             | MaDanhMuc        |
| Transaction          | MaGiaoDich       |
| Budget               | MaNganSach       |
| Goal                 | MaMucTieu        |
| RecurringTransaction | MaGiaoDichLapLai |

---

# 5. Foreign Keys

| Table                | Foreign Key | Reference               |
| -------------------- | ----------- | ----------------------- |
| Wallet               | MaNguoiDung | **User**(MaNguoiDung)   |
| Transaction          | MaVi        | **Wallet**(MaVi)        |
| Transaction          | MaDanhMuc   | **Category**(MaDanhMuc) |
| Transaction          | MaNguoiDung | **User**(MaNguoiDung)   |
| Budget               | MaNguoiDung | **User**(MaNguoiDung)   |
| Budget               | MaDanhMuc   | **Category**(MaDanhMuc) |
| Goal                 | MaNguoiDung | **User**(MaNguoiDung)   |
| RecurringTransaction | MaNguoiDung | **User**(MaNguoiDung)   |
| RecurringTransaction | MaVi        | **Wallet**(MaVi)        |
| RecurringTransaction | MaDanhMuc   | **Category**(MaDanhMuc) |
| UserCategory | MaNguoiDung | **User**(MaNguoiDung)           |
| UserCategory | MaDanhMuc   | **Category**(MaDanhMuc)         |


---

# 6. Normalization

Cơ sở dữ liệu được thiết kế đạt **Third Normal Form (3NF)**:

### 1NF

* Mỗi bảng có **primary key**
* Không có thuộc tính lặp

### 2NF

* Tất cả thuộc tính phụ thuộc hoàn toàn vào **primary key**

### 3NF

* Không có **phụ thuộc bắc cầu**
* Các thông tin được tách thành các bảng độc lập

---

# 7. Data Integrity

Các ràng buộc được áp dụng:

* **Primary Key** đảm bảo mỗi bản ghi là duy nhất
* **Foreign Key** đảm bảo tính toàn vẹn tham chiếu
* **Transaction amount** phải > 0
* **Budget limit** phải ≥ 0
* **Goal amount** phải > 0

---

# 8. System Logic

### Ghi nhận giao dịch

1 User
→ nhiều Wallet
→ mỗi Wallet chứa nhiều Transaction

Transaction sẽ liên kết với:

* Wallet
* Category
* User

---

### Quản lý ngân sách

User có thể đặt:

* Budget theo **Category**
* Budget theo **tháng**

Hệ thống có thể so sánh:

```
Total Transaction (Category, Month)
vs
Budget Limit
```

để cảnh báo vượt chi tiêu.

#### Ví dụ:
+ Giả sử người dùng đặt ra chỉ tiêu là tháng 6 chỉ tiêu tối đa 3 triệu dành cho việc ăn uống thì  bảng **Budget** sẽ có data như sau:

| MaNganSach | MaNguoiDung | MaDanhMuc   | Thang | Nam  | GioiHanChiTieu |
| ---------- | ----------- | ----------- | ----- | ---- | -------------- |
| 1          | 101         | 3 (Ăn uống) | 6     | 2025 | 3,000,000      |

+ Cứ sau mỗi transaction thì hệ thống sẽ ghi lại data của các transaction đó vào **Transaction**, giả sử:

| MaGiaoDich | MaNguoiDung | MaDanhMuc | SoTien    | NgayGiaoDich |
| ---------- | ----------- | --------- | --------- | ------------ |
| 1          | 101         | 3         | 1,200,000 | 2025-06-05   |
| 2          | 101         | 3         | 1,000,000 | 2025-06-10   |
| 3          | 101         | 3         | 1,300,000 | 2025-06-18   |

+ Lúc này khi thống kê **Total Transaction (Category, Month)** sẽ được tính  đại loại như sau:

```sql
SELECT Sum(*) as Total Transaction
FROM Transaction
WHERE MaNguoiDung = '101' AND MaDanhMuc = '3' AND MONTH(NgayGiaoDich) = '6'
```
+ Không cần **Group by** nếu chỉ thống kê cho 1 user. Sau khi chạy query xong thì hệ thống sẽ **return Total transaction** = 3,500,000.
+ Vì 3,000,000 (GioiHanChiTieu) - 3,500,000 (Total transaction) = -500,000 nên hệ thống sẽ báo tháng 6 bạn đã chi vượt chỉ tiêu đề ra 500,000.
---

### Quản lý mục tiêu tiết kiệm

User tạo **Goal**

Ví dụ:

```
Goal: Mua xe
Amount: 200,000,000
Deadline: 2027
```

Hệ thống có thể tính:

```
Savings Progress
= Tổng thu - Tổng chi
```

---

# 9. System Extension (Optional)

## MonthlyReport (Summary Table)

Bảng tổng hợp phục vụ **Dashboard / BI**

| Attribute       | Key    | Mô tả      |
| --------------- | ------ | ---------- |
| **MaBaoCao**    | **PK** | Mã báo cáo |
| Thang           |        | Tháng      |
| Nam             |        | Năm        |
| TongThu         |        | Tổng thu   |
| TongChi         |        | Tổng chi   |
| **MaNguoiDung** | **FK** | Người dùng |

---

### Cách tạo dữ liệu báo cáo

Ví dụ truy vấn:

```sql
SELECT  MaNguoiDung,
        MONTH(NgayGiaoDich) AS Thang,
        YEAR(NgayGiaoDich) AS Nam,
        SUM(CASE WHEN Loai='Thu' THEN SoTien ELSE 0 END) AS TongThu,
        SUM(CASE WHEN Loai='Chi' THEN SoTien ELSE 0 END) AS TongChi
FROM Transaction
GROUP BY MaNguoiDung, YEAR(NgayGiaoDich), MONTH(NgayGiaoDich);
```

---

### Ứng dụng cho Dashboard

Dữ liệu có thể dùng để vẽ:

* Monthly Spending Chart
* Income vs Expense
* Category Spending Analysis
* Saving Progress
* v.v

---
