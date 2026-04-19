package com.example.productmanagement.service;

import com.example.productmanagement.model.Product;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductService {
    private List<Product> products = new ArrayList<>();
    private int nextId = 4; // Bắt đầu từ 4 vì đã có 3 sản phẩm với id 1,2,3

    // Tạo sẵn 3 sản phẩm
    public ProductService() {
        products.add(new Product(1, "Iphone 15 promax", 1200.0));
        products.add(new Product(2, "Laptop Dell", 1000.0));
        products.add(new Product(3, "Apple Watch", 800.0));
    }

    public List<Product> getProducts() {
        return products;
    }

    public Product addProduct(Product product) {
        product.setId(nextId++);
        products.add(product);
        return product;
    }

    public Product updateProduct(int id, Product updatedProduct) {
        for (int i = 0; i < products.size(); i++) {
            Product product = products.get(i);

            if (product.getId() == id) {
                updatedProduct.setId(id);
                products.set(i, updatedProduct);

                return product;
            }
        }

        return null; // Dòng này dùng để throw exception khi id cần sửa không tồn tại
    }

    public void deleteProduct(int id) {
        products.removeIf(product -> product.getId() == id);
    }
}
