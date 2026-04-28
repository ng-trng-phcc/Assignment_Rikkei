import java.util.Scanner;

public class Bai02QuanLyDiemHocVienMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        int choice;

        double sumScore = 0;
        int numberOfStudents = 0;
        double maxScore = Double.MIN_VALUE;
        double minScore = Double.MAX_VALUE;
        boolean hasData = false;

        do {
            System.out.println("********** MENU **********");
            System.out.println("1. Nhập điểm học viên");
            System.out.println("2. Hiển thị thống kê");
            System.out.println("3. Thoát");
            System.out.println("==========================");

            System.out.print("Lựa chọn của bạn: ");
            choice = Integer.parseInt(sc.nextLine());

            switch (choice) {
                case 1:
                    double score;

                    sumScore = 0;
                    numberOfStudents = 0;
                    maxScore = Double.MIN_VALUE;
                    minScore = Double.MAX_VALUE;
                    hasData = false;

                    System.out.println("----- VUI LÒNG NHẬP ĐIỂM HỌC VIÊN (nhập -1 để dừng) -----");
                    do {
                        System.out.print("Nhập điểm: ");
                        score = Double.parseDouble(sc.nextLine());

                        if (score == -1) {
                            System.out.println("Bạn đã hoàn tất việc nhập điểm !!");
                            break;
                        }

                        if (score < 0 || score > 10) {
                            System.err.println("Điểm không hợp lệ. Vui lòng nhập lại (0-10).");
                            continue;
                        }

                        hasData = true;

                        if (numberOfStudents == 1) {
                            maxScore = score;
                            minScore = score;
                        } else {
                            maxScore = Math.max(score, maxScore);
                            minScore = Math.min(score, minScore);
                        }

                        if (score < 5) {
                            System.out.println("Học lực: Yếu");
                        }
                        else if (score < 7) {
                            System.out.println("Học lực: Trung bình");
                        }
                        else if (score < 8) {
                            System.out.println("Học lực: Khá");
                        }
                        else if (score < 9) {
                            System.out.println("Học lực: Giỏi");
                        }
                        else {
                            System.out.println("Học lực: Xuất sắc");
                        }

                        sumScore += score;
                        numberOfStudents++;

                    } while (true);
                    break;

                case 2:
                    if (numberOfStudents == 0 || !hasData) {
                        System.err.println("Chưa có dữ liệu, vui lòng nhập dữ liệu ở mục 1 !!");
                        break;
                    }

                    System.out.println("\n========== THỐNG KÊ ĐIỂM ==========");
                    System.out.printf("Số học viên đã nhập: %d%n", numberOfStudents);
                    System.out.printf("Điểm trung bình: %.2f%n", sumScore / numberOfStudents);
                    System.out.printf("Điểm cao nhất: %.2f%n", maxScore);
                    System.out.printf("Điểm thấp nhất: %.2f%n", minScore);
                    System.out.println("===================================\n");
                    break;

                case 3:
                    System.out.print("Bạn đã thoát menu !!");
                    System.exit(0);

                default:
                    System.err.println("Lựa chọn không phù hợp !!");
                    break;
            }

        } while (choice != 3);

        sc.close();
    }
}