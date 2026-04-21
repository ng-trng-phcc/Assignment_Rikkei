import java.util.Scanner;

public class Bai04TinhDienTichVaChuViCuaHinhChuNhatMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Vui lòng nhập chiều rồng của HCN: ");
        float weight = sc.nextFloat();
        System.out.print("Vui lòng nhập chiều dài của HCN: ");
        float height = sc.nextFloat();

        float perimeter = (weight + height)*2;
        float area = weight * height;

        System.out.println("--- Kết quả ---");
        System.out.println("Diện tích của HCN: " + area);
        System.out.println("Chu vi của HCN: " + perimeter);
    }
}
