public class Television extends Device implements Connectable {
    public Television() {
    }

    public Television(int id, String name) {
        super(id, name);
    }

    @Override
    public void turnOn() {
        System.out.println("Television is turning on...");
    }

    @Override
    public void turnOff() {
        System.out.println("Television is turning off...");
    }

    @Override
    public void connectWifi() {
        System.out.println("Television is connecting to Wi-Fi...");
    }
}
