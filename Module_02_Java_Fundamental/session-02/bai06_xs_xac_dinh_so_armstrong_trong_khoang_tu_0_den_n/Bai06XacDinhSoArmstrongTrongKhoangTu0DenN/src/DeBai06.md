# Đề bài 06 (md02_ss02) - [ Xuất sắc ] Xác định số Armstrong trong khoảng từ 0 đến N

## Mô tả

Một số nguyên dương được gọi là số Armstrong (còn gọi là số Narcissistic) khi số có giá trị bằng tổng lũy thừa của các chữ số trong số đó. Ví dụ số Armstrong là: 0, 1, 2, 3, 153, 370, 407, 1634, 8208,...

Ví dụ về số Armstrong:
- 153: 1³ + 5³ + 3³ = 153 → 153 là số Armstrong
- 9474: 9⁴ + 4⁴ + 7⁴ + 4⁴ = 9474 → 9474 là số Armstrong

Ví dụ về số không phải là Armstrong:
- 123: 1³ + 2³ + 3³ = 1 + 8 + 27 = 36 → 123 không phải là số Armstrong

Viết chương trình Java để kiểm tra và in tất cả các số Armstrong từ 0 đến N, trong đó N là số nguyên dương nhập từ bàn phím.

### Yêu cầu:

**Đầu vào:**
- Một số nguyên dương N được nhập từ bàn phím.
- Nếu người dùng không nhập vào số nguyên dương thì hiển thị thông báo "Số nhập vào không hợp lệ" và yêu cầu người dùng nhập lại đến khi chính xác thì ngưng

**Xử lý:**
- Sử dụng vòng lặp để duyệt qua các số từ 0 đến N.
- Với mỗi số, tính số chữ số của nó (k).
- Tính tổng lũy thừa bậc k của từng chữ số.
- Nếu tổng này bằng chính số đó, thì số đó là số Armstrong.

**Đầu ra:**
- In danh sách các số Armstrong trong khoảng từ 0 đến N.