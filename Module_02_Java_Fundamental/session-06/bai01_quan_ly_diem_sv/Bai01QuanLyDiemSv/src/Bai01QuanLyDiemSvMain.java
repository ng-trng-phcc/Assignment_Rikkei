import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Bai01QuanLyDiemSvMain {
    // Dùng mảng động để thêm điểm
    private static ArrayList<Double> grades = new ArrayList<>();
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        int choice;

        do {
            displayMenu();
            System.out.print("Lựa chọn của bạn: ");
            choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    inputGrades();
                    break;
                case 2:
                    displayGrades();
                    break;
                case 3:
                    calculateAverage();
                    break;
                case 4:
                    findMinMax();
                    break;
                case 5:
                    countPassFail();
                    break;
                case 6:
                    sortGrades();
                    break;
                case 7:
                    statisticExcellentGood();
                    break;
                case 8:
                    System.out.println("Đã thoát chương trình !!");
                    break;
                default:
                    System.out.println("Lựa chọn không hợp lệ! Vui lòng chọn từ 1 đến 8.");
            }
            System.out.println();
        } while (choice != 8);
    }

    // Hiển thị menu
    private static void displayMenu() {
        System.out.println("****************QUẢN LÝ ĐIỂM SV****************");
        System.out.println("1. Nhập danh sách điểm sinh viên");
        System.out.println("2. In danh sách điểm");
        System.out.println("3. Tính điểm trung bình của các sinh viên");
        System.out.println("4. Tìm điểm cao nhất và thấp nhất");
        System.out.println("5. Đếm số lượng sinh viên đạt và trượt");
        System.out.println("6. Sắp xếp điểm tăng dần");
        System.out.println("7. Thống kê số lượng sinh viên giỏi và xuất sắc");
        System.out.println("8. Thoát");
        System.out.println("*********************************************");
    }

    // 1. Nhập danh sách điểm sinh viên
    private static void inputGrades() {
        System.out.print("Nhập số lượng sinh viên: ");
        int n = scanner.nextInt();

        // Xóa danh sách cũ (tránh lỗi buffer)
        grades.clear();

        for (int i = 1; i <= n; i++) {
            System.out.print("Nhập điểm sinh viên thứ " + i + ": ");
            double score = scanner.nextDouble();

            // Kiểm tra điểm hợp lệ (0-10)
            while (score < 0 || score > 10) {
                System.out.print("Điểm không hợp lệ (0-10). Vui lòng nhập lại: ");
                score = scanner.nextDouble();
            }

            grades.add(score);
        }
        System.out.println("Đã hoàn tất việc nhập điểm cho " + n + " sinh viên!");
    }

    // 2. In danh sách điểm
    private static void displayGrades() {
        if (grades.isEmpty()) {
            System.out.println("Danh sách điểm trống! Vui lòng nhập điểm trước.");
            return;
        }

        System.out.println("\n===== DANH SÁCH ĐIỂM SINH VIÊN =====");
        for (int i = 0; i < grades.size(); i++) {
            System.out.printf("Điểm: %.2f\n", grades.get(i));
        }
        System.out.println("=====================================");
    }

    // 3. Tính điểm trung bình
    private static void calculateAverage() {
        if (grades.isEmpty()) {
            System.out.println("Danh sách điểm trống! Vui lòng nhập điểm trước.");
            return;
        }

        double sum = 0;
        for (double score : grades) {
            sum += score;
        }
        double average = sum / grades.size();
        System.out.printf("Điểm trung bình của %d sinh viên là: %.2f\n", grades.size(), average);
    }

    // 4. Tìm điểm cao nhất và thấp nhất (bằng Linear search)
    private static void findMinMax() {
        if (grades.isEmpty()) {
            System.out.println("Danh sách điểm trống! Vui lòng nhập điểm trước.");
            return;
        }

        double max = grades.get(0);
        double min = grades.get(0);

        for (double score : grades) {
            if (score > max) max = score;
            if (score < min) min = score;
        }

        System.out.printf("Điểm cao nhất: %.2f\n", max);
        System.out.printf("Điểm thấp nhất: %.2f\n", min);
    }

    // 5. Đếm số lượng sinh viên đạt và trượt
    private static void countPassFail() {
        if (grades.isEmpty()) {
            System.out.println("Danh sách điểm trống! Vui lòng nhập điểm trước.");
            return;
        }

        int passCount = 0;
        int failCount = 0;

        for (double score : grades) {
            if (score >= 5) {
                passCount++;
            } else {
                failCount++;
            }
        }

        System.out.println("===== KẾT QUẢ HỌC TẬP =====");
        System.out.printf("Số sinh viên đạt: %d\n", passCount);
        System.out.printf("Số sinh viên trượt: %d\n", failCount);
        System.out.println("===========================");
    }

    // 6. Sắp xếp điểm tăng dần
    private static void sortGrades() {
        if (grades.isEmpty()) {
            System.out.println("Danh sách điểm trống! Vui lòng nhập điểm trước.");
            return;
        }

        Collections.sort(grades);
        System.out.println("Đã sắp xếp danh sách điểm tăng dần!");
        displayGrades(); // Hiển thị danh sách sau khi sắp xếp
    }

    // 7. Thống kê số lượng sinh viên giỏi và xuất sắc
    private static void statisticExcellentGood() {
        if (grades.isEmpty()) {
            System.out.println("Danh sách điểm trống! Vui lòng nhập điểm trước.");
            return;
        }

        int excellentCount = 0; // Xuất sắc (9-10)
        int goodCount = 0;      // Giỏi (8 - dưới 9)

        for (double score : grades) {
            if (score >= 9 && score <= 10) {
                excellentCount++;
            } else if (score >= 8 && score < 9) {
                goodCount++;
            }
        }

        System.out.println("===== THỐNG KÊ HỌC LỰC =====");
        System.out.printf("Số sinh viên giỏi: %d\n", goodCount);
        System.out.printf("Số sinh viên xuất sắc: %d\n", excellentCount);
        System.out.println("==============================");
    }
}
