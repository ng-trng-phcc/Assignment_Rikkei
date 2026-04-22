# Đề bài 04 (md02_ss02) - [ Giỏi ] Kiểm tra tính hợp lệ của tam giác

## Mô tả

Viết chương trình Java thực hiện các chức năng sau:

- Nhập ba số nguyên dương từ người dùng, tương ứng với ba cạnh của một tam giác
- Kiểm tra xem ba cạnh nhập vào có tạo thành một tam giác hợp lệ không
    - Quy tắc kiểm tra tam giác: Tổng hai cạnh bất kỳ phải lớn hơn cạnh còn lại
    - Nếu không hợp lệ, hiển thị thông báo: "Ba cạnh không tạo thành tam giác."
- Nếu ba cạnh hợp lệ:
    - Phân loại tam giác:
        - Tam giác đều: Ba cạnh bằng nhau
        - Tam giác cân: Hai cạnh bằng nhau
        - Tam giác vuông: Bình phương một cạnh bằng tổng bình phương hai cạnh còn lại
        - Tam giác thường: Không thuộc các loại trên
    - Hiển thị thông tin chi tiết về loại tam giác

### Yêu cầu:

**Kiểm tra dữ liệu đầu vào:**
- Sử dụng câu lệnh điều kiện để xác định tính hợp lệ của tam giác. Khi tổng 2 cạnh bất kì lớn hơn cạnh thứ 3 thì đó là một tam giác, ngược lại thì thông báo "Ba cạnh không tạo thành tam giác."

**Phân loại tam giác:**
- Sử dụng if-else để xác định loại tam giác
- Thứ tự kiểm tra:
    1. Tam giác đều
    2. Tam giác cân
    3. Tam giác vuông
    4. Tam giác thường

**Hiển thị kết quả:**
- Hiển thị loại tam giác
- Hiển thị thông báo lỗi rõ ràng nếu không phải tam giác