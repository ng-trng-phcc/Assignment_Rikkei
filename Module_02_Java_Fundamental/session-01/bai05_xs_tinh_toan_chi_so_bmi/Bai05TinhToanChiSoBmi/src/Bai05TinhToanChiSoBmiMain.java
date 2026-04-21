import java.util.Scanner;

public class Bai05TinhToanChiSoBmiMain {
    public static void main(String[] args) {
        Scanner sc =  new Scanner(System.in);

        System.out.print("Nhập số cân nặng (kg): ");
        int weight = sc.nextInt();
        System.out.print("Nhập chiều cao (m): ");
        double height = sc.nextDouble();

        double BMI = weight / (height * height);

        System.out.println("--- Kết quả ---");
        System.out.printf("%.2f", BMI);
    }
}
