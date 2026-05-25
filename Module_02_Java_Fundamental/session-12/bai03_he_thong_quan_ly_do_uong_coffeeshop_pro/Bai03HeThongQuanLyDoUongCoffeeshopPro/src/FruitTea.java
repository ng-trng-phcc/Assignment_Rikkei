public class FruitTea extends Drink {
    public FruitTea(String id, String name, double price) {
        super(id, name, price);
    }

    @Override
    public void prepare() {
        System.out.println("Lac voi da va trai cay tuoi");
    }

    @Override
    public String toString() {
        return "TRA TRAI CAY | " + super.toString();
    }
}