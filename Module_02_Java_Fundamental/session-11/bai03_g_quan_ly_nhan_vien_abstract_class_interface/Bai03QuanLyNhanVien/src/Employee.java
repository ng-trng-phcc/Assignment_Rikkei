public abstract class Employee {
    private int id;
    private String name;

    // Constructor không tham số
    public Employee() {
    }

    // Constructor có tham số
    public Employee(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getter & Setter
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Method abstract
    public abstract double calculateSalary();

    // Method bình thường
    public void showInfo() {
        System.out.println("Employee ID: " + id);
        System.out.println("Employee Name: " + name);
    }
}
