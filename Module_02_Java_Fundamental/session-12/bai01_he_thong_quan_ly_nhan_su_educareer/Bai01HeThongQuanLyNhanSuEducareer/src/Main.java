import java.util.ArrayList;
import java.util.Scanner;

// Main class
public class Main {
    // Static variables
    private static ArrayList<Staff> staffList = new ArrayList<>();
    private static Scanner sc = new Scanner(System.in);

    // Main method
    public static void main(String[] args) {
        while (true) {
            displayMenu();
            int choice = Integer.parseInt(sc.nextLine());

            switch (choice) {
                case 1:
                    addStaff();
                    break;
                case 2:
                    displayStaff();
                    break;
                case 3:
                    updateStaff();
                    break;
                case 4:
                    deleteStaff();
                    break;
                case 5:
                    System.out.println("Thoát chương trình.");
                    return;
                default:
                    System.out.println("Lựa chọn không hợp lệ.");
            }
            System.out.println();
        }
    }

    // Display main menu
    public static void displayMenu() {
        System.out.println("----------- MENU -----------");
        System.out.println("1. Thêm mới.");
        System.out.println("2. Hiển thị danh sách.");
        System.out.println("3. Cập nhật.");
        System.out.println("4. Xóa.");
        System.out.println("5. Thoát");
        System.out.println("----------------------------");
        System.out.print("Chọn: ");
    }

    // Add new staff
    public static void addStaff() {
        String name;
        double baseSalary;

        while (true) {
            System.out.println("----------- CHỌN LOẠI NHÂN SỰ -----------");
            System.out.println("1. Giảng viên.");
            System.out.println("2. Nhân viên hành chính.");
            System.out.println("0. Thoát");
            System.out.println("------------------------------------------");
            System.out.print("Chọn: ");
            int type = Integer.parseInt(sc.nextLine());

            switch (type) {
                case 1:
                    System.out.print("Nhập ID: ");
                    String id = sc.nextLine();
                    if (isIdExists(id)) {
                        System.out.println("ID đã tồn tại. Vui lòng nhập ID khác.");
                        break;
                    }
                    System.out.print("Nhập tên: ");
                    name = sc.nextLine();
                    System.out.print("Nhập lương cơ bản: ");
                    baseSalary = Double.parseDouble(sc.nextLine());
                    System.out.print("Nhập số giờ làm việc: ");
                    int hours = Integer.parseInt(sc.nextLine());
                    staffList.add(new Lecturer(id, name, baseSalary, hours));
                    System.out.println("Thêm giảng viên thành công!");
                    return;
                case 2:
                    System.out.print("Nhập ID: ");
                    id = sc.nextLine();
                    if (isIdExists(id)) {
                        System.out.println("ID đã tồn tại. Vui lòng nhập ID khác.");
                        break;
                    }
                    System.out.print("Nhập tên: ");
                    name = sc.nextLine();
                    System.out.print("Nhập lương cơ bản: ");
                    baseSalary = Double.parseDouble(sc.nextLine());
                    System.out.print("Nhập bonus: ");
                    double bonus = Double.parseDouble(sc.nextLine());
                    staffList.add(new AdminStaff(id, name, baseSalary, bonus));
                    System.out.println("Thêm nhân viên hành chính thành công!");
                    return;
                case 0:
                    return;
                default:
                    System.out.println("Lựa chọn không hợp lệ. Vui lòng chọn 1 hoặc 2.");
            }
        }
    }

    // Display all staff
    public static void displayStaff() {
        if (staffList.isEmpty()) {
            System.out.println("Danh sách nhân sự trống.");
        } else {
            System.out.println("---------------------- DANH SÁCH NHÂN SỰ ----------------------");
            for (Staff s : staffList) {
                System.out.println(s);
            }
        }
    }

    // Update staff by ID
    public static void updateStaff() {
        if (staffList.isEmpty()) {
            System.out.println("Danh sách nhân sự trống.");
            return;
        }

        System.out.print("Nhập ID cần sửa: ");
        String editId = sc.nextLine();
        Staff found = null;
        for (Staff s : staffList) {
            if (s.getId().equals(editId)) {
                found = s;
                break;
            }
        }

        if (found == null) {
            System.out.println("Không tìm thấy ID: " + editId);
            return;
        }

        while (true) {
            System.out.println("------------- CHỈNH SỬA THÔNG TIN -------------");
            System.out.println("1. Sửa tên.");
            System.out.println("2. Sửa lương cơ bản.");
            System.out.println("3. sửa số giờ làm việc / sửa bonus.");
            System.out.println("0. Thoát");
            System.out.println("-----------------------------------------------");
            System.out.print("Chọn: ");
            int editChoice = Integer.parseInt(sc.nextLine());

            switch (editChoice) {
                case 1:
                    System.out.print("Nhập tên mới: ");
                    found.setName(sc.nextLine());
                    System.out.println("Cập nhật tên thành công!");
                    break;
                case 2:
                    System.out.print("Nhập lương cơ bản mới: ");
                    found.setBaseSalary(Double.parseDouble(sc.nextLine()));
                    System.out.println("Cập nhật lương cơ bản thành công!");
                    break;
                case 3:
                    if (found instanceof Lecturer) {
                        System.out.print("Nhập số giờ làm việc mới: ");
                        ((Lecturer) found).setTeachingHours(Integer.parseInt(sc.nextLine()));
                        System.out.println("Cập nhật số giờ làm việc thành công!");
                    } else if (found instanceof AdminStaff) {
                        System.out.print("Nhập bonus mới: ");
                        ((AdminStaff) found).setBonus(Double.parseDouble(sc.nextLine()));
                        System.out.println("Cập nhật bonus thành công!");
                    }
                    break;
                case 0:
                    return;
                default:
                    System.out.println("Lựa chọn không hợp lệ.");
            }
        }
    }

    // Check if ID exists
    public static boolean isIdExists(String id) {
        for (Staff s : staffList) {
            if (s.getId().equals(id)) {
                return true;
            }
        }
        return false;
    }

    // Delete staff by ID
    public static void deleteStaff() {
        if (staffList.isEmpty()) {
            System.out.println("Danh sách nhân sự trống.");
            return;
        }

        System.out.print("Nhập ID cần xóa: ");
        String deleteId = sc.nextLine();
        for (int i = 0; i < staffList.size(); i++) {
            if (staffList.get(i).getId().equals(deleteId)) {
                staffList.remove(i);
                System.out.println("Xóa nhân sự thành công!");
                return;
            }
        }
        System.out.println("Không tìm thấy ID: " + deleteId);
    }
}
