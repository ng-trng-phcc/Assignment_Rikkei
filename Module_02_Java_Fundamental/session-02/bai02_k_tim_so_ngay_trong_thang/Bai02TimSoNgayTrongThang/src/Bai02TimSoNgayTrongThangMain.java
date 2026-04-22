import java.util.Scanner;

public class Bai02TimSoNgayTrongThangMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Vui lòng nhập 1 số từ 1-12: ");
        int month = sc.nextInt();

        switch (month) {
            case 1:
                System.out.println("Tháng một có 31 ngày !");
                break;
            case 2:
                System.out.println("Tháng hai có 28/29 ngày !");
                break;
            case 3:
                System.out.println("Tháng ba có 31 ngày !");
                break;
            case 4:
                System.out.println("Tháng tư có 30 ngày !");
                break;
            case 5:
                System.out.println("Tháng năm có 31 ngày !");
                break;
            case 6:
                System.out.println("Tháng sáu có 30 ngày !");
                break;
            case 7:
                System.out.println("Tháng bảy có 31 ngày !");
                break;
            case 8:
                System.out.println("Tháng tám có 31 ngày !");
                break;
            case 9:
                System.out.println("Tháng chín có 30 ngày !");
                break;
            case 10:
                System.out.println("Tháng mười có 31 ngày !");
                break;
            case 11:
                System.out.println("Tháng mười một có 30 ngày !");
                break;
            case 12:
                System.out.println("Tháng mười hai có 31 ngày !");
                break;
            default:
                System.err.println("---------------------- Lỗi ----------------------");
                System.err.println("Tháng không hợp lệ !! Vui lòng nhập số tháng nằm trong khoảng 1-12");
                break;
        }
    }
}
