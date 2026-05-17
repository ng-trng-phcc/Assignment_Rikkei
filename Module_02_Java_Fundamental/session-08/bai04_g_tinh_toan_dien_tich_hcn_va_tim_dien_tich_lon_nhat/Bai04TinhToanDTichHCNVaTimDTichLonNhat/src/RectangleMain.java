public class RectangleMain {
    public static void main(String[] args) {
        Rectangle r1 = new Rectangle(3, 4);
        Rectangle r2 = new Rectangle(5, 2);
        Rectangle r3 = new Rectangle(4.5, 3.5);

        Rectangle[] rectangles = {r1, r2, r3};

        for (int i = 0; i < rectangles.length; i++) {
            System.out.println("Rectangle " + (i + 1) + ": " + rectangles[i]);
        }

        Rectangle maxAreaRect = rectangles[0];
        boolean hasDuplicate = false;

        for (int i = 1; i < rectangles.length; i++) {
            if (rectangles[i].getArea() > maxAreaRect.getArea()) {
                maxAreaRect = rectangles[i];
                hasDuplicate = false;
            } else if (rectangles[i].getArea() == maxAreaRect.getArea()) {
                hasDuplicate = true;
            }
        }

        System.out.println("\nLargest area = " + String.format("%.2f", maxAreaRect.getArea()) +
                " (" + maxAreaRect + ")");

        if (hasDuplicate) {
            System.out.println("Note: There are multiple rectangles with the same largest area.");
        }
    }

}
