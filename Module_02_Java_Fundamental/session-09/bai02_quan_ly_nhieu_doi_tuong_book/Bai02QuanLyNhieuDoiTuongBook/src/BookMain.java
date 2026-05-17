public class BookMain {
    public static void main(String[] args) {
        // Cách 1: Dùng mảng Book[]
        Book[] books = new Book[3];

        // Tạo 3 đối tượng Book
        books[0] = new Book("Java", "James", 100.0);
        books[1] = new Book("Python", "Guido", 120.0);
        books[2] = new Book("C++", "Bjarne", 150.0);

        // In danh sách sách
        System.out.println("LIST OF BOOKS");
        System.out.println("=============");

        for (int i = 0; i < books.length; i++) {
            books[i].printInfo();
        }
    }
}