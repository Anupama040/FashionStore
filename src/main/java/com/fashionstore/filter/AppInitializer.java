package com.fashionstore.filter;

import com.fashionstore.dao.impl.AdminDAOImpl;
import com.fashionstore.model.Admin;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        AdminDAOImpl adminDAO = new AdminDAOImpl();
        
        // Check if admin exists
        Admin existingAdmin = adminDAO.getAdminByEmail("admin@fashionstore.com");
        
        if (existingAdmin == null) {
            // Create default admin if not exists
            Admin admin = new Admin();
            admin.setName("Admin User");
            admin.setEmail("admin@fashionstore.com");
            admin.setPassword("admin@123");
            
            try {
                if (adminDAO.addAdmin(admin)) {
                    System.out.println("✓ Default admin created: admin@fashionstore.com / admin@123");
                } else {
                    System.out.println("Failed to create default admin");
                }
            } catch (Exception e) {
                System.err.println("Error creating admin: " + e.getMessage());
            }
        } else {
            System.out.println("✓ Admin already exists: " + existingAdmin.getEmail());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
