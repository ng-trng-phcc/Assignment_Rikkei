package com.example.productmanagement.service;

import com.example.productmanagement.model.Product;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ProductService {
    private List<Product> products =  new ArrayList<>();

    // Tạo sẵn 3 sản phẩm
    public ProductService() {
        products.add(new Product(1, "Iphone 15 promax", 1200.0));
        products.add(new Product(2, "Laptop Dell", 1000.0));
        products.add(new Product(3, "Apple Watch", 800.0));
    }

    public List<Product> getProducts() {
        return products;
    }
}
