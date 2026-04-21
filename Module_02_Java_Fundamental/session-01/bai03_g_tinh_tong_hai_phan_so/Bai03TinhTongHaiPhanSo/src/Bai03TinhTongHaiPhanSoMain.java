import java.util.Scanner;

public class Bai03TinhTongHaiPhanSoMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Vui lòng nhập tử số thứ nhất: ");
        int a = sc.nextInt();
        System.out.print("Vui lòng nhập mẫu số thứ nhất: ");
        int b = sc.nextInt();

        System.out.print("Vui lòng nhập tử số thứ 2: ");
        int c = sc.nextInt();
        System.out.print("Vui lòng nhập mẫu số thứ 2: ");
        int d = sc.nextInt();

        // Tử số
        int numerator = (a*d + b*c);
        // Mẫu số
        int denominator = b*d;

        System.out.println("--- Kết quả ---");
        System.out.println("Tổng của 2 phân số là: " + numerator + "/" + denominator);
    }
}
