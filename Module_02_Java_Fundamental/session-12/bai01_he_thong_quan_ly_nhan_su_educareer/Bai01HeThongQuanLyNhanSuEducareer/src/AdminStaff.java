import java.text.NumberFormat;
import java.util.Locale;

// Subclass AdminStaff
public class AdminStaff extends Staff {
    // Attribute
    private double bonus;

    // No-arg constructor
    public AdminStaff() {
    }

    // Parameterized constructor
    public AdminStaff(String id, String name, double baseSalary, double bonus) {
        super(id, name, baseSalary);
        this.bonus = bonus;
    }

    // Getter and Setter
    public double getBonus() {
        return bonus;
    }

    public void setBonus(double bonus) {
        this.bonus = bonus;
    }

    // Override abstract method
    @Override
    public double calculateTotalSalary() {
        return baseSalary + bonus;
    }

    // toString
    @Override
    public String toString() {
        NumberFormat cf = NumberFormat.getCurrencyInstance(Locale.US);
        return super.toString() + ", Type: AdminStaff, Bonus: " + bonus + ", Total Salary: " + cf.format(calculateTotalSalary());
    }
}
