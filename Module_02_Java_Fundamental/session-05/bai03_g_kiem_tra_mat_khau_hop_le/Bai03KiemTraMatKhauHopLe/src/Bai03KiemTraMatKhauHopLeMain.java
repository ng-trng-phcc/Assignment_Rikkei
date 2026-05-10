import java.util.Scanner;

public class Bai03KiemTraMatKhauHopLeMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Nhập mật khẩu cần kiểm tra: ");
        String password = scanner.nextLine();

        String result = validatePassword(password);
        System.out.println(result);

        scanner.close();
    }

    public static String validatePassword(String password) {
        StringBuilder errors = new StringBuilder();

        // Kiểm tra độ dài
        if (password.length() < 8) {
            errors.append("- Mật khẩu phải có ít nhất 8 ký tự\n");
        }

        boolean hasUpperCase = false;
        boolean hasLowerCase = false;
        boolean hasDigit = false;
        boolean hasSpecialChar = false;

        for (int i = 0; i < password.length(); i++) {
            char c = password.charAt(i);

            if (Character.isUpperCase(c)) {
                hasUpperCase = true;
            } else if (Character.isLowerCase(c)) {
                hasLowerCase = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            } else if (isSpecialCharacter(c)) {
                hasSpecialChar = true;
            }
        }

        if (!hasUpperCase) {
            errors.append("- Mật khẩu phải có ít nhất một chữ cái viết hoa (A-Z)\n");
        }

        if (!hasLowerCase) {
            errors.append("- Mật khẩu phải có ít nhất một chữ cái viết thường (a-z)\n");
        }

        if (!hasDigit) {
            errors.append("- Mật khẩu phải có ít nhất một ký tự số (0-9)\n");
        }

        if (!hasSpecialChar) {
            errors.append("- Mật khẩu phải có ít nhất một ký tự đặc biệt (@, #, $, !, %)\n");
        }

        if (errors.length() == 0) {
            return "Mật khẩu hợp lệ";
        } else {
            return "Mật khẩu không hợp lệ:\n" + errors.toString();
        }
    }

    public static boolean isSpecialCharacter(char c) {
        String specialChars = "@#$!%";
        return specialChars.indexOf(c) != -1;   // Kiểm tra xem c có khác -1 hay không (nếu khác, tức thuộc specialChars thì return true)
    }
}
