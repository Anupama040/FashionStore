<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>FashionStore | Spring Collection</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
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
        </nav>

        <div class="fs-header-right">
            <a href="cart" class="fs-cart-link">Cart</a>

            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <a href="my-orders" class="fs-header-btn">My Orders</a>
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

<main>
    <section class="fs-hero">
        <div class="fs-container">
            <div class="fs-hero-inner">
                <div class="fs-hero-left">
                    <p class="fs-hero-subtitle">New Season Arrivals</p>
                    <h1 class="fs-hero-title">STYLE THAT FEELS EFFORTLESS</h1>
                    <p class="fs-hero-text">
                        Discover premium fashion essentials curated for everyday confidence,
                        modern comfort, and standout seasonal style.
                    </p>
                    <a href="#products" class="fs-btn-primary">Shop Collection</a>
                </div>

                <div class="fs-hero-right">
                    <img src="${pageContext.request.contextPath}/assets/images/pla.jpg"
                         alt="Featured fashion collection"
                         class="fs-hero-image">
                </div>
            </div>
        </div>
    </section>

    <section class="fs-category-strip">
        <div class="fs-container fs-category-inner">
            <span class="fs-category-label">Browse by category</span>

            <a href="home" class="fs-chip ${empty param.categoryId ? 'active' : ''}">All</a>
            <a href="home?categoryId=1" class="fs-chip ${param.categoryId == '1' ? 'active' : ''}">Men</a>
            <a href="home?categoryId=2" class="fs-chip ${param.categoryId == '2' ? 'active' : ''}">Women</a>
            <a href="home?categoryId=3" class="fs-chip ${param.categoryId == '3' ? 'active' : ''}">Footwear</a>
            <a href="home?categoryId=4" class="fs-chip ${param.categoryId == '4' ? 'active' : ''}">Accessories</a>
        </div>
    </section>

    <section id="products" class="fs-products-section">
        <div class="fs-container">
            <h2 class="fs-section-title">Featured Products</h2>

            <c:if test="${empty productList}">
                <div class="fs-empty-state">
                    <p>No products found for this category right now.</p>
                </div>
            </c:if>

            <c:if test="${not empty productList}">
                <div class="fs-product-grid">
                    <c:forEach var="p" items="${productList}">
                        <div class="fs-product-card">
                            <a href="product-details?productId=${p.productId}" class="fs-product-link">
                                <div class="fs-product-image-wrapper">
                                    <img src="${p.imageUrl}" alt="${p.productName}">
                                </div>
                            </a>

                            <div class="fs-product-info">
                                <p class="fs-product-brand">${p.brand}</p>

                                <h3 class="fs-product-name">
                                    <a href="product-details?productId=${p.productId}">
                                        ${p.productName}
                                    </a>
                                </h3>

                                <p class="fs-product-price">₹${p.price}</p>

                                <div class="fs-product-action">
                                    <a href="product-details?productId=${p.productId}" class="fs-product-btn">
                                        View Details
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>
        </div>
    </section>
</main>

</body>
</html>