// Subclass CashPayment
public class CashPayment extends Payment {
    // No-arg constructor
    public CashPayment() {
        super();
    }

    // Parameterized constructor
    public CashPayment(double amount) {
        super(amount);
    }

    // Override abstract method
    @Override
    public void pay() {
        System.out.println("Cash payment of " + amount + " completed.");
    }
}
