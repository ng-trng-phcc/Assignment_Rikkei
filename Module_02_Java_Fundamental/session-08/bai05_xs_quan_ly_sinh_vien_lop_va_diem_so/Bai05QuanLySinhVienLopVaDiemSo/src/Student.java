import java.util.Scanner;

public class Student {
    private int id;
    private String name;
    private double gpa;

    // Thuộc tính static
    public static int countStudent = 0;

    // Hằng số final
    public static final double SCORE_FACTOR = 0.25;

    // Constructor không tham số
    public Student() {
        countStudent++;
    }

    // Constructor với 3 tham số
    public Student(int id, String name, double gpa) {
        this();
        this.id = id;
        this.name = name;
        this.gpa = gpa;
    }

    // Getter & Setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getGpa() {
        return gpa;
    }

    public void setGpa(double gpa) {
        this.gpa = gpa;
    }

    // Method dùng để nhập thông tin
    public void input(Scanner scanner) {
        // Nhập mã sinh viên
        System.out.print("Nhập mã sinh viên: ");
        while (true) {
            try {
                this.id = Integer.parseInt(scanner.nextLine());
                break;
            } catch (NumberFormatException e) {
                System.out.print("Mã sinh viên phải là số. Vui lòng nhập lại: ");
            }
        }

        // Nhập tên sinh viên
        System.out.print("Nhập tên sinh viên: ");
        this.name = scanner.nextLine();

        // Nhập GPA
        System.out.print("Nhập GPA (0.0 - 4.0): ");
        while (true) {
            try {
                this.gpa = Double.parseDouble(scanner.nextLine());
                if (this.gpa >= 0 && this.gpa <= 4) {
                    break;
                } else {
                    System.out.print("GPA phải từ 0-4. Vui lòng nhập lại: ");
                }
            } catch (NumberFormatException e) {
                System.out.print("GPA phải là số. Vui lòng nhập lại: ");
            }
        }
    }

    // Method dùng để in thông tin sinh viên
    public void print() {
        System.out.printf("| Mã SV: %d | Tên SV: %s | GPA: %.2f\n", id, name, gpa);
    }

    // Method đùng để lấy về tổng số sinh viên
    public static int getTotalStudent() {
        return countStudent;
    }
}
