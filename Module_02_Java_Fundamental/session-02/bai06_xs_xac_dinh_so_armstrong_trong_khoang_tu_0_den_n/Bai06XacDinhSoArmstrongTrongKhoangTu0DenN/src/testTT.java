public class testTT {
    public static void main(String[] args) {
        int i = 153;
        int iClone = i;
        int cnt = 0;
        int sum = 0;

        while (i > 0) {
            i /= 10;
            cnt++;
        }

        while (iClone > 0) {
            sum += Math.pow((iClone % 10), cnt);
            iClone /= 10;
        }
        System.out.println(sum);
    }
}
