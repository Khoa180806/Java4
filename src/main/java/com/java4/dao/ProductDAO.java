package com.java4.dao;

import com.java4.entity.Product;

import java.util.List;

public interface ProductDAO {
    List<Product> findAll();
    Product findById(String id);
    void create(Product product);
    void update(Product product);
    void deleteById(String id);
}
