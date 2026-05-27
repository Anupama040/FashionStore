package com.fashionstore.dao.impl;

import com.fashionstore.dao.ProductSizeDAO;
import com.fashionstore.model.ProductSize;
import com.fashionstore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductSizeDAOImpl implements ProductSizeDAO {

    @Override
    public boolean addProductSize(ProductSize productSize) {
        String sql = "INSERT INTO product_sizes(product_id, size, stock_quantity) VALUES (?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productSize.getProductId());
            ps.setString(2, productSize.getSize());
            ps.setInt(3, productSize.getStockQuantity());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateProductSize(ProductSize productSize) {
        String sql = "UPDATE product_sizes SET product_id = ?, size = ?, stock_quantity = ? WHERE product_size_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productSize.getProductId());
            ps.setString(2, productSize.getSize());
            ps.setInt(3, productSize.getStockQuantity());
            ps.setInt(4, productSize.getProductSizeId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean deleteProductSize(int productSizeId) {
        String sql = "DELETE FROM product_sizes WHERE product_size_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productSizeId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public ProductSize getProductSizeById(int productSizeId) {
        String sql = "SELECT * FROM product_sizes WHERE product_size_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productSizeId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToProductSize(rs);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<ProductSize> getSizesByProductId(int productId) {
        String sql = "SELECT * FROM product_sizes WHERE product_id = ?";
        List<ProductSize> sizeList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    sizeList.add(mapRowToProductSize(rs));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return sizeList;
    }

    @Override
    public boolean updateSizeStock(int productSizeId, int stockQuantity) {
        String sql = "UPDATE product_sizes SET stock_quantity = ? WHERE product_size_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, stockQuantity);
            ps.setInt(2, productSizeId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private ProductSize mapRowToProductSize(ResultSet rs) throws Exception {
        ProductSize productSize = new ProductSize();
        productSize.setProductSizeId(rs.getInt("product_size_id"));
        productSize.setProductId(rs.getInt("product_id"));
        productSize.setSize(rs.getString("size"));
        productSize.setStockQuantity(rs.getInt("stock_quantity"));
        return productSize;
    }
}