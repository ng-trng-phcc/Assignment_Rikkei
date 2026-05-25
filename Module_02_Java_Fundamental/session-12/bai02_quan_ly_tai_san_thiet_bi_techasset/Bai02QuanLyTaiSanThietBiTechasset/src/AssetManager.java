import java.util.ArrayList;
import java.util.Scanner;
import java.text.NumberFormat;
import java.util.Locale;

public class AssetManager {
    private static ArrayList<Asset> assets = new ArrayList<>();
    private static Scanner scanner = new Scanner(System.in);
    private static NumberFormat vndFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

    // Phương thức đa hình: In giá trị hiện tại của bất kỳ tài sản nào
    public static void showValue(Asset a) {
        System.out.println("--- GIA TRI TAI SAN ---");
        System.out.println("Tai san: " + a.getName() + " (Ma: " + a.getAssetCode() + ")");
        System.out.println("Gia mua: " + vndFormat.format(a.getPurchasePrice()));
        System.out.println("Gia tri hien tai: " + vndFormat.format(a.getMarketValue()));
        System.out.println("-----------------------");
    }

    // Nhập tài sản
    public static void addAsset() {
        System.out.println("\n--- NHAP TAI SAN ---");
        System.out.println("1. May tinh");
        System.out.println("2. Thiet bi mang");
        System.out.print("Chon loai tai san: ");

        int choice = Integer.parseInt(scanner.nextLine());

        if (choice != 1 && choice != 2) {
            System.out.println("Lua chon khong hop le!");
            return;
        }

        System.out.print("Nhap ma tai san: ");
        String code = scanner.nextLine();
        System.out.print("Nhap ten tai san: ");
        String name = scanner.nextLine();
        System.out.print("Nhap gia mua: ");
        double price = Double.parseDouble(scanner.nextLine());

        if (choice == 1) {
            System.out.print("Nhap RAM: ");
            String ram = scanner.nextLine();
            System.out.print("Nhap CPU: ");
            String cpu = scanner.nextLine();
            assets.add(new Computer(code, name, price, ram, cpu));
        } else {
            System.out.print("Nhap so cong: ");
            int ports = Integer.parseInt(scanner.nextLine());
            assets.add(new NetworkDevice(code, name, price, ports));
        }
        System.out.println("Them tai san thanh cong!");
    }

    // Xuất báo cáo
    public static void showReport() {
        System.out.println("\n--- BAO CAO TAI SAN ---");

        if (assets.isEmpty()) {
            System.out.println("Khong co tai san nao trong he thong!");
            return;
        }

        double totalMarketValue = 0;
        double totalPurchasePrice = 0;

        for (int i = 0; i < assets.size(); i++) {
            Asset asset = assets.get(i);
            System.out.println((i + 1) + ". " + asset);
            totalMarketValue += asset.getMarketValue();
            totalPurchasePrice += asset.getPurchasePrice();
        }

        System.out.println("----------------------------------------");
        System.out.println("Tong so tai san: " + assets.size());
        System.out.println("Tong gia mua: " + vndFormat.format(totalPurchasePrice));
        System.out.println("Tong gia tri hien tai: " + vndFormat.format(totalMarketValue));
        System.out.println("Tong khau hao: " + vndFormat.format(totalPurchasePrice - totalMarketValue));
        System.out.println("----------------------------------------");
    }

    // Tìm kiếm theo mã tài sản (Overloading)
    public static Asset searchAsset(String assetCode) {
        for (Asset asset : assets) {
            if (asset.getAssetCode().equalsIgnoreCase(assetCode)) {
                return asset;
            }
        }
        return null;
    }

    // Tìm kiếm theo giá mua (Overloading)
    public static ArrayList<Asset> searchAsset(double minPrice) {
        ArrayList<Asset> result = new ArrayList<>();
        for (Asset asset : assets) {
            if (asset.getPurchasePrice() > minPrice) {
                result.add(asset);
            }
        }
        return result;
    }

    // Chức năng tìm kiếm
    public static void searchMenu() {
        System.out.println("\n--- TIM KIEM TAI SAN ---");
        System.out.println("1. Tim theo ma tai san");
        System.out.println("2. Tim theo gia mua (lon hon)");
        System.out.println("3. Quay lai");
        System.out.print("Chon cach tim kiem: ");

        int choice = Integer.parseInt(scanner.nextLine());

        switch (choice) {
            case 1:
                searchByCode();
                break;
            case 2:
                searchByPrice();
                break;
            case 3:
                return;
            default:
                System.out.println("Lua chon khong hop le!");
        }
    }

