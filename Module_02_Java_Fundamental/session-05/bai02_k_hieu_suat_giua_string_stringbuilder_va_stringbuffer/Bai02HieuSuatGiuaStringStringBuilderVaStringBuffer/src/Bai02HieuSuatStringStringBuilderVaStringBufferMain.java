public class Bai02HieuSuatStringStringBuilderVaStringBufferMain {
    public static void main(String[] args) {
        final int LOOPS = 1_000_000;

        System.out.println("=== SO SÁNH HIỆU SUẤT NỐI CHUỔI ===");
        System.out.println("Số lần nối: " + LOOPS + "\n");

        // 1. Kiểm tra với String (không nên chạy với số quá lớn vì rất chậm)
        // Để tránh treo máy, có thể giảm số lần lặp cho String
        System.out.println("1. Đang kiểm tra String...");
        long startTime = System.currentTimeMillis();

        String str = "Hello";   // Chuỗi ban đầu
        for (int i = 0; i < LOOPS; i++) {
            str = str + " World";
        }

        long endTime = System.currentTimeMillis();
        long stringTime = endTime - startTime;
        System.out.println("String  thời gian: " + stringTime + " ms");

        // 2. Kiểm tra với StringBuilder
        System.out.println("\n2. Đang kiểm tra StringBuilder...");
        startTime = System.currentTimeMillis();

        StringBuilder sb = new StringBuilder("Hello");
        for (int i = 0; i < LOOPS; i++) {
            sb.append(" World");
        }

        endTime = System.currentTimeMillis();
        long stringBuilderTime = endTime - startTime;
        System.out.println("StringBuilder thời gian: " + stringBuilderTime + " ms");

        // 3. Kiểm tra với StringBuffer
        System.out.println("\n3. Đang kiểm tra StringBuffer...");
        startTime = System.currentTimeMillis();

        StringBuffer sbf = new StringBuffer("Hello");
        for (int i = 0; i < LOOPS; i++) {
            sbf.append(" World");
        }

        endTime = System.currentTimeMillis();
        long stringBufferTime = endTime - startTime;
        System.out.println("StringBuffer  thời gian: " + stringBufferTime + " ms");

        // In bảng tổng kết
        System.out.println("\n=== KẾT QUẢ TỔNG KẾT ===");
        System.out.printf("%-15s %10s %10s\n", "Loại", "Thời gian(ms)", "So sánh");
        System.out.println("-------------------------------------");
        System.out.printf("%-15s %10d %10s\n", "String", stringTime, "Chậm nhất");
        System.out.printf("%-15s %10d %10s\n", "StringBuilder", stringBuilderTime, "Nhanh nhất");
        System.out.printf("%-15s %10d %10s\n", "StringBuffer", stringBufferTime, "Trung bình");

        // Tính tỷ lệ
        if (stringBuilderTime > 0) {
            System.out.println("\n=== NHẬN XÉT ===");
            System.out.println("- String: Không hiệu quả cho phép nối chuỗi nhiều lần do tạo ra nhiều đối tượng mới.");
            System.out.println("- StringBuilder: Hiệu quả và nhanh chóng, thích hợp cho nhiều thao tác nối chuỗi trong một Luồng.");
            System.out.println("- StringBuffer: Tuong tự như StringBuilder nhưng an toàn với đa Luồng, có thể chậm hơn một chút do đồng bộ hóa.");
        }
    }
}



