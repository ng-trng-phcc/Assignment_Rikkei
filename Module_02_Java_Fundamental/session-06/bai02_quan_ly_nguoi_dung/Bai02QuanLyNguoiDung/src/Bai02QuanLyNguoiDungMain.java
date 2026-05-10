import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Bai02QuanLyNguoiDungMain {
    private static String fullName = "";
    private static String email = "";
    private static String phone = "";
    private static String password = "";
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        int choice;

        do {
            displayMenu();
            System.out.print("Lựa chọn của bạn: ");
            choice = scanner.nextInt();
            scanner.nextLine(); // Xóa bộ nhớ đệm

            switch (choice) {
                case 1:
                    inputUserInfo();
                    break;
                case 2:
                    normalizeName();
                    break;
                case 3:
                    validateEmail();
                    break;
                case 4:
                    validatePhone();
                    break;
                case 5:
                    validatePassword();
                    break;
                case 6:
                    System.out.println("Đã thoát chương trình !!");
                    break;
                default:
                    System.out.println("Lựa chọn không hợp lệ! Vui lòng chọn từ 1 đến 6.");
            }
            System.out.println();
        } while (choice != 6);
    }

    // Hiển thị menu
    private static void displayMenu() {
        System.out.println("**************** QUẢN LÝ NGƯỜI DÙNG ****************");
        System.out.println("1. Nhập thông tin người dùng");
        System.out.println("2. Chuẩn hóa họ tên");
        System.out.println("3. Kiểm tra email hợp lệ");
        System.out.println("4. Kiểm tra số điện thoại hợp lệ");
        System.out.println("5. Kiểm tra mật khẩu hợp lệ");
        System.out.println("6. Thoát");
        System.out.println("*****************************************************");
    }

    // 1. Nhập thông tin người dùng
    private static void inputUserInfo() {
        System.out.println("\n===== NHẬP THÔNG TIN NGƯỜI DÙNG =====");

        System.out.print("Nhập họ và tên: ");
        fullName = scanner.nextLine();

        System.out.print("Nhập email: ");
        email = scanner.nextLine();

        System.out.print("Nhập số điện thoại: ");
        phone = scanner.nextLine();

        System.out.print("Nhập mật khẩu: ");
        password = scanner.nextLine();

        System.out.println("Đã nhập thông tin thành công!");
    }

    // 2. Chuẩn hóa họ tên
    private static void normalizeName() {
        if (fullName.isEmpty()) {
            System.err.println("Chưa có thông tin họ tên! Vui lòng nhập thông tin người dùng trước.");
            return;
        }

        String normalized = fullName.trim(); // Xóa khoảng trắng đầu cuối

        // Xóa khoảng trắng thừa giữa các từ (s = space)
        normalized = normalized.replaceAll("\\s+", " ");

        // Chuyển đổi viết hoa chữ cái đầu mỗi từ, viết thường các chữ còn lại
        String[] words = normalized.split(" ");
        StringBuilder result = new StringBuilder();

        for (String word : words) {
            if (word.length() > 0) {
                String firstChar = word.substring(0, 1).toUpperCase();
                String restChars = word.substring(1).toLowerCase();
                result.append(firstChar).append(restChars).append(" ");
            }
        }

        fullName = result.toString().trim();
        System.out.println("Họ tên sau khi chuẩn hóa: " + fullName);
    }

    // 3. Kiểm tra email hợp lệ
    private static void validateEmail() {
        if (email.isEmpty()) {
            System.err.println("Chưa có thông tin email! Vui lòng nhập thông tin người dùng trước.");
            return;
        }

        // Regex kiểm tra email hợp lệ
        String regex = "^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$";

        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(email);

        if (matcher.matches()) {
            System.out.println("Email \"" + email + "\" là email HỢP LỆ");
        } else {
            System.err.println("Email \"" + email + "\" là email KHÔNG HỢP LỆ");
        }
    }

    // 4. Kiểm tra số điện thoại hợp lệ
    private static void validatePhone() {
        if (phone.isEmpty()) {
            System.err.println("Chưa có thông tin số điện thoại! Vui lòng nhập thông tin người dùng trước.");
            return;
        }

        // Xóa khoảng trắng và dấu gạch ngang nếu có
        String phoneNumber = phone.replaceAll("[\\s-]", "");

        // Regex kiểm tra số điện thoại di động Việt Nam
        // Bắt đầu: 0
        // Sau đó: 3,5,7,8,9
        // Tiếp theo: 8 hoặc 9 số
        String regex = "^(0)(3|5|7|8|9)[0-9]{8}$";

        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(phoneNumber);

        if (matcher.matches()) {
            System.out.println("Số điện thoại \"" + phone + "\" là số HỢP LỆ");
        } else {
            System.err.println("Số điện thoại \"" + phone + "\" KHÔNG HỢP LỆ");
        }
    }

    // 5. Kiểm tra mật khẩu hợp lệ
    private static void validatePassword() {
        if (password.isEmpty()) {
            System.err.println("Chưa có thông tin mật khẩu! Vui lòng nhập thông tin người dùng trước.");
            return;
        }

        boolean hasMinLength = password.length() >= 8;
        boolean hasUpperCase = false;
        boolean hasLowerCase = false;
        boolean hasDigit = false;
        boolean hasSpecialChar = false;

        String specialChars = "!@#$%^&*()_+-=[]{}|;:'\",.<>?/~`";

        for (int i = 0; i < password.length(); i++) {
            char c = password.charAt(i);

            if (Character.isUpperCase(c)) {
                hasUpperCase = true;
            } else if (Character.isLowerCase(c)) {
                hasLowerCase = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            } else if (specialChars.indexOf(c) != -1) {
                hasSpecialChar = true;
            }
        }

        boolean isValid = hasMinLength && hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar;

        System.out.println("\n===== KIỂM TRA MẬT KHẨU =====");
        System.out.println("Mật khẩu: " + password);
        System.out.println("------------------------------------------------------------");
        System.out.println("Độ dài >= 8: " + (hasMinLength ? "✓ Đạt" : "✗ Không đạt"));
        System.out.println("Có chữ hoa: " + (hasUpperCase ? "✓ Đạt" : "✗ Không đạt"));
        System.out.println("Có chữ thường: " + (hasLowerCase ? "✓ Đạt" : "✗ Không đạt"));
        System.out.println("Có chữ số: " + (hasDigit ? "✓ Đạt" : "✗ Không đạt"));
        System.out.println("Có ký tự đặc biệt: " + (hasSpecialChar ? "✓ Đạt" : "✗ Không đạt"));

        if (isValid) {
            System.out.println("\n>>> Mật khẩu HỢP LỆ <<<");
        } else {
            System.err.println("\n>>> Mật khẩu KHÔNG HỢP LỆ <<<");
            System.out.println("Yêu cầu mật khẩu:");

            if (!hasMinLength) {
                System.err.println("- Mật khẩu cần tối thiểu 8 ký tự");
            }
            if (!hasUpperCase) {
                System.err.println("- Có ít nhất 1 chữ cái viết hoa (A-Z)");
            }
            if (!hasLowerCase) {
                System.err.println("- Có ít nhất 1 chữ cái viết thường (a-z)");
            }
            if (!hasDigit) {
                System.err.println("- Có ít nhất 1 chữ số (0-9)");
            }
            if (!hasSpecialChar) {
                System.err.println("- Có ít nhất 1 ký tự đặc biệt (!@#$%^&*...)");
            }
        }
    }
}
