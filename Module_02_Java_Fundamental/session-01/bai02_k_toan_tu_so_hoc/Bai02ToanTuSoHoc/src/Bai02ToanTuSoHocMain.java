import java.util.Scanner;

public class Bai02ToanTuSoHocMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Vui lòng nhập số thứ nhất: ");
        int firstNumber  = sc.nextInt();
        System.out.print("Vui lòng nhập số thứ hai: ");
        int secondNumber = sc.nextInt();

        // Tổng của 2 số
        int sum =  firstNumber + secondNumber;

        // Hiệu của 2 số
        int subtraction = firstNumber - secondNumber;

        // Tích của 2 số
        int multiplication = firstNumber * secondNumber;

        // Thương của 2 số (số thứ nhất / số thứ hai)
        double division = firstNumber / secondNumber;

        // Phần dư của 2 số (số thứ nhất / số thứ hai)
        double modulo = firstNumber % secondNumber;

        // Output
        System.out.println("--- Kết quả ---");
        System.out.println("firstNumber: " + firstNumber);
        System.out.println("secondNumber: " + secondNumber);
        System.out.println("Tổng: " + sum);
        System.out.println("Hiệu: " + subtraction);
        System.out.println("Tích: " + multiplication);
        System.out.println("Thương: " + division);
        System.out.println("Phần dư: " + modulo);
    }
}
