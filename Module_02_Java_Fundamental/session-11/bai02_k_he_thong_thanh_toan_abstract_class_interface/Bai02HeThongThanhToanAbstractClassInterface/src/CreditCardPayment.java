// Subclass CreditCardPayment implements Refundable
public class CreditCardPayment extends Payment implements Refundable {
    // No-arg constructor
    public CreditCardPayment() {
        super();
    }

    // Parameterized constructor
    public CreditCardPayment(double amount) {
        super(amount);
    }

    // Override abstract method
    @Override
    public void pay() {
        System.out.println("Credit card payment of " + amount + " completed.");
    }

    // Implement interface method
    @Override
    public void refund() {
        System.out.println("Refund for credit card payment of " + amount + " processed.");
    }
}
