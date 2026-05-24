// Main class
public class Main {
    public static void main(String[] args) {
        Payment[] payments = new Payment[3];
        payments[0] = new CashPayment(100.0);
        payments[1] = new CreditCardPayment(200.0);
        payments[2] = new EWalletPayment(300.0);

        for (Payment p : payments) {
            p.pay();

            if (p instanceof Refundable) {
                ((Refundable) p).refund();
            }
            System.out.println();
        }
    }
}
