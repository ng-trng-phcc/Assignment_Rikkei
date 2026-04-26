import java.text.NumberFormat;
import java.util.Locale;
import java.util.Scanner;

public class Bai01TinhTienHoaDonSieuThiMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Tên khách hàng: ");
        String username = sc.nextLine();

        System.out.print("Tên sản phẩm: ");
        String productName = sc.nextLine();

        System.out.print("Giá sản phẩm: ");
        double productPrice = Double.parseDouble(sc.nextLine());

        System.out.print("Số lượng mua: ");
        int productQuantity = Integer.parseInt(sc.nextLine());

        System.out.print("Bạn có thẻ thành viên không (true/false): ");
        boolean isMember =  Boolean.parseBoolean(sc.nextLine());

        // Tính thành tiền
        double subTotal = productPrice * productQuantity;

        // Tính giảm giá nếu là thành viên
        double discount = subTotal * 0.1;

        // Tính VAT
        double vat = subTotal * 0.08;

        // Tính tổng thành tiền
        double total = subTotal + vat;

        // Format output
        Locale vn = new  Locale("vi", "VN");
        NumberFormat nf = NumberFormat.getCurrencyInstance(vn);

        System.out.println("======================= HÓA ĐƠN =======================");
        System.out.println("Khách hàng: " + username);
        System.out.println("Sản phẩm: " + productName);
        System.out.println("Số lượng: " + productQuantity);
        System.out.println("Thành tiền: " + nf.format(total));
        System.out.println("Giảm giá thành viên (10%): " + nf.format(subTotal));
        System.out.println("Tiền VAT: " + nf.format(vat));
        System.out.println("Tổng thành toán: " + nf.format(total));
        System.out.println("======================================================");
    }
}
