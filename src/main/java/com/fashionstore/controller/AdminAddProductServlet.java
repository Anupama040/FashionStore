package com.fashionstore.controller;

import com.fashionstore.dao.ProductDAO;
import java.math.BigDecimal;
import com.fashionstore.dao.impl.ProductDAOImpl;
import com.fashionstore.model.Admin;
import com.fashionstore.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/admin/products/add")
public class AdminAddProductServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Admin loggedInAdmin = (session != null) ? (Admin) session.getAttribute("loggedInAdmin") : null;

        if (loggedInAdmin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/admin/add-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Admin loggedInAdmin = (session != null) ? (Admin) session.getAttribute("loggedInAdmin") : null;

        if (loggedInAdmin == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        try {
            String name = request.getParameter("productName");
            String brand = request.getParameter("brand");
            String priceStr = request.getParameter("price");
            String categoryIdStr = request.getParameter("categoryId");
            String stockStr = request.getParameter("stockQuantity");
            String imageUrl = request.getParameter("imageUrl");

            BigDecimal price = new BigDecimal(priceStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            int stockQuantity = Integer.parseInt(stockStr);

            Product product = new Product();
            product.setProductName(name);
            product.setBrand(brand);
            product.setPrice(price);
            product.setCategoryId(categoryId);
            product.setStockQuantity(stockQuantity);
            product.setImageUrl(imageUrl);

            productDAO.addProduct(product);

            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to add product. Please check the inputs.");
            request.getRequestDispatcher("/WEB-INF/views/admin/add-product.jsp").forward(request, response);
        }
    }
}