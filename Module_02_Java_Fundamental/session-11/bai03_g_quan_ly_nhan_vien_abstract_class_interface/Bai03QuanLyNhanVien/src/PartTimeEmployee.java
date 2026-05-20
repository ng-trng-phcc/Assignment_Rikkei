public class PartTimeEmployee extends Employee {
    private int workingHours;
    private double hourlyRate;

    // Constructor không tham số
    public PartTimeEmployee() {
    }

    // Constructor có tham số
    public PartTimeEmployee(int id, String name, int workingHours, double hourlyRate) {
        super(id, name);
        this.workingHours = workingHours;
        this.hourlyRate = hourlyRate;
    }

    // Getter & Setter
    public int getWorkingHours() {
        return workingHours;
    }

    public void setWorkingHours(int workingHours) {
        this.workingHours = workingHours;
    }

    public double getHourlyRate() {
        return hourlyRate;
    }

    public void setHourlyRate(double hourlyRate) {
        this.hourlyRate = hourlyRate;
    }

    @Override
    public double calculateSalary() {
        return workingHours * hourlyRate;
    }

    @Override
    public void showInfo() {
        System.out.printf("[Employee ID: %d | Name: %s | Working Hours: %d | Hourly Rate: %.2f]\n", getId(), getName(), getWorkingHours(), getHourlyRate());
    }
}
