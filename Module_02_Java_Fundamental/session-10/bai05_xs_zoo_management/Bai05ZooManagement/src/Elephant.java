public class Elephant extends Mammal {
    public Elephant() {}

    public Elephant(String name, int age, boolean hasFur) {
        super(name, age, hasFur);
    }

    @Override
    public void makeSound() {
        System.out.println(getName() + " says: pawooo!");
    }

    public void sprayWater() {
        System.out.println(getName() + " is spraying water!");
    }
}
