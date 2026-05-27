<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>${product.productName} | FashionStore</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<header class="fs-header">
    <div class="fs-container fs-header-inner">
        <a href="${pageContext.request.contextPath}/home" class="fs-logo">FASHION<span>STORE</span></a>

        <nav class="fs-nav">
            <a href="${pageContext.request.contextPath}/home">Home</a>
            <a href="${pageContext.request.contextPath}/home?categoryId=1">Men</a>
            <a href="${pageContext.request.contextPath}/home?categoryId=2">Women</a>
            <a href="${pageContext.request.contextPath}/home?categoryId=3">Footwear</a>
            <a href="${pageContext.request.contextPath}/home?categoryId=4">Accessories</a>
        </nav>

        <div class="fs-header-right">
            <a href="${pageContext.request.contextPath}/cart" class="fs-cart-link">Cart</a>

            <c:choose>
                <c:when test="${not empty sessionScope.loggedInUser}">
                    <a href="${pageContext.request.contextPath}/my-orders" class="fs-header-btn">My Orders</a>
                    <a href="${pageContext.request.contextPath}/logout" class="fs-header-btn">Logout</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login" class="fs-header-btn">Login</a>
                    <a href="${pageContext.request.contextPath}/register" class="fs-header-btn">Register</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<main class="fs-product-page">
    <div class="fs-container">

        <c:if test="${not empty product}">
            <div class="fs-breadcrumb">
                <a href="${pageContext.request.contextPath}/home">Home</a>
                <span>/</span>
                <a href="${pageContext.request.contextPath}/home">Products</a>
                <span>/</span>
                <span>${product.productName}</span>
            </div>

            <div class="fs-product-layout">
                <div class="fs-product-gallery">
                    <img src="${product.imageUrl}" alt="${product.productName}">
                </div>

                <div class="fs-product-info">
                    <p class="fs-product-brand">${product.brand}</p>

                    <h1 class="fs-product-title">${product.productName}</h1>

                    <p class="fs-product-price">₹${product.price}</p>
                    <span class="fs-product-tag">Premium Pick</span>

                    <p class="fs-product-description">
                        ${product.description}
                    </p>

                    <form action="${pageContext.request.contextPath}/cart" method="post">
                        <input type="hidden" name="productId" value="${product.productId}">

                        <div class="fs-size-block">
                            <h3>Select Size</h3>
                            <p>Choose your preferred fit</p>

                            <div class="fs-size-options">
                                <c:forEach var="s" items="${sizeList}">
                                    <label class="fs-size-option">
                                        <input type="radio" name="productSizeId" value="${s.productSizeId}" required>
                                        <span>${s.size}</span>
                                    </label>
                                </c:forEach>
                            </div>
                        </div>

                        <div class="fs-qty-block">
                            <label for="quantity">Quantity</label>
                            <input type="number" id="quantity" name="quantity" value="1" min="1" required>
                        </div>

                        <div class="fs-product-actions">
                            <button type="submit" class="fs-btn-primary">Add to Cart</button>
                            <a href="${pageContext.request.contextPath}/cart" class="fs-secondary-btn">Go to Cart</a>
                        </div>
                    </form>
                </div>
            </div>
        </c:if>

        <c:if test="${empty product}">
            <div class="fs-empty-state">
                <p>Product not found.</p>
            </div>
        </c:if>

    </div>
</main>

</body>
</html>