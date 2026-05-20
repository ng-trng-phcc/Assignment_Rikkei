public class Mammal extends Animal {
    private boolean hasFur;

    // constructor không tham số
    public Mammal() {}

    // constructor có tham số
    public Mammal(String name, int age, boolean hasFur) {
        super(name, age);
        this.hasFur = hasFur;
    }

    public void setHasFur(boolean hasFur) {
        this.hasFur = hasFur;
    }

    @Override
    public void showInfo() {
        System.out.println("[ Animal name : " + getName() + " | age : " + getAge() + " | has fur : " + hasFur + " ]");
    }
}