    // Tìm kiếm theo mã
    private static void searchByCode() {
        System.out.print("Nhap ma tai san can tim: ");
        String code = scanner.nextLine();
        Asset found = searchAsset(code);

        if (found != null) {
            System.out.println("\nTim thay tai san:");
            System.out.println(found);
            showValue(found);
        } else {
            System.out.println("Khong tim thay tai san voi ma: " + code);
        }
    }

    // Tìm kiếm theo giá
    private static void searchByPrice() {
        System.out.print("Nhap muc gia toi thieu: ");
        double minPrice = Double.parseDouble(scanner.nextLine());
        ArrayList<Asset> results = searchAsset(minPrice);

        if (!results.isEmpty()) {
            System.out.println("\nTim thay " + results.size() + " tai san co gia > " + vndFormat.format(minPrice) + ":");
            for (int i = 0; i < results.size(); i++) {
                System.out.println((i + 1) + ". " + results.get(i));
            }
        } else {
            System.out.println("Khong tim thay tai san nao co gia > " + vndFormat.format(minPrice));
        }
    }

    // Sửa giá mua
    public static void updatePrice() {
        System.out.println("\n--- SUA GIA MUA ---");

        if (assets.isEmpty()) {
            System.out.println("Khong co tai san nao de sua!");
            return;
        }

        System.out.println("Danh sach tai san hien co:");
        for (int i = 0; i < assets.size(); i++) {
            System.out.println("  " + assets.get(i).getAssetCode() + " - " + assets.get(i).getName());
        }

        System.out.print("\nNhap ma tai san can sua gia: ");
        String code = scanner.nextLine();

        Asset asset = searchAsset(code);
        if (asset != null) {
            System.out.println("Tim thay tai san: " + asset.getName());
            System.out.println("Gia mua hien tai: " + vndFormat.format(asset.getPurchasePrice()));
            System.out.print("Nhap gia mua moi: ");
            double newPrice = Double.parseDouble(scanner.nextLine());

            if (newPrice > 0) {
                double oldPrice = asset.getPurchasePrice();
                asset.setPurchasePrice(newPrice);
                System.out.println("Cap nhat gia mua thanh cong!");
                System.out.println("Gia cu: " + vndFormat.format(oldPrice) + " -> Gia moi: " + vndFormat.format(newPrice));
            } else {
                System.out.println("Gia mua khong hop le! Phai lon hon 0.");
            }
        } else {
            System.out.println("Khong tim thay tai san voi ma: " + code);
        }
    }

    // Xóa tài sản
    public static void deleteAsset() {
        System.out.println("\n--- XOA TAI SAN ---");

        if (assets.isEmpty()) {
            System.out.println("Khong co tai san nao de xoa!");
            return;
        }

        System.out.println("Danh sach tai san hien co:");
        for (int i = 0; i < assets.size(); i++) {
            System.out.println("  " + assets.get(i).getAssetCode() + " - " + assets.get(i).getName());
        }

        System.out.print("\nNhap ma tai san can xoa: ");
        String code = scanner.nextLine();

        Asset asset = searchAsset(code);
        if (asset != null) {
            System.out.println("Tim thay tai san: " + asset);
            System.out.print("Ban co chac chan muon xoa? (y/n): ");
            String confirm = scanner.nextLine();

            if (confirm.equalsIgnoreCase("y")) {
                assets.remove(asset);
                System.out.println("Da xoa tai san thanh cong!");
            } else {
                System.out.println("Da huy thao tac xoa.");
            }
        } else {
            System.out.println("Khong tim thay tai san voi ma: " + code);
        }
    }

    // Hiển thị menu chính
    private static void showMainMenu() {
        System.out.println("\n----- QUAN LY TAI SAN -----");
        System.out.println("1. Nhap tai san");
        System.out.println("2. Xuat bao cao");
        System.out.println("3. Tim kiem tai san");
        System.out.println("4. Sua gia mua");
        System.out.println("5. Xoa tai san");
        System.out.println("6. Thoat");
        System.out.print("Chon chuc nang: ");
    }

    // Xử lý menu
    private static void processMenu() {
        while (true) {
            showMainMenu();

            try {
                int choice = Integer.parseInt(scanner.nextLine());

                switch (choice) {
                    case 1:
                        addAsset();
                        break;
                    case 2:
                        showReport();
                        break;
                    case 3:
                        searchMenu();
                        break;
                    case 4:
                        updatePrice();
                        break;
                    case 5:
                        deleteAsset();
                        break;
                    case 6:
                        System.out.println("Tam biet!");
                        scanner.close();
                        return;
                    default:
                        System.out.println("Lua chon khong hop le! Vui long chon tu 1-6.");
                }
            } catch (NumberFormatException e) {
                System.out.println("Vui long nhap so!");
            }
        }
    }

    public static void main(String[] args) {
        processMenu();
    }
}