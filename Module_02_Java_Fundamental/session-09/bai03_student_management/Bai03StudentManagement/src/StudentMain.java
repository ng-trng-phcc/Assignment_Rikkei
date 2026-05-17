public class StudentMain {
    public static void main(String[] args) {
        // Tạo 3 đối tượng Student
        Student s1 = new Student(1, "Nguyễn Văn A", 20, 3.5);
        Student s2 = new Student(2, "Trần Thị B", 21, 3.8);
        Student s3 = new Student(3, "Lê Văn C", 19, 2.9);

        // In thông tin từng sinh viên
        s1.printInfo();
        s2.printInfo();
        s3.printInfo();

        // In tổng số sinh viên
        System.out.println("Tổng số sinh viên đã tạo: " + Student.getCount());

        // Kiểm tra hằng số
        System.out.println("\n=== Thông tin GPA ===");
        System.out.println("GPA tối thiểu: " + Student.MIN_GPA);
        System.out.println("GPA tối đa: " + Student.MAX_GPA);
    }
}