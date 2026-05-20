import java.util.Scanner;

public class ZooApp {
    static Scanner scanner = new Scanner(System.in);
    static int choice;

    public static void main(String[] args) {

        do {
            showMenu();
            System.out.print("Lựa chọn của bạn: ");
            choice = Integer.parseInt(scanner.nextLine());

            switch (choice) {
                case 1:
                    createAndPrintInfo();
                    break;
                case 2:
                    validateOverriding();
                    break;
                case 3:
                    validateOverloading();
                    break;
                case 4:
                    validateRuntimePolymorphism();
                    break;
                case 5:
                    getUniqueMethodEachAnimal();
                    break;
                default:
                    System.out.println("Invalid choice, please try again (pick from 1-5)");
            }
        } while (choice != 0);
    }

    public static void showMenu() {
        System.out.println("====================== ZOO MANAGEMENT MENU ======================");
        System.out.println("1. Tạo đối tượng và hiển thị thông tin (kế thừa + super)");
        System.out.println("2. Kiểm tra Overriding: gọi makeSound() của từng con vật");
        System.out.println("3. Kiểm tra Overloading: gọi eat() và eat(String)");
        System.out.println("4. Kiểm tra đa hình runtime (Animal array)");
        System.out.println("5. Gọi phương thức đặc trưng của từng loài");
        System.out.println("0. Thoát chương trình");
        System.out.println("=================================================================");
    }

    // Chức năng 1. Tạo đối tượng và hiển thị thông tin (kế thừa + super)
    // Vì đề không yêu cầu hay đề cập gì về việc mở rộng menu, nghĩa là chức năng này sẽ mặc định tạo sẵn đối tượng kèm thông tin
    static Dog dog = new Dog("Buddy", 3, true);
    static Cat cat = new Cat("Mimi", 2, true);
    static Elephant elephant = new Elephant("Dumbo", 10, false);

    public static void createAndPrintInfo() {
        System.out.println("--------------- THÔNG TIN CÁC ĐỘNG VẬT ---------------");
        dog.showInfo();
        cat.showInfo();
        elephant.showInfo();
        System.out.println();
    }

    // Chức năng 2. Kiểm tra Overriding: gọi makeSound() của từng con vật
    public static void validateOverriding() {
        System.out.println("----- OVERRIDING: makeSound() ------");
        dog.makeSound();
        cat.makeSound();
        elephant.makeSound();
        System.out.println();
    }

    // Chức năng 3. Kiểm tra Overloading: gọi eat() và eat(String)
    public static void validateOverloading() {
        System.out.println("----- OVERRIDING: eat(String) -----");
        dog.eat();
        dog.eat("meat");
        cat.eat("fish");
        elephant.eat();
        System.out.println();
    }

    // Chức năng 4. Kiểm tra đa hình runtime (Animal array)
    public static void validateRuntimePolymorphism() {
        // Tạo mảng
        Animal[] animals = {dog, cat, elephant};

        System.out.println("----- POLYMORPHISM RUNTIME -----");
        for (Animal animal : animals) {
            animal.makeSound();
        }
        System.out.println();
    }

    // Chức năng 5. Gọi phương thức đặc trưng của từng loài
    public static void getUniqueMethodEachAnimal() {
        System.out.println("------ PHƯƠNG THỨC RIÊNG CỦA TỪNG LOÀI ------");
        dog.fetchBall();
        cat.climbTree();
        elephant.sprayWater();
        System.out.println();
    }
}
