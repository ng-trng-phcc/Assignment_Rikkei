// Abstract class representing an electronic device
public abstract class Device {
    // Attributes
    private int id;
    private String name;

    // No-arg constructor
    public Device() {
    }

    // Constructor with parameters
    public Device(int id, String name) {
        this.id = id;
        this.name = name;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Abstract methods
    public abstract void turnOn();
    public abstract void turnOff();

    @Override
    public String toString() {
        return "Device{" +
                "id=" + id +
                " | name= '" + name + '\'' + '}';
    }
}
