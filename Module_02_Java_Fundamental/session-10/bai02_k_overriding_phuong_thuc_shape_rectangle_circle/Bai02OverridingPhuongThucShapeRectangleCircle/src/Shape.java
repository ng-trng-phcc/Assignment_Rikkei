public class Shape {
    private String color;

    public Shape() {
    }

    public Shape(String color) {
        this.color = color;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double perimeter() {
        return 0;
    }

    public double area() {
        return 0;
    }

    @Override
    public String toString() {
        return "This is a shape with color: " + color;
    }
}
