public class Main {
    public static void main(String[] args) {
        Device[] devices = new Device[3];
        devices[0] = new SmartPhone(1, "iPhone 16");
        devices[1] = new Laptop(2, "Dell XPS 15");
        devices[2] = new Television(3, "Samsung 4K TV");

        for (Device d : devices) {
            d.turnOn();
            d.turnOff();

            if (d instanceof Connectable) {
                ((Connectable) d).connectWifi();
            }
            if (d instanceof Chargeable) {
                ((Chargeable) d).charge();
            }
        }
    }
}
