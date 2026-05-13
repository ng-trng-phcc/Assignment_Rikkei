public class Dog extends Animal {
    private String color;

    public Dog() {
        super();
    }

    public Dog(String name, int age, String color) {
        super(name, age);  // Gọi constructor của lớp cha
        this.color = color;
    }

    // Getter và Setter cho color
    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    // Phương thức bark()
    public void bark() {
        System.out.println("Woof! Woof!");
    }

    @Override
    public void makeSound() {
        System.out.println("Dog is barking");
    }
}