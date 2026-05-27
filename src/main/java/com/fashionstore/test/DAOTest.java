package com.fashionstore.test;

import com.fashionstore.dao.impl.*;
import com.fashionstore.model.*;

import java.util.List;

public class DAOTest {
    public static void main(String[] args) {

        CategoryDAOImpl categoryDAO = new CategoryDAOImpl();
        ProductDAOImpl productDAO = new ProductDAOImpl();
        ProductSizeDAOImpl productSizeDAO = new ProductSizeDAOImpl();
        UserDAOImpl userDAO = new UserDAOImpl();
        AdminDAOImpl adminDAO = new AdminDAOImpl();
        CartDAOImpl cartDAO = new CartDAOImpl();
        OrderDAOImpl orderDAO = new OrderDAOImpl();

        try {
            System.out.println("===== CATEGORY DAO TEST =====");
            System.out.println(categoryDAO.getAllCategories());

            System.out.println("===== PRODUCT DAO TEST =====");
            System.out.println(productDAO.getAllProducts());
            System.out.println(productDAO.getProductById(1));
            System.out.println(productDAO.getProductsByCategory(1));

            System.out.println("===== PRODUCT SIZE DAO TEST =====");
            System.out.println(productSizeDAO.getProductSizeById(1));
            System.out.println(productSizeDAO.getSizesByProductId(1));

            System.out.println("===== USER DAO TEST =====");
            System.out.println(userDAO.getUserById(1));
            System.out.println(userDAO.getUserByEmail("anupama@gmail.com"));

            System.out.println("===== ADMIN DAO TEST =====");
            System.out.println(adminDAO.getAdminByEmail("admin@fashionstore.com"));

            System.out.println("===== CART DAO TEST =====");
            Cart cart = cartDAO.getCartByUserId(1);
            if (cart != null) {
                System.out.println("Cart ID: " + cart.getCartId());
                List<CartItem> cartItems = cartDAO.getCartItemsByCartId(cart.getCartId());
                System.out.println(cartItems);
            } else {
                System.out.println("Cart not found");
            }

            System.out.println("===== ORDER DAO TEST =====");
            System.out.println(orderDAO.getOrderById(1));
            System.out.println(orderDAO.getOrdersByUserId(1));
            System.out.println(orderDAO.getOrderItemsByOrderId(1));

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}