import java.util.Scanner;

public class Bai03TinhTongCacChuSoCuaMotSoNguyenMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Vui lòng nhập một số nguyên bất kỳ: ");
        int n = sc.nextInt();
        int sum = 0;
        int input = (n < 0) ? n * -1 : n;

        while (input > 0) {
            sum += input % 10;
            input /= 10;
        }

        System.out.println("--- KẾT QUẢ ---");
        System.out.printf("Tổng các chữ số của %d = %d", n, sum);
    }
}
