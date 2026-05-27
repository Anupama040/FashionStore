<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<header class="fs-header">
    <div class="fs-container fs-header-inner">
        <div class="fs-logo">FASHION<span>STORE</span></div>

        <nav class="fs-nav">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/login">User Login</a>
            <a href="${pageContext.request.contextPath}/register">Register</a>
        </nav>
    </div>
</header>

<main class="fs-products-section">
    <div class="fs-container" style="max-width: 500px;">
        <h1 class="fs-section-title">Admin Login</h1>

        <c:if test="${not empty errorMessage}">
            <p style="color: red; margin-bottom: 15px;">${errorMessage}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <div class="fs-form-group">
                <label for="email">Admin Email</label>
                <input type="email" id="email" name="email" required>
            </div>

            <div class="fs-form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit" class="fs-btn-primary">Login as Admin</button>
        </form>
    </div>
</main>

</body>
</html>