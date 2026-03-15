# Session 01 – Bài 3: Hệ Thống Quản Lý Đặt Phòng Khách Sạn

# 1. Entities

Hệ thống đặt phòng khách sạn gồm các thực thể chính sau:

| Entity          | Mô tả                                    |
| --------------- | ---------------------------------------- |
| KhachSan        | Lưu thông tin khách sạn                  |
| Phong           | Lưu thông tin các phòng trong khách sạn  |
| KhachHang       | Lưu thông tin khách hàng                 |
| DatPhong        | Lưu thông tin booking                    |
| ChiTietDatPhong | Dùng để giải quyết câu optional (chi tiết bên dưới) |
| ThanhToan       | Lưu thông tin thanh toán                 |
| DanhGia         | Lưu đánh giá của khách hàng              |

---

# 2. Attributes

## KhachSan

| Attribute   | Key | Mô tả         |
| ----------- | --- | ------------- |
| **MaKhachSan**  | **PK**  | Mã khách sạn  |
| TenKhachSan |     | Tên khách sạn |
| DiaChi      |     | Địa chỉ       |
| SoSao       |     | Số sao        |
| MoTa        |     | Mô tả         |
| NguoiQuanLy |     | Người quản lý |

---

## Phong

| Attribute  | Key | Mô tả               |
| ---------- | --- | ------------------- |
| **MaPhong**    | **PK**  | Mã phòng            |
| LoaiPhong  |     | Loại phòng          |
| GiaMoiDem  |     | Giá mỗi đêm         |
| TinhTrang  |     | Tình trạng phòng    |
| SucChua    |     | Sức chứa            |
| **MaKhachSan** | **FK**  | Thuộc khách sạn nào |

---

## KhachHang

| Attribute   | Key | Mô tả         |
| ----------- | --- | ------------- |
| **MaKhachHang** | **PK**  | Mã khách hàng |
| HoTen       |     | Họ tên        |
| Email       |     | Email         |
| SoDienThoai |     | Số điện thoại |
| QuocTich    |     | Quốc tịch     |

---

## DatPhong

| Attribute   | Key | Mô tả              |
| ----------- | --- | ------------------ |
| **MaDatPhong**  | **PK**  | Mã booking         |
| NgayDat     |     | Ngày đặt           |
| NgayNhan    |     | Ngày nhận phòng    |
| NgayTra     |     | Ngày trả phòng     |
| TongTien    |     | Tổng tiền          |
| TrangThai   |     | Trạng thái booking |
| **MaKhachHang** | **FK**  | Khách tạo booking  |

---

## ChiTietDatPhong

| Attribute  | Key    | Mô tả                 |
| ---------- | ------ | --------------------- |
| **MaDatPhong** | **PK, FK** | Tham chiếu DatPhong   |
| **MaPhong**    | **PK, FK** | Tham chiếu Phong      |
| SoDem      |        | Số đêm đặt phòng      |
| DonGia     |        | Giá tại thời điểm đặt |

Khóa chính của bảng là **(MaDatPhong, MaPhong)**.

---

## ThanhToan

| Attribute     | Key | Mô tả                  |
| ------------- | --- | ---------------------- |
| **MaThanhToan**   | **PK**  | Mã thanh toán          |
| PhuongThuc    |     | Phương thức thanh toán |
| NgayThanhToan |     | Ngày thanh toán        |
| SoTien        |     | Số tiền                |
| TrangThai     |     | Trạng thái thanh toán  |
| **MaDatPhong**    | **FK**  | Tham chiếu booking     |

---

## DanhGia

| Attribute   | Key | Mô tả                   |
| ----------- | --- | ----------------------- |
| **MaDanhGia**   | **PK**  | Mã đánh giá             |
| DiemSo      |     | Điểm đánh giá           |
| BinhLuan    |     | Nội dung bình luận      |
| NgayDang    |     | Ngày đăng               |
| **MaKhachHang** | **FK**  | Người viết đánh giá     |
| **MaKhachSan**  | **FK**  | Khách sạn được đánh giá |

---

# 3. Relationships

