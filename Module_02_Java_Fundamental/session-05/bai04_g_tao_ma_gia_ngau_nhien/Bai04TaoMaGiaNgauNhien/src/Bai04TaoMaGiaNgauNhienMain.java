import java.util.Scanner;

public class Bai04TaoMaGiaNgauNhienMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Nhập độ dài n (1 ≤ n ≤ 1000): ");
        int n = scanner.nextInt();

        if (n < 1 || n > 1000) {
            System.out.println("Lỗi: n phải nằm trong khoảng từ 1 đến 1000!");
        } else {
            String randomString = generateRandomString(n);
            System.out.println("Chuỗi ngẫu nhiên: " + randomString);
        }

        scanner.close();
    }

    // Dùng math.random để random ký tự và StringBuilder để nối chuỗi
    public static String generateRandomString(int n) {
        String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

        StringBuilder result = new StringBuilder(n);

        for (int i = 0; i < n; i++) {
            int randomIndex = (int)(Math.random() * characters.length());
            result.append(characters.charAt(randomIndex));
        }

        return result.toString();
    }
}
