package com.fashionstore.dao;

import java.math.BigDecimal;
import java.util.List;
import com.fashionstore.model.Product;

public interface ProductDAO {
	

    boolean addProduct(Product product);

    boolean updateProduct(Product product);

    boolean deleteProduct(int productId);

    Product getProductById(int productId);

    List<Product> getAllProducts();

    List<Product> getProductsByCategory(int categoryId);

    List<Product> searchProducts(String keyword);

    List<Product> getProductsByBrand(String brand);

    List<Product> getProductsByPriceRange(BigDecimal minPrice, BigDecimal maxPrice);

    List<Product> getProductsByCategoryAndPriceRange(int categoryId, BigDecimal minPrice, BigDecimal maxPrice);

    List<Product> getLatestProducts();

    boolean updateProductStock(int productId, int stockQuantity);
}