public class Cat extends Mammal {
    public Cat() {
    }

    public Cat(String name, int age, boolean hasFur) {
        super(name, age, hasFur);
    }

    @Override
    public void makeSound() {
        System.out.println(getName() + " says: meow meow!");
    }

    public void climbTree() {
        System.out.println(getName() + " is climbing a tree!");
    }
}
