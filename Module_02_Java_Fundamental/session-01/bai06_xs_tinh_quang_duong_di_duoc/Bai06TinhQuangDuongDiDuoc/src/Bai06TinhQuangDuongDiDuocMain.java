import java.util.Scanner;

public class Bai06TinhQuangDuongDiDuocMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Vui lòng nhập vận tốc (km/h): ");
        double v =  sc.nextInt();
        System.out.print("Vui lòng nhập thời gian (giờ): ");
        double t =  sc.nextDouble();

        double s = v*t;

        System.out.println("--- Kết quả ---");
        System.out.println("Quãng đường = " + s + " (km)");
    }
}