| Relationship                              | Entities Involved                  | Cardinality | Notes                                |
| ----------------------------------------- | ---------------------------------- | ----------- | ------------------------------------ |
| **KhachSan** có **Phong**                         | KhachSan – Phong                   | 1 – N       | Một khách sạn có nhiều phòng         |
| **KhachHang** tạo **DatPhong**                    | KhachHang – DatPhong               | 1 – N       | Một khách có thể tạo nhiều booking   |
| **DatPhong** chứa **Phong**                       | DatPhong – Phong                   | N – N       | Một booking có thể đặt nhiều phòng   |
| **ChiTietDatPhong** kết nối **DatPhong** va **Phong** | ChiTietDatPhong – DatPhong / Phong | 1 – N       | Bảng trung gian cho quan hệ N–N      |
| **DatPhong** có **ThanhToan**                     | DatPhong – ThanhToan               | 1 – 1       | Một booking có một thanh toán        |
| **KhachHang** viết **DanhGia**                    | KhachHang – DanhGia                | 1 – N       | Một khách có thể viết nhiều đánh giá |
| **KhachSan** được **DanhGia**                     | KhachSan – DanhGia                 | 1 – N       | Một khách sạn có nhiều đánh giá      |

---

# 4. Primary Keys

| Entity          | Primary Key           |
| --------------- | --------------------- |
| KhachSan        | MaKhachSan            |
| Phong           | MaPhong               |
| KhachHang       | MaKhachHang           |
| DatPhong        | MaDatPhong            |
| ThanhToan       | MaThanhToan           |
| DanhGia         | MaDanhGia             |
| ChiTietDatPhong | (MaDatPhong, MaPhong) |

---

# 5. Foreign Keys

| Table           | Foreign Key | Reference              |
| --------------- | ----------- | ---------------------- |
| Phong           | MaKhachSan  | **KhachSan**(MaKhachSan)   |
| DatPhong        | MaKhachHang | **KhachHang**(MaKhachHang) |
| ChiTietDatPhong | MaDatPhong  | **DatPhong**(MaDatPhong)   |
| ChiTietDatPhong | MaPhong     | **Phong**(MaPhong)         |
| ThanhToan       | MaDatPhong  | **DatPhong**(MaDatPhong)   |
| DanhGia         | MaKhachHang | **KhachHang**(MaKhachHang) |
| DanhGia         | MaKhachSan  | **KhachSan**(MaKhachSan)   |

---

# 6. Multi-valued Attributes

Trong mô hình này **không tồn tại thuộc tính đa trị**.



---

# 7. Business Rule (Optional)

Một phòng **không thể được đặt trùng thời gian**.

+ Trường hợp valid:
    + Booking001 đặt P01 vào 1/1-2/1. Vậy nếu Booking002 cũng đặt P01 đó sau 2/1 (giả sử 3/1-5/1) $\Rightarrow$ duyệt còn ngược lại thì hệ thống phải báo lỗi.

#### Logic ràng buộc:

+ Vì trong bảng **DatPhong** không có **MaPhong** (N-N). Điều này nghĩa là ta không biết được 2 **MaDatPhong** khác nhau có đặt cùng 1 phòng không, vậy nên ta cần 1 bảng để chỉ rõ điều đó (**ChiTietDatPhong**).
+ Vậy để viết logic một phòng **không thể được đặt trùng thời gian** ta cần xét ít nhất 2 bảng (**DatPhong** và **ChiTietDatPhong**).

#### Quy trình kiểm tra:
1.  Cụ thể ở **ChiTietDatPhong** ta cần kiểm tra xem có tồn tại 2 **MaPhong** trùng nhau hay không?
2. Nếu có thì sử dụng 2 **MaDatPhong** của 2 record đó và truy ngược lại bảng **DatPhong** và xét xem:
    ```
    NgayTra (của MaDatPhong trước) có < NgayNhan (MaDatPhongSau) hay không?
    ```
    + Ở ví dụ trên ta thấy **Booking001** và **Booking002** đặt cùng 1 phòng **P01**, vậy để pass ràng buộc trên thì **NgayTra** của **Booking001** bắt buộc phải < **NgayNhan** của **Booking002**.
3. Nhưng bài này không có **created_at** hoặc đại loại **Thoi_Gian_Xac_Nhan_Thanh_Toan** vậy nên ta không thực sự xác định được đâu là **MaDatPhong** trước đâu là **MaDatPhong** sau,

> nên sẽ có những rule sau để phát hiện overlap:
>    + rule chung: **NgayNhan < NgayTra**
>    + Điều kiện overlap:
>        + (**NgayNhan1 < NgayTra2**) AND (**NgayTra1 > NgayNhan2**) (cả 2 cùng TRUE thì overlap)
>        + Ở ví dụ trên ta thấy:
>           + NgayNhan1 **(1/1)** <  NgayTra2 **(5/1)** return **TRUE**
>           + NgayTra1 **(2/1)** > NgayNhan2 **(3/1)** return **FALSE**
>       + Nên không overlap $\Rightarrow$ duyệt.

---

# 8. ER Diagram

Sơ đồ ERD được lưu tại:

```
docs/erd.png
```
