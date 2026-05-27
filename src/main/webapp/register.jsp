<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Register | FashionStore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<header class="fs-header">
    <div class="fs-container fs-header-inner">
        <a href="${pageContext.request.contextPath}/home" class="fs-logo">FASHION<span>STORE</span></a>

       

        <div class="fs-header-right">
            <a href="${pageContext.request.contextPath}/login" class="fs-header-btn">Login</a>
        </div>
    </div>
</header>

<main class="fs-auth-page">
    <div class="fs-container fs-auth-layout">
        <section class="fs-auth-card">
            <p class="fs-page-kicker">Join FashionStore</p>
            <h1 class="fs-section-title">Create Account</h1>

            <p class="fs-auth-subtitle">
                Create your account to shop faster, manage orders, and save your details.
            </p>

            <c:if test="${not empty errorMessage}">
                <div class="fs-auth-error">
                    ${errorMessage}
                </div>
            </c:if>

            <c:if test="${not empty successMessage}">
                <div class="fs-auth-success">
                    ${successMessage}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post" class="fs-auth-form">
                <div class="fs-form-group">
                    <label for="fullName">Full Name</label>
                    <input
                            type="text"
                            id="fullName"
                            name="fullName"
                            required
                            autocomplete="name"
                            placeholder="Enter your full name">
                </div>

                <div class="fs-form-group">
                    <label for="email">Email</label>
                    <input
                            type="email"
                            id="email"
                            name="email"
                            required
                            autocomplete="email"
                            placeholder="Enter your email">
                </div>

                <div class="fs-form-group">
                    <label for="password">Password</label>
                    <input
                            type="password"
                            id="password"
                            name="password"
                            required
                            autocomplete="new-password"
                            placeholder="Create a password">
                </div>

                <div class="fs-form-group">
                    <label for="phone">Phone</label>
                    <input
                            type="text"
                            id="phone"
                            name="phone"
                            required
                            autocomplete="tel"
                            placeholder="Enter your phone number">
                </div>

                <div class="fs-form-group">
                    <label for="address">Address</label>
                    <textarea
                            id="address"
                            name="address"
                            rows="4"
                            required
                            autocomplete="street-address"
                            placeholder="Enter your full delivery address"></textarea>
                </div>

                <button type="submit" class="fs-btn-primary fs-btn-full">Create Account</button>
            </form>

            <p class="fs-auth-footer">
                Already have an account?
                <a href="${pageContext.request.contextPath}/login">Login here</a>
            </p>
        </section>

        <section class="fs-auth-side">
            <h2>Why create an account?</h2>
            <ul>
                <li>Place orders faster with saved details.</li>
                <li>Track your orders anytime.</li>
                <li>Manage your shopping journey in one place.</li>
            </ul>
        </section>
    </div>
</main>

</body>
</html>