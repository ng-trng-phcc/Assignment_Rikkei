public class Student {
    private int id;
    private String name;
    private int age;

    // Constructor nhận tất cả các tham số
    public Student(int id, String name, int age) {
        this.id = id;
        this.name = name;
        this.age = age;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    // Phương thức main
    public static void main(String[] args) {
        Student student1 = new Student(1, "Nguyen Van A", 20);

        // In ra thông tin sinh viên theo định dạng: ID: <id>, Name: <name>, Age: <age>
        System.out.println("ID: " + student1.getId() + ", Name: " + student1.getName() + ", Age: " + student1.getAge());

        Student student2 = new Student(2, "Tran Thi B", 21);
        System.out.println("ID: " + student2.getId() + ", Name: " + student2.getName() + ", Age: " + student2.getAge());
    }
}