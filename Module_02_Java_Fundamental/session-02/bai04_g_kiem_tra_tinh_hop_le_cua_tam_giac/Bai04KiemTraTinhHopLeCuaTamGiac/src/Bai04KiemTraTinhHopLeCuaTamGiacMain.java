import java.util.Scanner;

public class Bai04KiemTraTinhHopLeCuaTamGiacMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Vui lòng nhập cạnh thứ nhất cho tam giác: ");
        int a  = sc.nextInt();
        System.out.print("Vui lòng nhập cạnh thứ hai cho tam giác: ");
        int b = sc.nextInt();
        System.out.print("Vui lòng nhập cạnh thứ ba cho tam giác: ");
        int c = sc.nextInt();

        if (a > b + c || b > a + c || c > a + b) {
            System.err.println("-------- LỖI --------");
            System.err.println("Ba cạnh không tạo thành tam giác");
        } else {
            System.out.println("------ KẾT QUẢ ------");
            if (a == b && a == c) {
                System.out.println("Đây là tam giác đều");
            }
            else if (a == b || b == c || c == a) {
                System.out.println("Đây là tam giác cân");
            }
            else if (Math.pow(a, 2) == Math.pow(b, 2) + Math.pow(c, 2) || Math.pow(b, 2) == Math.pow(a, 2) + Math.pow(c, 2) || Math.pow(c, 2) == Math.pow(b, 2) + Math.pow(a, 2)) {
                System.out.println("Đây là tam giác vuông");
            } else System.out.println("Đây là tam giác bình thường");
        }
    }
}