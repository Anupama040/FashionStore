package com.fashionstore.controller;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.OrderDAO;
import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.OrderDAOImpl;
import com.fashionstore.model.Cart;
import com.fashionstore.model.CartItem;
import com.fashionstore.model.Order;
import com.fashionstore.model.OrderItem;
import com.fashionstore.model.User;
import com.fashionstore.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/place-order")
public class PlaceOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO = new CartDAOImpl();
    private OrderDAO orderDAO = new OrderDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            User user = (User) session.getAttribute("loggedInUser");

            String shippingAddress = request.getParameter("shippingAddress");
            String paymentMethod = request.getParameter("paymentMethod");

            Cart cart = cartDAO.getCartByUserId(user.getUserId());

            if (cart == null) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            List<CartItem> cartItemList = cartDAO.getCartItemsByCartId(cart.getCartId());

            if (cartItemList == null || cartItemList.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            Order order = new Order();
            order.setUserId(user.getUserId());
            order.setShippingAddress(shippingAddress);
            order.setPaymentMethod(paymentMethod);
            order.setOrderStatus("PLACED");

            BigDecimal totalAmount = BigDecimal.ZERO;
            List<OrderItem> orderItems = new ArrayList<>();

            for (CartItem cartItem : cartItemList) {
                OrderItem orderItem = new OrderItem();
                orderItem.setProductId(cartItem.getProductId());
                orderItem.setProductSizeId(cartItem.getProductSizeId());
                orderItem.setQuantity(cartItem.getQuantity());

                BigDecimal itemPrice = getProductPrice(cartItem.getProductId());
                orderItem.setPrice(itemPrice);

                totalAmount = totalAmount.add(
                        itemPrice.multiply(BigDecimal.valueOf(cartItem.getQuantity()))
                );

                orderItems.add(orderItem);
            }

            order.setTotalAmount(totalAmount);

            boolean success = orderDAO.placeOrder(order, orderItems);

            if (success) {
                cartDAO.clearCart(cart.getCartId());
                session.setAttribute("lastPlacedOrder", order);
                response.sendRedirect(request.getContextPath() + "/order-success");
            } else {
                response.sendRedirect(request.getContextPath() + "/checkout");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/checkout");
        }
    }

    private BigDecimal getProductPrice(int productId) {
        String sql = "SELECT price FROM products WHERE product_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getBigDecimal("price");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return BigDecimal.ZERO;
    }
}