<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<html>
<head>
    <title>My Orders | FashionStore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<header class="fs-header">
    <div class="fs-container fs-header-inner">
        <a href="home" class="fs-logo">FASHION<span>STORE</span></a>

        <nav class="fs-nav">
            <a href="home">Home</a>
            <a href="home?categoryId=1">Men</a>
            <a href="home?categoryId=2">Women</a>
            <a href="home?categoryId=3">Footwear</a>
            <a href="home?categoryId=4">Accessories</a>
            <a href="my-orders">My Orders</a>
        </nav>

        <div class="fs-header-right">
            <a href="cart" class="fs-cart-link">Cart</a>

            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <a href="logout" class="fs-header-btn">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="login" class="fs-header-btn">Login</a>
                    <a href="register" class="fs-header-btn">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<main class="fs-orders-page">
    <div class="fs-container">
        <div class="fs-page-head">
            <p class="fs-page-kicker">Order History</p>
            <h1 class="fs-section-title">My Orders</h1>
        </div>

        <c:if test="${not empty sessionScope.successMessage}">
            <div class="fs-alert fs-alert-success" style="padding: 10px; background-color: #d4edda; color: #155724; margin-bottom: 20px; border-radius: 4px;">
                ${sessionScope.successMessage}
                <c:remove var="successMessage" scope="session" />
            </div>
        </c:if>
        <c:if test="${not empty sessionScope.errorMessage}">
            <div class="fs-alert fs-alert-danger" style="padding: 10px; background-color: #f8d7da; color: #721c24; margin-bottom: 20px; border-radius: 4px;">
                ${sessionScope.errorMessage}
                <c:remove var="errorMessage" scope="session" />
            </div>
        </c:if>

        <c:if test="${empty orderList}">
            <div class="fs-empty-cart">
                <p>You have not placed any orders yet.</p>
                <a href="home" class="fs-btn-primary">Start Shopping</a>
            </div>
        </c:if>

        <c:if test="${not empty orderList}">
            <div class="fs-orders-list">
                <c:forEach var="order" items="${orderList}">
                    <div class="fs-order-card">
                        <div class="fs-order-main">
                            <div class="fs-order-row">
                                <span class="fs-order-label">Order ID</span>
                                <span class="fs-order-value">#${order.orderId}</span>
                            </div>

                            <div class="fs-order-row">
                                <span class="fs-order-label">Placed on</span>
                                <span class="fs-order-value">${order.orderDate}</span>
                            </div>

                            <div class="fs-order-row">
                                <span class="fs-order-label">Total Amount</span>
                                <span class="fs-order-value">₹${order.totalAmount}</span>
                            </div>
                        </div>

                        <div class="fs-order-side">
                            <span class="fs-order-status ${fn:toLowerCase(order.orderStatus)}">
                                ${order.orderStatus}
                            </span>
                            <c:if test="${order.orderStatus ne 'RETURNED' and order.orderStatus ne 'CANCELED'}">
                                <form action="return-order" method="post" style="margin-top: 10px; margin-bottom: 10px;">
                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                    <button type="submit" class="fs-btn-secondary" onclick="return confirm('Are you sure you want to return this order?');" style="padding: 5px 10px; font-size: 14px; cursor: pointer; border: 1px solid #ccc; border-radius: 4px; background-color: #f8f9fa;">Return Order</button>
                                </form>
                            </c:if>
                            <p class="fs-order-note">
                                This is a summary view. Item-level breakdown and tracking link
                                can be added later.
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>
</main>

</body>
</html>