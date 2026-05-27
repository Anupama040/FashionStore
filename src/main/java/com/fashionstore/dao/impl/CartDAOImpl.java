package com.fashionstore.dao.impl;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.model.Cart;
import com.fashionstore.model.CartItem;
import com.fashionstore.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {

    @Override
    public boolean createCart(int userId) {
        String checkSql = "SELECT * FROM cart WHERE user_id = ?";
        String insertSql = "INSERT INTO cart(user_id) VALUES (?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement checkPs = con.prepareStatement(checkSql)) {

            checkPs.setInt(1, userId);

            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next()) {
                    return true;
                }
            }

            try (PreparedStatement insertPs = con.prepareStatement(insertSql)) {
                insertPs.setInt(1, userId);
                return insertPs.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public Cart getCartByUserId(int userId) {
        String sql = "SELECT * FROM cart WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Cart cart = new Cart();
                    cart.setCartId(rs.getInt("cart_id"));
                    cart.setUserId(rs.getInt("user_id"));
                    cart.setCreatedAt(rs.getTimestamp("created_at"));
                    return cart;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean addToCart(CartItem cartItem) {
        String checkSql = "SELECT * FROM cart_items WHERE cart_id = ? AND product_id = ? AND product_size_id = ?";
        String updateSql = "UPDATE cart_items SET quantity = quantity + ? WHERE cart_item_id = ?";
        String insertSql = "INSERT INTO cart_items(cart_id, product_id, product_size_id, quantity) VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement checkPs = con.prepareStatement(checkSql)) {

            checkPs.setInt(1, cartItem.getCartId());
            checkPs.setInt(2, cartItem.getProductId());
            checkPs.setInt(3, cartItem.getProductSizeId());

            try (ResultSet rs = checkPs.executeQuery()) {
                if (rs.next()) {
                    int cartItemId = rs.getInt("cart_item_id");

                    try (PreparedStatement updatePs = con.prepareStatement(updateSql)) {
                        updatePs.setInt(1, cartItem.getQuantity());
                        updatePs.setInt(2, cartItemId);
                        return updatePs.executeUpdate() > 0;
                    }
                }
            }

            try (PreparedStatement insertPs = con.prepareStatement(insertSql)) {
                insertPs.setInt(1, cartItem.getCartId());
                insertPs.setInt(2, cartItem.getProductId());
                insertPs.setInt(3, cartItem.getProductSizeId());
                insertPs.setInt(4, cartItem.getQuantity());

                return insertPs.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean updateCartItemQuantity(int cartItemId, int quantity) {
        String sql = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean removeCartItem(int cartItemId) {
        String sql = "DELETE FROM cart_items WHERE cart_item_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartItemId);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<CartItem> getCartItemsByCartId(int cartId) {
        String sql = "SELECT ci.cart_item_id, ci.cart_id, ci.product_id, ci.product_size_id, ci.quantity, " +
                     "p.product_name, p.brand, p.price, p.image_url " +
                     "FROM cart_items ci " +
                     "JOIN products p ON ci.product_id = p.product_id " +
                     "WHERE ci.cart_id = ?";

        List<CartItem> cartItemList = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem cartItem = new CartItem();
                    cartItem.setCartItemId(rs.getInt("cart_item_id"));
                    cartItem.setCartId(rs.getInt("cart_id"));
                    cartItem.setProductId(rs.getInt("product_id"));
                    cartItem.setProductSizeId(rs.getInt("product_size_id"));
                    cartItem.setQuantity(rs.getInt("quantity"));
                    cartItem.setProductName(rs.getString("product_name"));
                    cartItem.setBrand(rs.getString("brand"));
                    cartItem.setPrice(rs.getDouble("price"));
                    cartItem.setImageUrl(rs.getString("image_url"));
                    cartItemList.add(cartItem);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cartItemList;
    }
    @Override
    public double getCartTotalAmount(int cartId) {
        String sql = "SELECT SUM(ci.quantity * p.price) AS total_amount " +
                     "FROM cart_items ci " +
                     "JOIN products p ON ci.product_id = p.product_id " +
                     "WHERE ci.cart_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("total_amount");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0.0;
    }
    @Override
    public boolean clearCart(int cartId) {
        String sql = "DELETE FROM cart_items WHERE cart_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            return ps.executeUpdate() >= 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}