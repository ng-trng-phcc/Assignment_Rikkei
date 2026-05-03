import java.util.ArrayList;
import java.util.Scanner;

public class Bai04SapXepMangChoCacSoChanDungTruocSoLeDungSauMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Nhập số phần tử của mảng: ");
        int n = scanner.nextInt();

        if (n == 0) {
            System.out.println("Mảng không có phần tử");
            return;
        }

        int[] arr = new int[n];

        System.out.println("Nhập các phần tử của mảng:");
        for (int i = 0; i < n; i++) {
            System.out.print("Phần tử thứ " + (i + 1) + ": ");
            arr[i] = scanner.nextInt();
        }

        // Dùng object arraylist để tạo 2 mảng
        ArrayList<Integer> evens = new ArrayList<>();
        ArrayList<Integer> odds = new ArrayList<>();

        for (int num : arr) {
            if (num % 2 == 0) {
                evens.add(num);
            } else {
                odds.add(num);
            }
        }

        // Gộp 2 mảng lại nhưng để các số chẵn đứng trước và các số lẻ đứng sau
        evens.addAll(odds);

        System.out.println("Mảng sau khi sắp xếp:");
        for (int num : evens) {
            System.out.print(num + " ");
        }
    }
}
