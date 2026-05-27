# Controller to DAO Mapping Documentation

This document outlines the dependencies between the Controller layer (Servlets) and the Data Access Object (DAO) layer in the Fashion Store application.

## Overview

The Controller layer relies on the DAO layer to interact with the database. The table below specifies which Data Access Objects each Servlet initializes and utilizes to fulfill HTTP requests.

| Controller Servlet | DAO Dependencies | Primary Purpose |
| :--- | :--- | :--- |
| `RegisterServlet` | `UserDAO` | Handles new customer registrations. Checks if email exists and inserts user. |
| `LoginServlet` | `UserDAO` | Authenticates users against the database. |
| `HomeServlet` | `ProductDAO` | Retrieves featured, latest, or category-specific products to display on the homepage. |
| `ProductDetailsServlet` | `ProductDAO`, `ProductSizeDAO` | Fetches comprehensive details for a specific product, including available sizes and stock. |
| `CartServlet` | `CartDAO`, `ProductDAO`, `ProductSizeDAO` | Manages the user's shopping cart. Retrieves cart items, calculates totals, and fetches product/size metadata for display. |
| `CheckoutServlet` | `CartDAO` | Processes the cart before moving to the order placement stage. |
| `PlaceOrderServlet` | `CartDAO`, `OrderDAO` | Converts the active cart into a confirmed order. Clears the cart upon successful order creation. |
| `MyOrdersServlet` | `OrderDAO` | Retrieves the order history for the currently logged-in user. |
| `AdminLoginServlet` | `AdminDAO` | Authenticates administrators into the backend dashboard. |
| `AdminDashboardServlet` | `ProductDAO`, `OrderDAO`, `UserDAO` | Aggregates metrics for the admin dashboard (e.g., total products, total orders, total users). |
| `AdminAddProductServlet` | `ProductDAO`, `CategoryDAO`, `ProductSizeDAO` | Allows admins to create new products, fetch available categories, and define product sizes. |
| `AdminEditProductServlet` | `ProductDAO`, `ProductSizeDAO` | Handles updating existing product information and managing stock across different sizes. |
| `AdminManageProductsServlet` | `ProductDAO` | Lists all products in the admin panel for management purposes. |
| `AdminManageOrdersServlet` | `OrderDAO` | Lists all customer orders, allowing admins to update order statuses. |

## Flow Example: Cart Management

The `CartServlet` is an excellent example of cross-domain data aggregation:

1. Request comes to `CartServlet`.
2. It uses `CartDAO` to retrieve the active `Cart` for the user and the list of `CartItem`s.
3. It iterates through the `CartItem`s.
4. For each item, it might use `ProductDAO` to get the latest product name and image.
5. It uses `ProductSizeDAO` to fetch the specific size string (e.g., "M", "L", "XL") associated with the item's `productSizeId`.
6. This aggregated data is passed to the view (JSP) for rendering.
