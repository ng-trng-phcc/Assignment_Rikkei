public class Animal {
    protected String name;

    // Constructor không tham số
    public Animal() {
    }

    // Constructor có tham số
    public Animal(String name) {
        this.name = name;
    }

    // Getter & Setter
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Phương thức riêng
    public void makeSound() {
        System.out.println("Some animal sound");
    }
}
