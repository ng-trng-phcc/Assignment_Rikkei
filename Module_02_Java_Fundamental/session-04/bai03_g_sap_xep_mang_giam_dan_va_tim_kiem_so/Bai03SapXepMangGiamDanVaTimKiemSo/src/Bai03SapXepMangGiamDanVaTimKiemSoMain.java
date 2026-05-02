import java.util.Scanner;

public class Bai03SapXepMangGiamDanVaTimKiemSoMain {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Nhập số phần tử của mảng: ");
        int size = scanner.nextInt();

        // Khởi tạo mảng
        int[] arr = new int[size];

        // Nhập các phần tử mảng
        for (int i = 0; i < size; i++) {
            System.out.print("Phần tử thứ " + (i + 1) + ": ");
            arr[i] = scanner.nextInt();
        }

        // Sort mảng giảm dần bằng selection sort
        for (int i = 0; i < arr.length - 1; i++) {
            int maxIndex = i;
            for (int j = i + 1; j < arr.length; j++) {
                if (arr[j] > arr[maxIndex]) {
                    maxIndex = j;
                }
            }

            int temp = arr[i];
            arr[i] = arr[maxIndex];
            arr[maxIndex] = temp;
        }

        System.out.println("Mảng sau khi sắp xếp giảm dần: ");
        for (int i : arr) {
            System.out.print(i + " ");
        }

        System.out.print("\nNhập số cần tìm: ");
        int key = scanner.nextInt();

        // Tìm bằng linear search
        for (int i = 0; i < arr.length; i++) {
            if (arr[i] == key) {
                System.out.println("Tìm kiếm tuyến tính: Số " + arr[i] + " có mặt tại vị trí " + i);
            }
        }

        // Tìm bằng binary search
        int left = 0;
        int right = arr.length - 1;
        while (left < right) {
            int mid = left + (right - left) / 2;

            if (arr[mid] == key) {
                System.out.println("Tìm kiếm nhị phân: Số " + arr[mid] + " có mặt tại vị trí " + mid);
            }

            if (arr[mid] < key) {
                right = mid - 1;
            } else  {
                left = mid + 1;
            }
        }
    }
}
