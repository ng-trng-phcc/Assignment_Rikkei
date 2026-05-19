public class Dog extends Animal {

    // Constructor không tham số
    public Dog() {
    }

    // Constructor có tham số
    public Dog(String name) {
        super(name);
    }

    public static void main(String[] args) {
        Dog d = new Dog("Buddy");
        d.makeSound();
    }
}
