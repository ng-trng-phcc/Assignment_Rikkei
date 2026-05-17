import java.util.Scanner;

public class Rectangle {
    private double width;
    private double height;

    // Constructor
    public Rectangle(double width, double height) {
        this.width = width;
        this.height = height;
    }

    // Phương thức tính diện tích
    public double getArea() {
        return width * height;
    }

    // Phương thức tính chu vi
    public double getPerimeter() {
        return (width + height) * 2;
    }

    // Getter
    public double getWidth() {
        return width;
    }

    public double getHeight() {
        return height;
    }

    // Phương thức in thông tin
    public void printInfo() {
        System.out.println("=== Thông tin hình chữ nhật ===");
        System.out.println("Chiều rộng: " + width);
        System.out.println("Chiều cao: " + height);
        System.out.println("Diện tích: " + getArea());
        System.out.println("Chu vi: " + getPerimeter());
        System.out.println("=================================");
    }

    // Hàm main
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Nhập thông tin từ bàn phím
        System.out.print("Nhập chiều rộng: ");
        double w = scanner.nextDouble();

        System.out.print("Nhập chiều cao: ");
        double h = scanner.nextDouble();

        // Tạo đối tượng Rectangle
        Rectangle rect = new Rectangle(w, h);

        // In kết quả
        rect.printInfo();

        scanner.close();
    }
}