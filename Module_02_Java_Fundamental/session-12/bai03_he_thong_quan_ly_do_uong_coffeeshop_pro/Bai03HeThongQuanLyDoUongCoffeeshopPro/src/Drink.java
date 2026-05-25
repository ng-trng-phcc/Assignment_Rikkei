import java.text.NumberFormat;
import java.util.Locale;

public abstract class Drink implements IPromotion {
    private String id;
    private String name;
    private double price;
    private static NumberFormat vndFormat = NumberFormat.getCurrencyInstance(new Locale("vi", "VN"));

    public Drink(String id, String name, double price) {
        this.id = id;
        this.name = name;
        this.price = price;
    }

    public abstract void prepare();

    @Override
    public void applyDiscount(double percentage) {
        if (percentage > 0 && percentage <= 100) {
            price = price * (1 - percentage / 100);
        }
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return String.format("ID: %s | Ten: %s | Gia: %s", id, name, vndFormat.format(price));
    }
}