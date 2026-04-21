import java.util.Scanner;

public class Bai01Main {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("Phần mềm tính diện tích hình tròn");
        System.out.print("Vui lòng nhập bán kính: ");
        int radius = sc.nextInt();
        double pi = Math.PI;

        double area = pi *  radius * radius;

        System.out.printf("Diện tích hình tròn (với bán kính %d) là: %f ", radius, area);
    }
}
