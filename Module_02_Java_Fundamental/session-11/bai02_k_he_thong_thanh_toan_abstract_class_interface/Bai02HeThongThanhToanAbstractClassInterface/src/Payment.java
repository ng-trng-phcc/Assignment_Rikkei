public abstract class Payment {
    // Attribute
    protected double amount;

    // No-arg constructor
    public Payment() {
    }

    // Parameterized constructor
    public Payment(double amount) {
        this.amount = amount;
    }

    // Getter
    public double getAmount() {
        return amount;
    }

    // Setter
    public void setAmount(double amount) {
        this.amount = amount;
    }

    // Abstract method
    public abstract void pay();

    // Concrete method
    public void printAmount() {
        System.out.println("Amount: " + amount);
    }
}
