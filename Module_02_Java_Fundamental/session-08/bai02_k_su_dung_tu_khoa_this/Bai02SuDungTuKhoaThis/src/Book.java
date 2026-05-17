public class Book {
    private String title;
    private String author;
    private double price;

    // Constructor nhận 3 tham số
    public Book(String title, String author, double price) {
        // Sử dụng this để gán giá trị cho các thuộc tính
        this.title = title;
        this.author = author;
        this.price = price;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public double getPrice() {
        return price;
    }

    // Phương thức main
    public static void main(String[] args) {
        Book book1 = new Book("Lập trình Java", "Nguyễn Văn A", 150000.0);

        // In thông tin sách theo định dạng: Title: <title>, Author: <author>, Price: <price>
        System.out.println("Title: " + book1.getTitle() + ", Author: " + book1.getAuthor() + ", Price: " + book1.getPrice());

        Book book2 = new Book("Cơ sở dữ liệu", "Trần Thị B", 120000.5);
        System.out.println("Title: " + book2.getTitle() + ", Author: " + book2.getAuthor() + ", Price: " + book2.getPrice());
    }
}