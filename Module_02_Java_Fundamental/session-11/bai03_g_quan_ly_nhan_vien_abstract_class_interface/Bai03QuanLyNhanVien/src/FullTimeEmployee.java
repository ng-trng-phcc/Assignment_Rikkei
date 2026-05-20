import java.sql.SQLOutput;

public class FullTimeEmployee extends Employee implements BonusEligible{
    private double baseSalary;

    // Constructor không tham số
    public FullTimeEmployee() {
    }

    // Constructor có tham số
    public FullTimeEmployee(int id, String name, double baseSalary) {
        super(id, name);
        this.baseSalary = baseSalary;
    }

    // Getter & Setter
    public double getBaseSalary() {
        return baseSalary;
    }

    public void setBaseSalary(double baseSalary) {
        this.baseSalary = baseSalary;
    }

    // Viết lại method
    @Override
    public double calculateBonus() {
        return baseSalary * 0.1;
    }

    @Override
    public double calculateSalary() {
        return baseSalary;
    }

    @Override
    public void showInfo() {
        System.out.printf("[Employee ID: %d | Name: %s | Base Salary: %.2f]\n", getId(), getName(), getBaseSalary());
    }
}
