<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login | FashionStore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Main CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">

    <!-- Google Font (optional for better look) -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
</head>

<body>

<!-- Header -->
<header class="fs-header">
    <div class="fs-container fs-header-inner">
        <a href="${pageContext.request.contextPath}/home" class="fs-logo">
            FASHION<span>STORE</span>
        </a>

        

        <div class="fs-header-right">
            <a href="${pageContext.request.contextPath}/register" class="fs-header-btn">
                Create Account
            </a>
        </div>
    </div>
</header>

<!-- Main -->
<main class="fs-auth-page">
    <div class="fs-container fs-auth-layout">

        <!-- LEFT: LOGIN CARD -->
        <section class="fs-auth-card">

            <p class="fs-page-kicker">Welcome back</p>
            <h1 class="fs-section-title">Sign in to your account</h1>

            <p class="fs-auth-subtitle">
                Enter your credentials to access your account, track orders, and continue shopping.
            </p>

            <!-- Error -->
            <c:if test="${not empty errorMessage}">
                <div class="fs-auth-error">
                    ${errorMessage}
                </div>
            </c:if>

            <!-- Success -->
            <c:if test="${not empty successMessage}">
                <div class="fs-auth-success">
                    ${successMessage}
                </div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/login" method="post" class="fs-auth-form">

                <div class="fs-form-group">
                    <label for="email">Email address</label>
                    <input
                        type="email"
                        id="email"
                        name="email"
                        required
                        autocomplete="email"
                        placeholder="example@email.com">
                </div>

                <div class="fs-form-group">
                    <label for="password">Password</label>
                    <input
                        type="password"
                        id="password"
                        name="password"
                        required
                        autocomplete="current-password"
                        placeholder="Enter your password">
                </div>

                <button type="submit" class="fs-btn-primary fs-btn-full">
                    Login
                </button>
            </form>

            <p class="fs-auth-footer">
                Don’t have an account?
                <a href="${pageContext.request.contextPath}/register">Sign up</a>
            </p>

        </section>

        <!-- RIGHT: INFO PANEL -->
        <section class="fs-auth-side">
            <h2>Why join FashionStore?</h2>

            <ul>
                <li>🛍️ Save your favorite products</li>
                <li>📦 Track orders in real-time</li>
                <li>⚡ Faster checkout experience</li>
                <li>🧾 Access complete purchase history</li>
            </ul>
        </section>

    </div>
</main>

</body>
</html>