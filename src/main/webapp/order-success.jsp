<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fashionstore.model.User" %>
<%@ page import="com.fashionstore.model.Order" %>

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }

    Order order = (Order) request.getAttribute("lastPlacedOrder");
    if (order == null) {
        response.sendRedirect(request.getContextPath() + "/home");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<header class="fs-header">
    <div class="fs-container fs-header-inner">
        <a href="${pageContext.request.contextPath}/home" class="fs-logo">FASHION<span>STORE</span></a>

        <nav class="fs-nav">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/my-orders">My Orders</a>
            <a href="${pageContext.request.contextPath}/cart">Cart</a>
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </nav>
    </div>
</header>

<main class="fs-success-page">
    <div class="fs-container">
        <div class="fs-success-card">
            <div class="fs-success-icon">✓</div>

            <p class="fs-page-kicker">Order Confirmed</p>
            <h1 class="fs-section-title">Order Placed Successfully</h1>

            <p class="fs-success-subtitle">
                Thank you, <strong><%= loggedInUser.getFullName() %></strong>. Your order has been placed successfully and is now being processed.
            </p>

            <div class="fs-success-grid">
                <div class="fs-success-info-card">
                    <h2>Order Details</h2>

                    <div class="fs-success-row">
                        <span>Order ID</span>
                        <span>#<%= order.getOrderId() %></span>
                    </div>

                    <div class="fs-success-row">
                        <span>Total Amount</span>
                        <span>₹<%= order.getTotalAmount() %></span>
                    </div>

                    <div class="fs-success-row">
                        <span>Payment Method</span>
                        <span><%= order.getPaymentMethod() %></span>
                    </div>

                    <div class="fs-success-row">
                        <span>Order Date</span>
                        <span><%= order.getOrderDate() %></span>
                    </div>

                    <div class="fs-success-row">
                        <span>Status</span>
                        <span class="fs-order-status confirmed"><%= order.getOrderStatus() %></span>
                    </div>
                </div>

                <div class="fs-success-info-card">
                    <h2>Delivery Information</h2>

                    <div class="fs-success-address">
                        <%= order.getShippingAddress() %>
                    </div>

                    <div class="fs-success-note">
                        You can check current status anytime from your orders page.
                    </div>

                    <div class="fs-success-points">
                        <div class="fs-feature-item">Order confirmation completed</div>
                        <div class="fs-feature-item">Track updates from My Orders</div>
                        <div class="fs-feature-item">Continue shopping anytime</div>
                    </div>
                </div>
            </div>

            <div class="fs-success-actions">
                <a href="${pageContext.request.contextPath}/my-orders" class="fs-btn-primary">View My Orders</a>
                <a href="${pageContext.request.contextPath}/home" class="fs-secondary-btn">Continue Shopping</a>
            </div>
        </div>
    </div>
</main>

</body>
</html>