import java.text.DecimalFormat;

public class CurrencyConverter {
    // Thuộc tính tĩnh lưu tỉ giá
    private static double rate = 0.0;

    // Phương thức tĩnh để đặt tỉ giá hiện hành (có kiểm tra giá trị hợp lệ)
    public static void setRate(double r) {
        if (r > 0) {
            rate = r;
            System.out.println("Đã đặt tỉ giá: 1 USD = " + r + " VND");
        } else {
            System.out.println("Lỗi: Tỉ giá phải là số dương!");
        }
    }

    // Phương thức tĩnh để lấy tỉ giá hiện hành
    public static double getRate() {
        return rate;
    }

    // Phương thức tĩnh chuyển đổi VND → USD
    public static double toUSD(int vnd) {
        if (rate <= 0) {
            System.out.println("Lỗi: Chưa đặt tỉ giá hoặc tỉ giá không hợp lệ!");
            return 0;
        }
        if (vnd < 0) {
            System.out.println("Lỗi: Số tiền VND không thể âm!");
            return 0;
        }
        return vnd / rate;
    }

    // Phương thức định dạng USD với 2 chữ số thập phân
    public static String formatUSD(double usd) {
        DecimalFormat df = new DecimalFormat("#,##0.00");
        return df.format(usd);
    }

    // Phương thức chuyển đổi và trả về chuỗi đã định dạng
    public static String convertToUSD(int vnd) {
        double usd = toUSD(vnd);
        if (usd == 0 && vnd != 0) {
            return "Không thể chuyển đổi";
        }
        return formatUSD(usd);
    }

    // Phương thức main để kiểm tra (quy mô bài này nhỏ nên em viết main trong cùng 1 file luôn)
    public static void main(String[] args) {
        setRate(25000);

        System.out.println("Tỉ giá: 1 USD = " + getRate() + " VND");
        System.out.println("50,000 VND = " + formatUSD(toUSD(50000)) + " USD");
        System.out.println("100,000 VND = " + formatUSD(toUSD(100000)) + " USD");
        System.out.println("1,000,000 VND = " + formatUSD(toUSD(1000000)) + " USD");
    }
}