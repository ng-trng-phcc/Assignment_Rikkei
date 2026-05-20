public class Main {
    public static void main(String[] args) {
        Employee[] employees = new Employee[2];

        employees[0] = new FullTimeEmployee(1, "Nguyen Van A", 1000);
        employees[1] = new PartTimeEmployee(2, "Tran Thi B", 120, 6.5);

        for (Employee employee : employees) {
            employee.showInfo();
            double salary = employee.calculateSalary();
            System.out.println("Lương của bạn: " + salary + "$");

            // Nếu thuộc BonusEligible thì in ra thưởng
            if (employee instanceof BonusEligible) {
                double bonus = ((BonusEligible) employee).calculateBonus();
                System.out.println("Bạn được thưởng: " + bonus + "$");
            } else System.out.println("bạn không có thưởng");
        }
    }
}
