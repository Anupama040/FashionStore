package com.fashionstore.test;

import com.fashionstore.dao.impl.AdminDAOImpl;
import com.fashionstore.model.Admin;

public class CreateAdminTest {
    public static void main(String[] args) {
        AdminDAOImpl adminDAO = new AdminDAOImpl();
        
        // Create a default admin account
        Admin admin = new Admin();
        admin.setName("Admin User");
        admin.setEmail("admin@fashionstore.com");
        admin.setPassword("admin@123");
        
        try {
            if (adminDAO.addAdmin(admin)) {
                System.out.println("Admin created successfully!");
                System.out.println("Email: admin@fashionstore.com");
                System.out.println("Password: admin@123");
            } else {
                System.out.println("Failed to create admin or admin already exists");
            }
            
            // Try to login
            Admin loggedInAdmin = adminDAO.loginAdmin("admin@fashionstore.com", "admin@123");
            if (loggedInAdmin != null) {
                System.out.println("Login successful! Admin ID: " + loggedInAdmin.getAdminId());
            } else {
                System.out.println("Login failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
