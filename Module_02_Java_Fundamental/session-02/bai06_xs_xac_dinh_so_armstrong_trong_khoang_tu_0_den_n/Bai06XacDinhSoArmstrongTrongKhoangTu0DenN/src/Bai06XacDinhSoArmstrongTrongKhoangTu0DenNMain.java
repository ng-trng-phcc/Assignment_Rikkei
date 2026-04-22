import java.util.Scanner;

public class Bai06XacDinhSoArmstrongTrongKhoangTu0DenNMain {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        System.out.print("Vui lòng nhập 1 số n (n >= 0): ");
        int n;

        do {
            n = sc.nextInt();
            System.out.printf("Danh sách các số Armstrong từ 0 - %d gồm: ", n);

            for (int i = 0; i <= n; i++) {
                boolean isArmstrong = false;

                if (i < 10) {
                    isArmstrong = true;
                } else {
                    int tempForCountingDigits = i;
                    int tempForProcessingDigits = i;

                    int digitCount = 0;
                    int armstrongSum = 0;

                    // Đếm số chữ số của i hiện tại
                    while (tempForCountingDigits > 0) {
                        tempForCountingDigits /= 10;
                        digitCount++;       // Nếu i là 153 thì digitCount = 3. Nếu i là 10000 thì digitCount = 5
                    }

                    // Tính tổng Armstrong
                    // giả sử i = 153 thì ở khối này armstrongSum += 3^3 + 5^3 + 1^3
                    while (tempForProcessingDigits > 0) {
                        int digit = tempForProcessingDigits % 10;
                        armstrongSum += (int) Math.pow(digit, digitCount);
                        tempForProcessingDigits /= 10;
                    }

                    // Đối chiếu armstrongSum với i xem có bằng nhau không
                    if (armstrongSum == i) {
                        isArmstrong = true;
                    }
                }

                if (isArmstrong) {
                    System.out.print(i + " ");
                }
            }
        } while (n < 0);
    }
}
