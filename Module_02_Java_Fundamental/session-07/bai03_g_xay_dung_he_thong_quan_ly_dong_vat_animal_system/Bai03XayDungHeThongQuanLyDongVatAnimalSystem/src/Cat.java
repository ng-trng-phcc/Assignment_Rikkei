public class Cat extends Animal {
    private String breed;

    public Cat() {
        super();
    }

    public Cat(String name, int age, String breed) {
        super(name, age);  // Gọi constructor của lớp cha
        this.breed = breed;
    }

    // Getter và Setter cho breed
    public String getBreed() {
        return breed;
    }

    public void setBreed(String breed) {
        this.breed = breed;
    }

    // Phương thức meow()
    public void meow() {
        System.out.println("Meow! Meow!");
    }

    @Override
    public void makeSound() {
        System.out.println("Cat is meowing");
    }
}