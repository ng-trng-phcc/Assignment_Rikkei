import java.util.Scanner;

public class Bai01TinhTongCacSoTu1DenNMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // Cho người dùng nhập dữ liệu đầu vào
        System.out.print("Vui lòng nhập giá trị cho n: ");
        int n =  sc.nextInt();

        if (n > 0) {
            int sum = 0;
            for (int i = 1; i <= n; i++) {
                sum += i;
            }
            System.out.printf("Tổng từ 1 đến %d là: %d",  n, sum);
        }
        else {
            System.out.println("--- Lỗi ---");
            System.out.println("Số nhập vào không hợp lệ, vui lòng nhập số nguyên dương > 0");
        }
    }
}
