import java.util.Scanner;

public class Bai03QuanLyLuongNhanVienMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int choice;

        // Khởi tạo các biến thống kê
        int totalEmployees = 0;
        double totalSalary = 0;
        double maxSalary = Double.MIN_VALUE;
        double minSalary = Double.MAX_VALUE;
        double totalBonus = 0;
        boolean hasData = false;

        do {
            System.out.println("\n********** QUẢN LÝ LƯƠNG NHÂN VIÊN **********");
            System.out.println("1. Nhập lương nhân viên");
            System.out.println("2. Hiển thị thống kê");
            System.out.println("3. Tính tổng tiền thưởng");
            System.out.println("4. Thoát");

            System.out.print("Lựa chọn của bạn: ");
            choice = Integer.parseInt(sc.nextLine());

            switch (choice) {
                case 1:
                    // Reset dữ liệu khi nhập mới
                    totalEmployees = 0;
                    totalSalary = 0;
                    maxSalary = Double.MIN_VALUE;
                    minSalary = Double.MAX_VALUE;
                    totalBonus = 0;
                    hasData = false;

                    System.out.println("----- NHẬP LƯƠNG NHÂN VIÊN (nhập -1 để dừng) -----");

                    while (true) {
                        System.out.print("Nhập lương (triệu đồng): ");
                        double salary = Double.parseDouble(sc.nextLine());

                        // Kiểm tra điều kiện dừng
                        if (salary == -1) {
                            System.out.println("Bạn đã hoàn tất việc nhập lương !!");
                            break;
                        }

                        // Kiểm tra lương hợp lệ
                        if (salary < 0 || salary > 500) {
                            System.err.println("Lương không hợp lệ. Vui lòng nhập lại (0 - 500 triệu)!");
                            continue;
                        }

                        // Đánh dấu đã có dữ liệu
                        hasData = true;
                        totalEmployees++;
                        totalSalary += salary;

                        // Cập nhật lương cao nhất, thấp nhất
                        if (totalEmployees == 1) {
                            maxSalary = salary;
                            minSalary = salary;
                        } else {
                            maxSalary = Math.max(maxSalary, salary);
                            minSalary = Math.min(minSalary, salary);
                        }

                        // Phân loại thu nhập
                        System.out.print("Phân loại: ");
                        if (salary < 5) {
                            System.out.println("Thu nhập thấp");
                        } else if (salary <= 15) {
                            System.out.println("Thu nhập trung bình");
                        } else if (salary <= 50) {
                            System.out.println("Thu nhập khá");
                        } else {
                            System.out.println("Thu nhập cao");
                        }

                        // TÍNH TIỀN THƯỞNG
                        double bonusRate = 0;
                        if (salary <= 5) {
                            bonusRate = 0.05;
                        } else if (salary <= 15) {
                            bonusRate = 0.10;
                        } else if (salary <= 50) {
                            bonusRate = 0.15;
                        } else if (salary <= 100) {
                            bonusRate = 0.20;
                        } else {
                            bonusRate = 0.25;
                        }

                        double bonus = salary * bonusRate;
                        totalBonus += bonus;
                        System.out.printf("* Tiền thưởng: %.2f triệu đồng (tỷ lệ: %.0f%%)%n", bonus, bonusRate * 100);
                    }
                    break;

                case 2:
                    if (!hasData || totalEmployees == 0) {
                        System.out.println("Chưa có dữ liệu, vui lòng nhập dữ liệu ở mục 1.");
                        break;
                    }

                    System.out.println("\n========== THỐNG KÊ LƯƠNG NHÂN VIÊN ==========");
                    System.out.printf("Số nhân viên đã nhập: %d%n", totalEmployees);
                    System.out.printf("Lương trung bình: %.2f triệu đồng%n", totalSalary / totalEmployees);
                    System.out.printf("Lương cao nhất: %.2f triệu đồng%n", maxSalary);
                    System.out.printf("Lương thấp nhất: %.2f triệu đồng%n", minSalary);
                    System.out.printf("Tổng tiền lương: %.2f triệu đồng%n", totalSalary);
                    System.out.println("==============================================\n");
                    break;

                case 3:
                    if (!hasData || totalEmployees == 0) {
                        System.out.println("Chưa có dữ liệu, vui lòng nhập dữ liệu ở mục 1.");
                        break;
                    }

                    System.out.println("\n========== TỔNG TIỀN THƯỞNG NHÂN VIÊN ==========");
                    System.out.printf("Tổng số nhân viên: %d%n", totalEmployees);
                    System.out.printf("Tổng tiền thưởng: %.2f triệu đồng%n", totalBonus);
                    System.out.println("================================================\n");
                    break;

                case 4:
                    System.out.println("Bạn đã thoát chương trình !!");
                    System.exit(0);
                    break;

                default:
                    System.err.println("Lựa chọn không hợp lệ! Vui lòng chọn 1-4.");
                    break;
            }

        } while (choice != 4);

        sc.close();
    }
}