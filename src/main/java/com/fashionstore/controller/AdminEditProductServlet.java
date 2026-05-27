package com.fashionstore.controller;

import com.fashionstore.dao.ProductDAO;
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
import java.math.BigDecimal;

@WebServlet("/admin/products/edit")
public class AdminEditProductServlet extends HttpServlet {
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

        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        int productId = Integer.parseInt(idParam);
        Product product = productDAO.getProductById(productId);

        if (product == null) {
            response.sendRedirect(request.getContextPath() + "/admin/products");
            return;
        }

        request.setAttribute("product", product);
        request.getRequestDispatcher("/WEB-INF/views/admin/edit-product.jsp").forward(request, response);
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
            int productId = Integer.parseInt(request.getParameter("productId"));

            String name = request.getParameter("productName");
            String brand = request.getParameter("brand");
            String priceStr = request.getParameter("price");
            String categoryIdStr = request.getParameter("categoryId");
            String stockStr = request.getParameter("stockQuantity");
            String imageUrl = request.getParameter("imageUrl");

            BigDecimal price = new BigDecimal(priceStr);
            int categoryId = Integer.parseInt(categoryIdStr);
            int stockQuantity = Integer.parseInt(stockStr);

            Product product = productDAO.getProductById(productId);
            if (product == null) {
                response.sendRedirect(request.getContextPath() + "/admin/products");
                return;
            }

            product.setProductName(name);
            product.setBrand(brand);
            product.setPrice(price);
            product.setCategoryId(categoryId);
            product.setStockQuantity(stockQuantity);
            product.setImageUrl(imageUrl);

            productDAO.updateProduct(product);

            response.sendRedirect(request.getContextPath() + "/admin/products");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to update product. Please check the inputs.");
            // keep the user on the same page
            doGet(request, response);
        }
    }
}