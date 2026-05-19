public class Computer {
    // Đề không yêu cầu biến

    // Constructor
    public Computer() {
    }

    // Overload method
    // 1. Chỉ tính giá gốc
    public double calculatePrice(double basePrice) { return basePrice; }

    // 2. Giá gốc + VAT (giả định VAT nhập %, ví dụ VAT = 10 <=> 10% (0.1))
    // Tức nếu gọi calculate (150, 10) <=> 10% tax = 15. Nghĩa là return 150 + 15
    public double calculatePrice(double basePrice, double tax) {return basePrice + basePrice * tax / 100; }

    // 3. Giá gốc + VAT + giảm giá
    public double calculatePrice(double basePrice, double tax, double discount) {
        // Giả định calculatePrice(150, 10, 20) <=> 10% tax và 20% discount tức là 150 + 15 - 30
        return basePrice + basePrice * tax / 100 - (basePrice * discount / 100);
    }

    public static void main(String[] args) {
        Computer computer = new Computer();

        double price1 = computer.calculatePrice(150);
        System.out.println("[Using basePrice only]");
        System.out.println("Final price = " + price1);

        double price2 = computer.calculatePrice(150, 10);
        System.out.println("\n[Using basePrice + tax]");
        System.out.println("Final price = " + price2);

        double price3 = computer.calculatePrice(150, 10, 20);
        System.out.println("\n[Using basePrice + tax + discount]");
        System.out.println("Final price = " + price3);
    }
}
