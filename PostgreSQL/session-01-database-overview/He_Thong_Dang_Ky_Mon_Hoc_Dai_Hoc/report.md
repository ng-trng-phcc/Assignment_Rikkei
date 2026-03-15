# Session 01 – ERD Report

## 1. Entities

Liệt kê các thực thể trong hệ thống.

| Entity | Description |
| ------ | ----------- |
|SINHVIEN|sinh viên|
|MONHOC|Môn học|
|GIANGVIEN|Giảng viên|
|LOPHOCPHAN|Lớp học phần|
|DANGKY|Đăng ký|

---

## 2. Attributes

### SINHVIEN

| Attribute | Type | Notes |
| --------- | ---- | ----- |
|**MaSV**   |**PK**    |mã sinh viên - khóa chính của bảng SINHVIEN|
|HoTen      |Attribute      |       |
|NgaySinh|Attribute|
|GioiTinh|Attribute|
|Email|Attribute|
|Khoa|Attribute|

### MONHOC

| Attribute | Type | Notes |
| --------- | ---- | ----- |
|**MaMon**           |**PK**      |mã môn học - khóa chính của MONHOC|
|TenMon           |Attribute     |       |
|SoTinChi|Attribute|
|KhoaPhuTrach|Attribute|

### GIANGVIEN

| Attribute | Type | Notes |
| --------- | ---- | ----- |
|**MaGiangVien**           |**PK**      |mã giảng viên - khóa chính của GIANGVIEN       |
|HoTen           |Attribute      |       |
|HocVi|Attribute|
|email|Attribute|
|khoa|Attribute|

### LOP_HOCPHAN

| Attribute | Type | Notes |
| --------- | ---- | ----- |
|**MaLopHocPhan**|**PK**      |mã lớp học phần - khóa chính của LOP_HOCPHAN|
|HocKy|Attribute|
|NamHoc           |Attribute      |       |
|PhongHoc|Attribute|

### DANGKY

| Attribute | Type | Notes |
| --------- | ---- | ----- |
|**MaDangKy (MaSinhVien, MaLopHocPhan)**|**PK**      | khóa chính của DANGKY - bảng trung gian       |
|MaSinhVien|**FK**      |chiếu tới SINHVIEN       |
|MaLopHocPhan|**FK**|chiếu tới LOP_HOCPHAN|
|NgayDangKy|attribute|
---

## 3. Relationships

| Relationship | Entities Involved | Cardinality | Notes |
| ------------ | ----------------- | ----------- | ----- |
|**MONHOC** có **LOP_HOCPHAN**|MONHOC - LOP_HOCPHAN|1 - N|Một môn học có thể mở nhiều lớp học phần trong các học kỳ khác nhau|
|**GIANGVIEN** dạy **LOP_HOCPHAN**|GIANGVIEN - LOP_HOCPHAN|1 - N|Một giảng viên có thể dạy nhiều lớp học phần|
|**SINHVIEN** tham gia **LOP_HOCPHAN**|SINHVIEN - LOP_HOCPHAN|N - N|Sinh viên có thể đăng ký nhiều lớp học phần và mỗi lớp có nhiều sinh viên|
|**DANGKY** kết nối **SINHVIEN** và **LOP_HOCPHAN**|DANGKY - SINHVIEN/LOP_HOCPHAN|1 - N (tới mỗi bảng)|DANGKY là bảng trung gian để giải quyết quan hệ N–N|

> **Lưu ý:**
> + Nếu tuân thủ 100% yêu cầu thì ở mục này chỉ có 1 quan hệ duy nhất là DANGKY - SINHVIEN/LOP_HOCPHAN (N - N) vì trong danh sách các table được cung cấp không có khóa ngoại ở **SINHVIEN, MONHOC, GIANGVIEN, LOP_HOCPHAN** vậy nên để cụ thể và đơn giản em sẽ tự giả định mối quan hệ của 3 bảng trên bằng 1 - N cho đơn giản và dễ vẽ ERD.
---

## 4. Primary Keys

| Entity | Primary Key |
| ------ | ----------- |
|**SINHVIEN**|**MaSinhVien**|
|**MONHOC**        |**MaMon**|
|**GIANGVIEN**|**MaGiangVien**|
|**LOP_HOCPHAN**|**MaLopHocPhan**|
|**DANGKY**|(**MaSinhVien, MaLopHocPhan)**|

---

## 5. Foreign Keys

| Table | Foreign Key | Reference |
| ----- | ----------- | --------- |
|**DANGKY**       | MaSinhVien            |SINHVIEN(MaSinhVien)           |
|**DANGKY**       | MaLopHocPhan            |LOP_HOCPHAN(MaLopHocPHan)           |

---

## 6. Multi-valued Attributes

+ Không có thuộc tính đa trị nào cả.

---

## 7. ERD (Entity Relation Diagram)

![ERD](docs/erd.png)
