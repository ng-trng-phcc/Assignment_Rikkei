# Đề bài 02 (md02_ss03) - [Luyện tập] Quản lý điểm học viên

## Mô tả

Viết chương trình Java Console quản lý việc nhập điểm số của các học viên và cung cấp một số chức năng thống kê cơ bản:

Hiển thị menu lựa chọn với 3 chức năng chính

******* MENU NHẬP ĐIỂM *******
1. Nhập điểm học viên
2. Hiển thị thống kê
3. Thoát
   Lựa chọn của bạn:

---

### Chức năng 1: Nhập điểm học viên

- Cho phép nhập lần lượt các điểm số từ bàn phím
- Nếu nhập -1 thì kết thúc quá trình nhập
- Nếu nhập sai (ngoài khoảng 0-10, trừ -1), in cảnh báo và yêu cầu nhập lại
- Mỗi điểm nhập xong, in ra xếp loại học lực:

| Khoảng điểm | Xếp loại |
|-------------|------------|
| 0 - <5      | Yếu        |
| 5 - <7      | Trung Bình |
| 7 - <8      | Khá        |
| 8 - <9      | Giỏi       |
| 9 - 10      | Xuất sắc   |

- Thực hiện tính:
    - Tổng số học viên đã nhập
    - Tổng điểm
    - Điểm cao nhất
    - Điểm thấp nhất

### Chức năng 2: Hiển thị thống kê

- Nếu chưa có học viên nào, hiển thị thông báo “Chưa có dữ liệu”
- Ngược lại, in ra các thông tin sau:
    - Số học viên đã nhập
    - Điểm trung bình
    - Điểm cao nhất
    - Điểm thấp nhất

### Chức năng 3: Thoát chương trình

- In thông báo kết thúc và thoát chương trình bằng System.exit(0)