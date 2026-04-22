import java.util.Scanner;

public class Bai05DocSoThanhChu3ChuSoMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.println("Vui lòng nhập 1 số từ 100-999");
        int n = sc.nextInt();

        String hundredsPart = "";
        String tensPart = "";
        String unitsPart = "";

        if (n < 100 | n > 999) {
            System.err.println("----- LỖI -----");
            System.err.println("Số không hợp lệ, vui lòng nhập số từ 100-999");
        } else {
            int units = n % 10;
            n /= 10;
            int tens = n % 10;
            n /= 10;
            int hundreds = n % 10;

            if (hundreds == 1) {
                hundredsPart = "Một trăm ";
            } else if (hundreds == 2) {
                hundredsPart = "Hai trăm ";
            } else if (hundreds == 3) {
                hundredsPart = "Ba trăm ";
            } else if (hundreds == 4) {
                hundredsPart = "Bốn trăm ";
            } else if (hundreds == 5) {
                hundredsPart = "Năm trăm ";
            } else if (hundreds == 6) {
                hundredsPart = "Sáu trăm ";
            } else if (hundreds == 7) {
                hundredsPart = "Bảy trăm ";
            } else if (hundreds == 8) {
                hundredsPart = "Tám trăm ";
            } else if (hundreds == 9) {
                hundredsPart = "Chín trăm ";
            }

            if (tens == 1) {
                tensPart = "mười ";
            } else if (tens == 2) {
                tensPart = "hai mươi ";
            } else if (tens == 3) {
                tensPart = "ba mươi ";
            } else if (tens == 4) {
                tensPart = "bốn mươi ";
            } else if (tens == 5) {
                tensPart = "năm mươi ";
            } else if (tens == 6) {
                tensPart = "sáu mươi ";
            } else if (tens == 7) {
                tensPart = "bảy mươi ";
            } else if (tens == 8) {
                tensPart = "tám mươi ";
            } else if (tens == 9) {
                tensPart = "chín mươi ";
            } else if (tens == 0 && units != 0) {
                tensPart = "lẻ ";
            } else if (tens == 0 && units == 0) {
                tensPart = "";
                unitsPart = "";
            }

            if (units == 1) {
                unitsPart = "một";
            } else if (units == 2) {
                unitsPart = "hai";
            } else if (units == 3) {
                unitsPart = "ba";
            } else if (units == 4 && tens == 1) {
                unitsPart = "bốn";
            } else if (units == 4 && tens != 1) {
                unitsPart = "tư";
            } else if (units == 5 && tens != 0) {
                unitsPart = "lăm";
            } else if (units == 5 && tens == 0) {
                unitsPart = "năm";
            } else if (units == 6) {
                unitsPart = "sáu";
            } else if (units == 7) {
                unitsPart = "bảy";
            } else if (units == 8) {
                unitsPart = "tám";
            } else if (units == 9) {
                unitsPart = "chín";
            } else if (units == 0 && tens != 0) {
                unitsPart = "";
            }

            System.out.println(hundredsPart + tensPart + unitsPart);
        }
    }
}
