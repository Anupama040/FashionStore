<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<html>
<head>
    <title>My Cart | FashionStore</title>
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

<main class="fs-cart-page">
    <div class="fs-container">
        <div class="fs-page-head">
            <p class="fs-page-kicker">Shopping Bag</p>
            <h1 class="fs-section-title">My Cart</h1>
        </div>

        <c:if test="${empty cartItemList}">
            <div class="fs-empty-cart">
                <p>Your cart is empty.</p>
                <a href="${pageContext.request.contextPath}/home" class="fs-btn-primary">Continue Shopping</a>
            </div>
        </c:if>

        <c:if test="${not empty cartItemList}">
            <div class="fs-cart-layout">

                <div class="fs-cart-items">
                    <c:forEach var="item" items="${cartItemList}">
                        <div class="fs-cart-card">
                            <div class="fs-cart-card-main">
                                <div class="fs-cart-image">
                                    <img src="${not empty item.imageUrl ? item.imageUrl : pageContext.request.contextPath.concat('/assets/images/placeholder.jpg')}"
                                         alt="${not empty item.productName ? item.productName : 'Cart Product'}">
                                </div>

                                <div class="fs-cart-info">
                                    <p class="fs-cart-brand">
                                        <c:choose>
                                            <c:when test="${not empty item.brand}">${item.brand}</c:when>
                                            <c:otherwise>FashionStore</c:otherwise>
                                        </c:choose>
                                    </p>

                                    <h3 class="fs-cart-product-name">
                                        <c:choose>
                                            <c:when test="${not empty item.productName}">
                                                ${item.productName}
                                            </c:when>
                                            <c:otherwise>
                                                Product #${item.productId}
                                            </c:otherwise>
                                        </c:choose>
                                    </h3>

                                    <div class="fs-cart-meta">
                                        <span>Product ID: ${item.productId}</span>
                                        <span>Size ID: ${item.productSizeId}</span>
                                        <span>Cart Item ID: ${item.cartItemId}</span>
                                    </div>

                                    <div class="fs-cart-qty-row">
                                        <span class="fs-cart-label">Quantity</span>
                                        <span class="fs-cart-value">${item.quantity}</span>
                                    </div>
                                </div>
                            </div>

                            <div class="fs-cart-side">
                                <p class="fs-cart-price">
                                    <c:choose>
                                        <c:when test="${item.price > 0}">
                                            ₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00" />
                                        </c:when>
                                        <c:otherwise>
                                            Price not available
                                        </c:otherwise>
                                    </c:choose>
                                </p>

                                <p class="fs-cart-subline">Review item before checkout</p>

                                <form action="${pageContext.request.contextPath}/cart" method="post" class="fs-remove-form">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="cartItemId" value="${item.cartItemId}">
                                    <button type="submit" class="fs-remove-btn"
                                            onclick="return confirm('Remove this item from cart?');">
                                        Remove
                                    </button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <aside class="fs-cart-summary">
                    <h2>Order Summary</h2>

                    <div class="fs-summary-row">
                        <span>Total Items</span>
                        <span>${cartItemList.size()}</span>
                    </div>

                    <div class="fs-summary-row">
                        <span>Total Amount</span>
                        <span>₹<fmt:formatNumber value="${totalAmount}" pattern="#,##0.00" /></span>
                    </div>

                    <div class="fs-summary-note">
                        Review your selected items before proceeding to checkout.
                    </div>

                    <a href="${pageContext.request.contextPath}/checkout" class="fs-btn-primary fs-summary-btn">Proceed to Checkout</a>
                    <a href="${pageContext.request.contextPath}/home" class="fs-secondary-btn fs-summary-btn">Continue Shopping</a>
                </aside>

            </div>
        </c:if>
    </div>
</main>

</body>
</html>