package com.fashionstore.dao;

import java.util.List;
import com.fashionstore.model.ProductSize;

public interface ProductSizeDAO {

    boolean addProductSize(ProductSize productSize);

    boolean updateProductSize(ProductSize productSize);

    boolean deleteProductSize(int productSizeId);

    ProductSize getProductSizeById(int productSizeId);

    List<ProductSize> getSizesByProductId(int productId);

    boolean updateSizeStock(int productSizeId, int stockQuantity);
}