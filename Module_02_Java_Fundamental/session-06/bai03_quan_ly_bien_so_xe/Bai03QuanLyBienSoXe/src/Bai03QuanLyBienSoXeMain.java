import java.util.ArrayList;
import java.util.Collections;
import java.util.Scanner;

public class Bai03QuanLyBienSoXeMain {
    private static ArrayList<String> licensePlates = new ArrayList<>();
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        int choice;

        do {
            displayMenu();
            System.out.print("Lựa chọn của bạn: ");
            choice = scanner.nextInt();
            scanner.nextLine(); // Xóa bộ nhớ đệm

            switch (choice) {
                case 1:
                    addLicensePlate();
                    break;
                case 2:
                    displayLicensePlates();
                    break;
                case 3:
                    searchLicensePlate();
                    break;
                case 4:
                    searchByProvinceCode();
                    break;
                case 5:
                    sortLicensePlates();
                    break;
                case 6:
                    System.out.println("Đã thoát chương trình!");
                    break;
                default:
                    System.out.println("Lựa chọn không hợp lệ! Vui lòng chọn từ 1 đến 6.");
            }
            System.out.println();
        } while (choice != 6);
    }

    // Hiển thị menu
    private static void displayMenu() {
        System.out.println("**************** QUẢN LÝ BIỂN SỐ XE ******************");
        System.out.println("1. Thêm các biển số xe");
        System.out.println("2. Hiển thị danh sách biển số xe");
        System.out.println("3. Tìm kiếm biển số xe");
        System.out.println("4. Tìm biển số xe theo mã tỉnh");
        System.out.println("5. Sắp xếp biển số xe tăng dần");
        System.out.println("6. Thoát");
        System.out.println("******************************************************");
    }

    // 1. Thêm biển số xe
    private static void addLicensePlate() {
        System.out.print("Nhập số lượng biển số xe cần thêm: ");
        int n = scanner.nextInt();
        scanner.nextLine();

        int successCount = 0;

        for (int i = 1; i <= n; i++) {
            System.out.print("Nhập biển số xe thứ " + i + " (định dạng: xxF-xxx.xx): ");
            String plate = scanner.nextLine().trim();

            if (isValidLicensePlate(plate)) {
                licensePlates.add(plate);
                successCount++;
                System.out.println("  ✓ Đã thêm thành công!");
            } else {
                System.out.println("  ✗ Biển số không hợp lệ! Định dạng đúng: 30F-123.45");
            }
        }

        System.out.println("Đã thêm " + successCount + "/" + n + " biển số hợp lệ!");
    }

    // Kiểm tra định dạng biển số xe
    private static boolean isValidLicensePlate(String plate) {
        // Regex kiểm tra định dạng: 2 số + 1 chữ + dấu gạch ngang + 3 số + dấu chấm + 2 số
        // Ví dụ: 30F-123.45
        String regex = "^[0-9]{2}[A-Za-z]-[0-9]{3}\\.[0-9]{2}$";
        return plate.matches(regex);
    }

    // 2. Hiển thị danh sách biển số xe
    private static void displayLicensePlates() {
        if (licensePlates.isEmpty()) {
            System.out.println("Danh sách biển số xe trống! Vui lòng thêm biển số trước.");
            return;
        }

        System.out.println("\n========== DANH SÁCH BIỂN SỐ XE ==========");
        for (int i = 0; i < licensePlates.size(); i++) {
            System.out.printf("%d. %s\n", i + 1, licensePlates.get(i));
        }
        System.out.println("Tổng số: " + licensePlates.size() + " biển số");
        System.out.println("===========================================");
    }

    // 3. Tìm kiếm chính xác biển số xe
    private static void searchLicensePlate() {
        if (licensePlates.isEmpty()) {
            System.out.println("Danh sách biển số xe trống! Vui lòng thêm biển số trước.");
            return;
        }

        System.out.print("Nhập biển số xe cần tìm: ");
        String searchPlate = scanner.nextLine().trim();

        boolean found = false;
        int position = -1;

        for (int i = 0; i < licensePlates.size(); i++) {
            if (licensePlates.get(i).equalsIgnoreCase(searchPlate)) {
                found = true;
                position = i + 1;
                break;
            }
        }

        if (found) {
            System.out.println("✓ Tìm thấy biển số \"" + searchPlate + "\" tại vị trí thứ " + position);
        } else {
            System.out.println("✗ Không tìm thấy biển số \"" + searchPlate + "\" trong danh sách!");
        }
    }

    // 4. Tìm biển số xe theo mã tỉnh
    private static void searchByProvinceCode() {
        if (licensePlates.isEmpty()) {
            System.out.println("Danh sách biển số xe trống! Vui lòng thêm biển số trước.");
            return;
        }

        System.out.print("Nhập mã tỉnh cần tìm (VD: 30, 29, 51, 16...): ");
        String provinceCode = scanner.nextLine().trim();

        // Lấy tên tỉnh dựa trên mã
        String provinceName = getProvinceName(provinceCode);

        ArrayList<String> result = new ArrayList<>();

        for (String plateCode : licensePlates) {
            // Lấy 2 số đầu của biển số (mã tỉnh)
            String code = plateCode.substring(0, 2);
            if (code.equals(provinceCode)) {
                result.add(plateCode);
            }
        }

        if (result.isEmpty()) {
            System.out.println("Không tìm thấy bất kỳ biển số xe nào thuộc mã tỉnh " + provinceCode);
        } else {
            System.out.println("\n========== BIỂN SỐ XE THUỘC MÃ TỈNH " + provinceCode + " ==========");
            if (!provinceName.isEmpty()) {
                System.out.println("Tỉnh/Thành phố: " + provinceName);
            }
            System.out.println("--------------------------------------------------");
            for (int i = 0; i < result.size(); i++) {
                System.out.printf("%d. %s\n", i + 1, result.get(i));
            }
            System.out.println("Tổng số biển tìm được: " + result.size() + " biển số");
            System.out.println("=========================================================");
        }
    }

    // Lấy tên tỉnh theo mã
    private static String getProvinceName(String code) {
        switch (code) {
            // Hà Nội (cũ: 29-33, 40) - nay thêm 41
            case "29": return "Hà Nội";
            case "30": return "Hà Nội";
            case "31": return "Hà Nội";
            case "32": return "Hà Nội";
            case "33": return "Hà Nội";
            case "40": return "Hà Nội";

            // TP. Hồ Chí Minh (cũ: 41, 50-59) - nay 41 chuyển cho Đà Nẵng, 50-59 cho HCM
            case "50": return "TP. Hồ Chí Minh";
            case "51": return "TP. Hồ Chí Minh";
            case "52": return "TP. Hồ Chí Minh";
            case "53": return "TP. Hồ Chí Minh";
            case "54": return "TP. Hồ Chí Minh";
            case "55": return "TP. Hồ Chí Minh";
            case "56": return "TP. Hồ Chí Minh";
            case "57": return "TP. Hồ Chí Minh";
            case "58": return "TP. Hồ Chí Minh";
            case "59": return "TP. Hồ Chí Minh";

            // Đà Nẵng (mới: 43, 41)
            case "43": return "Đà Nẵng";
            case "41": return "Đà Nẵng";

            case "34": return "Hải Phòng";
            case "35": return "Hải Phòng";

            // Thái Bình (17, 16 - 16 thuộc Thái Bình cũ)
            case "16": return "Thái Bình";
            case "17": return "Thái Bình";

            case "18": return "Nam Định";

            case "99": return "Bắc Ninh";

            case "98": return "Bắc Giang";

            case "89": return "Hưng Yên";

            // Hải Dương (34 - cũ, nay 94)
            case "94": return "Hải Dương";

            case "19": return "Phú Thọ";

            case "20": return "Thái Nguyên";

            case "61": return "Bình Dương";

            // Đồng Nai (60, 39 - 39 cũ của Hải Dương, nay 60 Đồng Nai)
            case "60": return "Đồng Nai";

            case "72": return "Bà Rịa - Vũng Tàu";

            case "62": return "Long An";

            case "70": return "Tây Ninh";

            case "68": return "Bình Phước";

            case "65": return "Cần Thơ";

            case "67": return "An Giang";

            // Kiên Giang (68 - cũ, nay 69)
            case "69": return "Kiên Giang";

            case "66": return "Đồng Tháp";

            case "71": return "Bến Tre";

            case "84": return "Trà Vinh";

            case "85": return "Sóc Trăng";

            // Bạc Liêu (94 - cũ, 96 cũ, nay 86)
            case "86": return "Bạc Liêu";

            // Cà Mau (69 - cũ, nay 96)
            case "96": return "Cà Mau";

            case "95": return "Hậu Giang";

            case "36": return "Thanh Hóa";

            // Nghệ An (37 - cũ, nay 38)
            case "38": return "Nghệ An";

            // Hà Tĩnh (38 - cũ, nay 39)
            case "39": return "Hà Tĩnh";

            case "73": return "Quảng Bình";

            case "74": return "Quảng Trị";

            case "75": return "Thừa Thiên Huế";

            case "92": return "Quảng Nam";

            // Quảng Ngãi (76 - cũ, nay 77)
            case "77": return "Quảng Ngãi";

            // Bình Định (77 - cũ, nay 78)
            case "78": return "Bình Định";

            case "79": return "Phú Yên";

            case "83": return "Khánh Hòa";

            case "49": return "Lâm Đồng";

            case "47": return "Đắk Lắk";

            case "48": return "Đắk Nông";

            case "81": return "Gia Lai";

            case "82": return "Kon Tum";

            case "24": return "Lào Cai";

            case "21": return "Yên Bái";

            case "28": return "Hòa Bình";

            case "26": return "Sơn La";

            case "27": return "Điện Biên";

            case "23": return "Lai Châu";

            case "25": return "Hà Giang";

            default: return "";
        }
    }

    // 5. Sắp xếp biển số xe tăng dần
    private static void sortLicensePlates() {
        if (licensePlates.isEmpty()) {
            System.out.println("Danh sách biển số xe trống! Vui lòng thêm biển số trước.");
            return;
        }

        // Sắp xếp theo thứ tự từ điển (tăng dần)
        Collections.sort(licensePlates);

        System.out.println("Đã sắp xếp danh sách biển số xe tăng dần!");
        displayLicensePlates(); // Hiển thị danh sách sau khi sắp xếp
    }
}
