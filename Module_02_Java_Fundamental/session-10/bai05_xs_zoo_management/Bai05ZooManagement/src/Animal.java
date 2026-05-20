public class Animal {
    private String name;
    private int age;

    // constructor không tham số
    public Animal() {
    }

    // constructor có tham số
    public Animal(String name, int age) {
        this.name = name;
        this.age = age;
    }

    // getter & setter
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    // Các method khác
    public void showInfo() {
        System.out.println("[ Animal name : " + getName() + " | age : " + getAge() + "]");
    }

    public void makeSound() {
        System.out.println(getName() + " is making sound ...");
    }

    // overload method
    public void eat() {
        System.out.println(getName() + " is eating.");
    }

    public void eat (String food) {
        System.out.println(getName() + " is eating " + food + ".");
    }

}
