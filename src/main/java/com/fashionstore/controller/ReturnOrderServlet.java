package com.fashionstore.controller;

import com.fashionstore.dao.OrderDAO;
import com.fashionstore.dao.impl.OrderDAOImpl;
import com.fashionstore.model.Order;
import com.fashionstore.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/return-order")
public class ReturnOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
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
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            
            Order order = orderDAO.getOrderById(orderId);
            
            if (order != null && order.getUserId() == user.getUserId()) {
                if (!"RETURNED".equalsIgnoreCase(order.getOrderStatus()) &&
                    !"CANCELED".equalsIgnoreCase(order.getOrderStatus())) {
                    
                    boolean success = orderDAO.updateOrderStatus(orderId, "RETURNED");
                    if (success) {
                        request.getSession().setAttribute("successMessage", "Order #" + orderId + " has been successfully returned.");
                    } else {
                        request.getSession().setAttribute("errorMessage", "Failed to return Order #" + orderId + ".");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "An error occurred while processing your request.");
        }
        
        response.sendRedirect(request.getContextPath() + "/my-orders");
    }
}
