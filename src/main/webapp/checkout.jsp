<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Checkout | FashionStore</title>
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

<main class="fs-checkout-page">
    <div class="fs-container">
        <div class="fs-page-head">
            <p class="fs-page-kicker">Secure Checkout</p>
            <h1 class="fs-section-title">Complete Your Order</h1>
        </div>

        <div class="fs-checkout-layout">
            <section class="fs-checkout-card">
                <form action="place-order" method="post" class="fs-checkout-form">

                    <div class="fs-checkout-block">
                        <div class="fs-form-label-row">
                            <h2 class="fs-checkout-heading">Shipping Address</h2>
                            <span class="fs-form-note">Enter your delivery details carefully</span>
                        </div>

                        <div class="fs-form-group">
                            <label for="shippingAddress">Full Shipping Address</label>
                            <textarea id="shippingAddress"
                                      name="shippingAddress"
                                      rows="5"
                                      placeholder="House number, street, area, city, state, pincode"
                                      required></textarea>
                        </div>
                    </div>

                    <div class="fs-checkout-block">
                        <div class="fs-form-label-row">
                            <h2 class="fs-checkout-heading">Payment Method</h2>
                            <span class="fs-form-note">Choose your preferred payment option</span>
                        </div>

                        <div class="fs-form-group">
                            <label for="paymentMethod">Select Payment Method</label>
                            <select id="paymentMethod" name="paymentMethod" required>
                                <option value="">Select Payment Method</option>
                                <option value="COD">Cash on Delivery</option>
                                <option value="UPI">UPI</option>
                                <option value="CARD">Credit / Debit Card</option>
                            </select>
                        </div>
                    </div>

                    <div class="fs-checkout-actions">
                        <button type="submit" class="fs-btn-primary fs-btn-full">Place Order</button>
                        <a href="cart" class="fs-secondary-btn fs-btn-full">Back to Cart</a>
                    </div>
                </form>
            </section>

            <aside class="fs-checkout-summary">
                <h2>Order Summary</h2>

                <div class="fs-summary-row">
                    <span>Checkout Type</span>
                    <span>Single Step</span>
                </div>

                <div class="fs-summary-row">
                    <span>Payment Options</span>
                    <span>COD / UPI / Card</span>
                </div>

                <div class="fs-summary-note">
                    Review your address and payment method before placing the order. Final order totals and item breakdown can be added here once the backend sends cart summary data.
                </div>

                <div class="fs-checkout-points">
                    <div class="fs-feature-item">Fast and clear checkout flow</div>
                    <div class="fs-feature-item">Flexible payment method selection</div>
                    <div class="fs-feature-item">Easy return to cart before confirmation</div>
                </div>
            </aside>
        </div>
    </div>
</main>

</body>
</html>