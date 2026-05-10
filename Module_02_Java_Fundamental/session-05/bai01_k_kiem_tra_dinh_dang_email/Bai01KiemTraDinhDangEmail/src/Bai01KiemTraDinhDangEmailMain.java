import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Bai01KiemTraDinhDangEmailMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Nhập địa chỉ email: ");
        String email = scanner.nextLine();

        // Loại bỏ khoảng trắng thừa ở đầu và cuối
        email = email.trim();

        // Biểu thức chính quy kiểm tra email
        // ^: bắt đầu chuỗi
        // [a-zA-Z0-9._]+: username (chữ cái, số, dấu chấm, gạch dưới) - 1 hoặc nhiều ký tự
        // @: ký tự @
        // [a-zA-Z0-9.]+: domain (chữ cái, số, dấu chấm) - 1 hoặc nhiều ký tự
        // \\.: dấu chấm trước TLD
        // [a-zA-Z]{2,6}: TLD từ 2-6 ký tự chữ cái
        // $: kết thúc chuỗi
        String regex = "^[a-zA-Z0-9._]+@[a-zA-Z0-9.]+\\.[a-zA-Z]{2,6}$";

        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(email);

        if (matcher.matches()) {
            System.out.println("Email hợp lệ");
        } else {
            System.err.println("Email không hợp lệ");
        }

        scanner.close();
    }
}
