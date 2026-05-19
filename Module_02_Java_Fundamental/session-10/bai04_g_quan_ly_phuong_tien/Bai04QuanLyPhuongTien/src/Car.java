public class Car {
    // Thuộc tính
    private int currentSpeed = 0;

    // Phương thức accelerate không tham số (tăng mặc định +10)
    public void accelerate() {
        currentSpeed += 10;
        System.out.println("Car accelerates by default: +10 km/h");
    }

    // Phương thức accelerate với 1 tham số speed
    public void accelerate(int speed) {
        currentSpeed += speed;
        System.out.println("Car accelerates by " + speed + " km/h");
    }

    // Phương thức accelerate với 2 tham số speed và seconds
    public void accelerate(int speed, int seconds) {
        int increase = speed * seconds;
        currentSpeed += increase;
        System.out.println("Car accelerates " + increase + " km/h (speed x time)");
    }

    // Phương thức in trạng thái tốc độ hiện tại
    public void printStatus() {
        System.out.println("Current speed: " + currentSpeed + " km/h");
        System.out.println();
    }

    public static void main(String[] args) {
        Car myCar = new Car();

        myCar.accelerate();
        myCar.printStatus();

        myCar.accelerate(20);
        myCar.printStatus();

        myCar.accelerate(10, 2);
        myCar.printStatus();
    }
}