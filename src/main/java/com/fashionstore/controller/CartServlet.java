package com.fashionstore.controller;

import com.fashionstore.dao.CartDAO;
import com.fashionstore.dao.ProductDAO;
import com.fashionstore.dao.ProductSizeDAO;
import com.fashionstore.dao.impl.CartDAOImpl;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.dao.impl.ProductSizeDAOImpl;
import com.fashionstore.model.Cart;
import com.fashionstore.model.CartItem;
import com.fashionstore.model.Product;
import com.fashionstore.model.ProductSize;
import com.fashionstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private CartDAO cartDAO = new CartDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();
    private ProductSizeDAO productSizeDAO = new ProductSizeDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");

        Cart cart = cartDAO.getCartByUserId(user.getUserId());

        if (cart == null) {
            cartDAO.createCart(user.getUserId());
            cart = cartDAO.getCartByUserId(user.getUserId());
        }

        List<CartItem> cartItemList = cartDAO.getCartItemsByCartId(cart.getCartId());
        double totalAmount = cartDAO.getCartTotalAmount(cart.getCartId());

        request.setAttribute("cart", cart);
        request.setAttribute("cartItemList", cartItemList);
        request.setAttribute("totalAmount", totalAmount);

        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            User user = (User) session.getAttribute("loggedInUser");

            String action = request.getParameter("action");

            // REMOVE FROM CART
            if ("remove".equals(action)) {
                String cartItemIdParam = request.getParameter("cartItemId");

                if (cartItemIdParam != null && !cartItemIdParam.isEmpty()) {
                    int cartItemId = Integer.parseInt(cartItemIdParam);
                    cartDAO.removeCartItem(cartItemId);
                }

                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            // ADD TO CART
            String productIdParam = request.getParameter("productId");
            String productSizeIdParam = request.getParameter("productSizeId");
            String quantityParam = request.getParameter("quantity");

            if (productIdParam == null || productSizeIdParam == null || quantityParam == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            int productId = Integer.parseInt(productIdParam);
            int productSizeId = Integer.parseInt(productSizeIdParam);
            int quantity = Integer.parseInt(quantityParam);

            Product product = productDAO.getProductById(productId);
            ProductSize productSize = productSizeDAO.getProductSizeById(productSizeId);

            if (product == null || productSize == null || quantity <= 0) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }

            Cart cart = cartDAO.getCartByUserId(user.getUserId());

            if (cart == null) {
                cartDAO.createCart(user.getUserId());
                cart = cartDAO.getCartByUserId(user.getUserId());
            }

            CartItem cartItem = new CartItem();
            cartItem.setCartId(cart.getCartId());
            cartItem.setProductId(productId);
            cartItem.setProductSizeId(productSizeId);
            cartItem.setQuantity(quantity);

            boolean status = cartDAO.addToCart(cartItem);

            if (status) {
                response.sendRedirect(request.getContextPath() + "/cart");
            } else {
                response.sendRedirect(request.getContextPath() + "/product-details?productId=" + productId);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}