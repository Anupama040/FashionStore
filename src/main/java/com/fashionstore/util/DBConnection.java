package com.fashionstore.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection {

    private static String url;
    private static String username;
    private static String password;
    private static String driver;

    static {
        try {
            Properties properties = new Properties();
            InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties");

            if (input == null) {
                throw new RuntimeException("db.properties file not found in src/main/resources");
            }

            properties.load(input);

            url = System.getenv("DB_URL") != null ? System.getenv("DB_URL") : properties.getProperty("db.url");
            username = System.getenv("DB_USERNAME") != null ? System.getenv("DB_USERNAME") : properties.getProperty("db.username");
            password = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : properties.getProperty("db.password");
            driver = properties.getProperty("db.driver");

            Class.forName(driver);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}