<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fashionstore.model.Admin" %>

<%
    Admin loggedInAdmin = (Admin) session.getAttribute("loggedInAdmin");
    if (loggedInAdmin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<header class="fs-header">
    <div class="fs-container fs-header-inner">
        <div class="fs-logo">FASHION<span>STORE</span></div>

        <nav class="fs-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/products">Manage Products</a>
            <a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
            <a href="${pageContext.request.contextPath}/admin/logout">Logout</a>
        </nav>
    </div>
</header>

<main class="fs-products-section">
    <div class="fs-container">
        <h1 class="fs-section-title">Admin Dashboard</h1>

        <p style="margin-bottom: 25px;">
            Welcome, <strong><%= loggedInAdmin.getName() %></strong>
        </p>

        <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px;">
            
            <div style="border: 1px solid #ddd; padding: 20px; border-radius: 10px; background-color: #fff;">
                <h3 style="margin-bottom: 10px;">Manage Products</h3>
                <p style="margin-bottom: 15px;">Add, update, delete, and view all products.</p>
                <a href="${pageContext.request.contextPath}/admin/products" class="fs-btn-primary">Go to Products</a>
            </div>

            <div style="border: 1px solid #ddd; padding: 20px; border-radius: 10px; background-color: #fff;">
                <h3 style="margin-bottom: 10px;">Manage Orders</h3>
                <p style="margin-bottom: 15px;">View customer orders and update order status.</p>
                <a href="${pageContext.request.contextPath}/admin/orders" class="fs-btn-primary">Go to Orders</a>
            </div>

        </div>
    </div>
</main>

</body>
</html>