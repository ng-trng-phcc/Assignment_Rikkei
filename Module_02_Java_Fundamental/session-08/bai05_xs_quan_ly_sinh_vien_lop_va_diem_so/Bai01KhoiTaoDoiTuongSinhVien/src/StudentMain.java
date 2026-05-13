import java.util.ArrayList;
import java.util.Scanner;

public class StudentMain {
    // Tạo mảng động global chứa danh sách học sinh
    private static ArrayList<Student> studentsList = new ArrayList<>();

    // Tạo scanner global
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        int choice;

        do {
            displayMenu();
            System.out.print("Lựa chọn của bạn: ");
            choice = Integer.parseInt(scanner.nextLine());

            switch (choice) {
                case 1:
                    inputStudentsList();
                    break;
                case 2:
                    displayStudentsList();
                    break;
                case 3:
                    findMaxGpa();
                    break;
                case 4:
                    System.out.println("Tổng số sinh viên đã tạo: " + Student.getTotalStudent());
                    break;
                case 0:
                    System.out.println("Đã thoát chương trình!");
                    break;
                default:
                    System.out.println("Lựa chọn không hợp lệ!! Vui lòng chọn lại.");
            }

        } while (choice != 0);
    }


    // =========== Các hàm riêng ===========
    // 0. Hiển thị menu
    public static void displayMenu() {
        System.out.println("==== MENU SINH VIÊN ====");
        System.out.println("1. Nhập danh sách sinh viên");
        System.out.println("2. In danh sách sinh viên");
        System.out.println("3. Tìm sinh viên GPA cao nhất");
        System.out.println("4. In tổng số sinh viên đã tạo");
        System.out.println("0. Thoát");
    }

    // Option 1: Nhập danh sách SV
    public static void inputStudentsList() {
        System.out.println("---------- Bạn vừa chọn 1. Nhập danh sách sinh viên ----------");
        System.out.print("Nhập số lượng sinh viên cần thêm: ");
        int n =  Integer.parseInt(scanner.nextLine());

        for (int i = 0; i < n; i++) {
            System.out.println("\n--- Nhập thông tin cho sinh viên thứ " + (i + 1) + " ---");
            Student student = new Student();
            student.input(scanner);

            // Thêm sinh viên vào danh sách
            studentsList.add(student);
        }

        System.out.println("------- Nhập sinh viên thành công -------");
    }

    // Option 2: In danh sách sinh viên
    public static void displayStudentsList() {
        // Kiểm tra list
        if (studentsList.isEmpty()) {
            System.out.println("Hiện không có sinh viên nào trong danh sách !!");
            return;
        }

        System.out.println("---------- Bạn vừa chọn 2. In danh sách sinh viên ----------");
        for (int i = 0; i < studentsList.size(); i++) {
            studentsList.get(i).print();
            System.out.println("------------------------------------------------------------");
        }
    }

    // Option 3: Tìm sinh viên có GPA cao nhất
    public static void findMaxGpa() {
        // Kiểm tra list
        if (studentsList.isEmpty()) {
            System.out.println("Hiện không có sinh viên nào trong danh sách !!");
            return;
        }

        double maxGpa = studentsList.get(0).getGpa();

        // Tạo mảng mới chứa tất cả các SV có điểm cao nhất (phòng trường hợp có nhiều sinh viên có cùng maxGpa)
        ArrayList<Student> studentsWithMaxGpaList = new ArrayList<>();

        // Tìm GPA cao nhất
        for (Student student : studentsList) {
            if (student.getGpa() > maxGpa) {
                maxGpa = student.getGpa();
            }
        }

        // Thêm tất cả các sinh viên có gpa cao nhất vào list
        for (Student student : studentsList) {
            if (student.getGpa() == maxGpa) {
                studentsWithMaxGpaList.add(student);
            }
        }

        System.out.println("---------- Bạn vừa chọn 3. Tìm sinh viên GPA cao nhất ----------\n");
        System.out.println("------------- DANH SÁCH SINH VIÊN CÓ GPA CAO NHẤT --------------");
        for (Student student : studentsWithMaxGpaList) {
            student.print();
        }
        System.out.println("------------------------ Có " + studentsWithMaxGpaList.size() + " sinh viên ------------------------");
    }
}
