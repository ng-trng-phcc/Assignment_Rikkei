public class Coffee extends Drink {
    public Coffee(String id, String name, double price) {
        super(id, name, price);
    }

    @Override
    public void prepare() {
        System.out.println("Pha bang may");
    }

    @Override
    public String toString() {
        return "CA PHE | " + super.toString();
    }
}