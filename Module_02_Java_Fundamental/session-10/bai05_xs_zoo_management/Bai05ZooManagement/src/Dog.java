public class Dog extends Mammal {
    public Dog() {}

    public Dog(String name, int age, boolean hasFur) {
        super(name, age, hasFur);
    }

    @Override
    public void makeSound() {
        System.out.println(getName() + " says: woof woof!");
    }

    public void fetchBall() {
        System.out.println(getName() + " is fetching a ball!");
    }
}
