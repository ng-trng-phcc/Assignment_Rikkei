import java.util.ArrayList;
import java.util.Scanner;
import java.text.NumberFormat;
import java.util.Locale;

public class CoffeeShopManager {
    private static ArrayList<Drink> menu = new ArrayList<>();
    private static Scanner scanner = new Scanner(System.in);
    private static NumberFormat vndFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

    // Thêm món vào menu
    public static void addDrink() {
        System.out.println("\n--- THEM MON VAO MENU ---");
        System.out.println("1. Ca phe");
        System.out.println("2. Tra trai cay");
        System.out.print("Chon loai do uong: ");

        int choice = Integer.parseInt(scanner.nextLine());

        if (choice != 1 && choice != 2) {
            System.out.println("Lua chon khong hop le!");
            return;
        }

        System.out.print("Nhap ID: ");
        String id = scanner.nextLine();
        System.out.print("Nhap ten mon: ");
        String name = scanner.nextLine();
        System.out.print("Nhap gia: ");
        double price = Double.parseDouble(scanner.nextLine());

        if (choice == 1) {
            menu.add(new Coffee(id, name, price));
        } else {
            menu.add(new FruitTea(id, name, price));
        }
        System.out.println("Them mon thanh cong!");
    }

    // Hiển thị menu
    public static void showMenu() {
        System.out.println("\n--- MENU DO UONG ---");

        if (menu.isEmpty()) {
            System.out.println("Menu trong! Chua co mon nao.");
            return;
        }

        for (int i = 0; i < menu.size(); i++) {
            Drink drink = menu.get(i);
            System.out.println((i + 1) + ". " + drink);
            System.out.print("   Cach pha che: ");
            drink.prepare();
            System.out.println();
        }

        System.out.println("----------------------------------------");
        System.out.println("Tong so mon: " + menu.size());
    }

    // Áp dụng mã giảm giá
    public static void applyPromotion() {
        System.out.println("\n--- AP DUNG MA GIAM GIA ---");

        if (menu.isEmpty()) {
            System.out.println("Menu trong! Khong co mon nao de giam gia.");
            return;
        }

        System.out.print("Nhap phan tram giam gia (%): ");
        double percentage = Double.parseDouble(scanner.nextLine());

        if (percentage <= 0 || percentage > 100) {
            System.out.println("Phan tram giam gia khong hop le! Phai tu 1 den 100.");
            return;
        }

        System.out.println("\nAp dung giam gia " + percentage + "% cho toan bo menu...");
        for (Drink drink : menu) {
            double oldPrice = drink.getPrice();
            drink.applyDiscount(percentage);
            double newPrice = drink.getPrice();
            System.out.println(drink.getName() + ": " + vndFormat.format(oldPrice) + " -> " + vndFormat.format(newPrice));
        }

        System.out.println("\nAp dung giam gia thanh cong!");
    }

    // Xóa món
    public static void removeDrink() {
        System.out.println("\n--- XOA MON KHOI MENU ---");

        if (menu.isEmpty()) {
            System.out.println("Menu trong! Khong co mon nao de xoa.");
            return;
        }

        System.out.println("Danh sach mon hien co:");
        for (int i = 0; i < menu.size(); i++) {
            System.out.println((i + 1) + ". " + menu.get(i).getId() + " - " + menu.get(i).getName() + " - " + vndFormat.format(menu.get(i).getPrice()));
        }

        System.out.print("\nNhap ID mon can xoa: ");
        String id = scanner.nextLine();

        Drink drinkToRemove = null;
        for (Drink drink : menu) {
            if (drink.getId().equalsIgnoreCase(id)) {
                drinkToRemove = drink;
                break;
            }
        }

        if (drinkToRemove != null) {
            System.out.println("Tim thay mon: " + drinkToRemove);
            System.out.print("Ban co chac chan muon xoa? (y/n): ");
            String confirm = scanner.nextLine();

            if (confirm.equalsIgnoreCase("y")) {
                menu.remove(drinkToRemove);
                System.out.println("Da xoa mon thanh cong!");
            } else {
                System.out.println("Da huy thao tac xoa.");
            }
        } else {
            System.out.println("Khong tim thay mon voi ID: " + id);
        }
    }

    // Thống kê
    public static void showStatistics() {
        System.out.println("\n--- THONG KE MENU ---");

        if (menu.isEmpty()) {
            System.out.println("Menu trong! Khong co du lieu de thong ke.");
            return;
        }

        double totalPrice = 0;
        double minPrice = menu.get(0).getPrice();
        double maxPrice = menu.get(0).getPrice();
        String minDrink = menu.get(0).getName();
        String maxDrink = menu.get(0).getName();

        int coffeeCount = 0;
        int fruitTeaCount = 0;

        for (Drink drink : menu) {
            totalPrice += drink.getPrice();

            if (drink.getPrice() < minPrice) {
                minPrice = drink.getPrice();
                minDrink = drink.getName();
            }

            if (drink.getPrice() > maxPrice) {
                maxPrice = drink.getPrice();
                maxDrink = drink.getName();
            }

            if (drink instanceof Coffee) {
                coffeeCount++;
            } else if (drink instanceof FruitTea) {
                fruitTeaCount++;
            }
        }

        double averagePrice = totalPrice / menu.size();

        System.out.println("Tong so mon: " + menu.size());
        System.out.println("  - Ca phe: " + coffeeCount + " mon");
        System.out.println("  - Tra trai cay: " + fruitTeaCount + " mon");
        System.out.println("Tong gia tien: " + vndFormat.format(totalPrice));
        System.out.println("Gia trung binh: " + vndFormat.format(averagePrice));
        System.out.println("Gia thap nhat: " + vndFormat.format(minPrice) + " (" + minDrink + ")");
        System.out.println("Gia cao nhat: " + vndFormat.format(maxPrice) + " (" + maxDrink + ")");
        System.out.println("----------------------------------------");
    }

    // Hiển thị menu chính
    private static void showMainMenu() {
        System.out.println("\n----- QUAN LY QUAN CA PHE -----");
        System.out.println("1. Them mon vao menu");
        System.out.println("2. Hien thi menu");
        System.out.println("3. Ap dung ma giam gia");
        System.out.println("4. Xoa mon");
        System.out.println("5. Thong ke");
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
                        addDrink();
                        break;
                    case 2:
                        showMenu();
                        break;
                    case 3:
                        applyPromotion();
                        break;
                    case 4:
                        removeDrink();
                        break;
                    case 5:
                        showStatistics();
                        break;
                    case 6:
                        System.out.println("Tam biet! Chuc quan buon may ban dat!");
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