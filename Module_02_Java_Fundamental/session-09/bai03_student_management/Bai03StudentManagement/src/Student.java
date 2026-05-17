public class Student {
    // Thuộc tính private
    private int id;
    private String fullName;
    private int age;
    private double gpa;

    // Static variable đếm số sinh viên
    private static int count = 0;

    public static final double MIN_GPA = 0.0;
    public static final double MAX_GPA = 4.0;

    // Constructor
    public Student(int id, String fullName, int age, double gpa) {
        this.id = id;
        this.fullName = fullName;
        this.age = age;

        // Kiểm tra GPA hợp lệ
        if (gpa >= MIN_GPA && gpa <= MAX_GPA) {
            this.gpa = gpa;
        } else {
            this.gpa = 0.0;
            System.out.println("GPA không hợp lệ! Đặt GPA = 0.0");
        }

        count++; // Tăng số lượng sinh viên
    }

    public int getId() {
        return id;
    }

    public String getFullName() {
        return fullName;
    }

    public int getAge() {
        return age;
    }

    public double getGpa() {
        return gpa;
    }

    // Static method lấy tổng số sinh viên
    public static int getCount() {
        return count;
    }

    // Phương thức in thông tin sinh viên
    public void printInfo() {
        System.out.println("=== Thông tin sinh viên ===");
        System.out.println("ID: " + id);
        System.out.println("Họ tên: " + fullName);
        System.out.println("Tuổi: " + age);
        System.out.println("GPA: " + gpa);
        System.out.println("-----------------------------");
    }
}