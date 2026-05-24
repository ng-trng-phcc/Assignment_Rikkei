import java.text.NumberFormat;
import java.util.Locale;

// Subclass Lecturer
public class Lecturer extends Staff {
    // Attribute
    private int teachingHours;

    // No-arg constructor
    public Lecturer() {
    }

    // Parameterized constructor
    public Lecturer(String id, String name, double baseSalary, int teachingHours) {
        super(id, name, baseSalary);
        this.teachingHours = teachingHours;
    }

    // Getter and Setter
    public int getTeachingHours() {
        return teachingHours;
    }

    public void setTeachingHours(int teachingHours) {
        this.teachingHours = teachingHours;
    }

    // Override abstract method
    @Override
    public double calculateTotalSalary() {
        return baseSalary + (teachingHours * 200000);
    }

    // toString
    @Override
    public String toString() {
        NumberFormat cf = NumberFormat.getCurrencyInstance(Locale.US);
        return super.toString() + ", Type: Lecturer, Teaching Hours: " + teachingHours + ", Total Salary: " + cf.format(calculateTotalSalary());
    }
}
