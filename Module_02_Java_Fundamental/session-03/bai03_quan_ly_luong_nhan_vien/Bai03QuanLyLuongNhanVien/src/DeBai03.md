# Đề bài luyện tập 03 (md02_ss03) - [ Luyện tập ] Quản lý lương nhân viên

## Mô tả

Viết chương trình Java Console quản lý lương nhân viên:

Hiển thị menu lựa chọn với 4 chức năng chính

---

### Chức năng 1: Nhập lương nhân viên

- Cho phép nhập lần lượt các lương nhân viên từ bàn phím
- Nếu nhập -1 thì kết thúc quá trình nhập
- Lương phải có giá trị từ 0 đến 500 triệu
- Nhập hợp lệ, phân loại lương nhân viên:

| Khoảng lương | Phân loại |
|--------------|------------|
| Dưới 5 triệu | Thu nhập thấp |
| 5 - 15 triệu | Thu nhập trung bình |
| 15 - 50 triệu | Thu nhập khá |
| Trên 50 triệu | Thu nhập cao |

- Thực hiện tính:
    - Tổng nhân viên
    - Tổng lương
    - Lương cao nhất
    - Lương thấp nhất

### Chức năng 2: Hiển thị thống kê

- Nếu chưa có nhân viên nào, hiển thị thông báo “Chưa có dữ liệu”
- Ngược lại, in ra các thông tin sau:
    - Số nhân viên đã nhập
    - Lương trung bình
    - Lương cao nhất
    - Lương thấp nhất
    - Tổng tiền lương

### Chức năng 3: Tính tổng số tiền thưởng cho nhân viên

Chính sách thưởng cho nhân viên theo lương:

| Khoảng lương | Tỷ lệ thưởng |
|--------------|---------------|
| 0 - 5 triệu | 5% |
| 5 - 15 triệu | 10% |
| 15 - 50 triệu | 15% |
| 50 - 100 triệu | 20% |
| > 100 triệu | 25% |

- Hiển thị tổng số tiền thưởng cho nhân viên

### Chức năng 4: Thoát chương trình

- In thông báo kết thúc và thoát chương trình bằng System.exit(0)