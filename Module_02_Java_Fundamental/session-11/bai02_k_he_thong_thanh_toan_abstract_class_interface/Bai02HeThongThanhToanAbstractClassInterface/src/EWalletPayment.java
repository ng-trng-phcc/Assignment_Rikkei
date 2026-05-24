// Subclass EWalletPayment implements Refundable
public class EWalletPayment extends Payment implements Refundable {
    // No-arg constructor
    public EWalletPayment() {
        super();
    }

    // Parameterized constructor
    public EWalletPayment(double amount) {
        super(amount);
    }

    // Override abstract method
    @Override
    public void pay() {
        System.out.println("E-Wallet payment of " + amount + " completed.");
    }

    // Implement interface method
    @Override
    public void refund() {
        System.out.println("Refund for E-Wallet payment of " + amount + " processed.");
    }
}
