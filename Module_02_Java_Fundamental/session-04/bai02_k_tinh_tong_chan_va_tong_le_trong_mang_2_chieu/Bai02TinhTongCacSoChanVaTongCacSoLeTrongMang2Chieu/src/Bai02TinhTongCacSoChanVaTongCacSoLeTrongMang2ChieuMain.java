import java.util.Scanner;

public class Bai02TinhTongCacSoChanVaTongCacSoLeTrongMang2ChieuMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Nhập số hàng của mảng: ");
        int rows = scanner.nextInt();
        System.out.print("Nhập số cột của mảng: ");
        int cols = scanner.nextInt();

        int [][] arr = new int[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                System.out.print("Phần tử [" + i + "][" + j + "]: ");
                arr[i][j] = scanner.nextInt();
            }
        }

        int even = 0, odd = 0;
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (arr[i][j] % 2 == 0) {
                    even +=  arr[i][j];
                }
                else {
                    odd +=  arr[i][j];
                }
            }
        }

        System.out.println("Tổng các số chắn: " + even);
        System.out.println("Tổng các số lẻ: " + odd);
    }
}
