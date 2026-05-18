public class ShapeMain {
    public static void main(String[] args) {
        Shape s1 = new Rectangle(2, 3);
        Shape s2 = new Circle(1);

        s1.area();
        s2.area();

        System.out.println(s1);
        System.out.println(s2);

    }
}
