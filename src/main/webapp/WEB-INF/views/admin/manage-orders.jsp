<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionstore.model.Admin" %>
<%@ page import="com.fashionstore.model.Order" %>

<%
    Admin loggedInAdmin = (Admin) session.getAttribute("loggedInAdmin");
    if (loggedInAdmin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    List<Order> orderList = (List<Order>) request.getAttribute("orderList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Orders | FashionStore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<header class="fs-header">
    <div class="fs-container fs-header-inner">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="fs-logo">FASHION<span>STORE</span></a>

        <nav class="fs-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/products">Manage Products</a>
            <a href="${pageContext.request.contextPath}/admin/orders" class="fs-nav-active">Manage Orders</a>
            <a href="${pageContext.request.contextPath}/admin/logout">Logout</a>
        </nav>
    </div>
</header>

<main class="fs-admin-page">
    <div class="fs-container">
        <div class="fs-admin-header">
            <div>
                <p class="fs-page-kicker">Admin · Orders</p>
                <h1 class="fs-section-title">Manage Orders</h1>
                <p class="fs-admin-subtitle">
                    View and track all customer orders placed on FashionStore.
                </p>
            </div>
        </div>

        <div class="fs-admin-card">
            <div class="fs-admin-table-header">
                <h2>All Orders</h2>
                <p class="fs-admin-table-meta">
                    Total orders: <strong><%= (orderList != null ? orderList.size() : 0) %></strong>
                </p>
            </div>

            <div class="fs-table-wrapper">
                <table class="fs-table">
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>User ID</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Shipping Address</th>
                        <th>Order Date</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        if (orderList != null && !orderList.isEmpty()) {
                            for (Order order : orderList) {
                    %>
                    <tr>
                        <td>#<%= order.getOrderId() %></td>
                        <td><%= order.getUserId() %></td>
                        <td>₹<%= order.getTotalAmount() %></td>
                        <td>
                            <span class="fs-order-status <%= order.getOrderStatus().toLowerCase() %>">
                                <%= order.getOrderStatus() %>
                            </span>
                        </td>
                        <td class="fs-table-address">
                            <%= order.getShippingAddress() %>
                        </td>
                        <td><%= order.getOrderDate() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="6" class="fs-table-empty">
                            No orders found.
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</main>

</body>
</html>