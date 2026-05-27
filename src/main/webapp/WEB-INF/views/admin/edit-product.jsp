<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.fashionstore.model.Admin" %>
<%@ page import="com.fashionstore.model.Product" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    Admin loggedInAdmin = (Admin) session.getAttribute("loggedInAdmin");
    if (loggedInAdmin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    Product product = (Product) request.getAttribute("product");
    if (product == null) {
        response.sendRedirect(request.getContextPath() + "/admin/products");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Product | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<header class="fs-header">
    <div class="fs-container fs-header-inner">
        <div class="fs-logo">FASHION<span>STORE</span></div>

        <nav class="fs-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/products" class="fs-nav-active">Manage Products</a>
            <a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
            <a href="${pageContext.request.contextPath}/admin/logout">Logout</a>
        </nav>
    </div>
</header>

<main class="fs-products-section">
    <div class="fs-container">
        <h1 class="fs-section-title">Edit Product</h1>

        <c:if test="${not empty errorMessage}">
            <p style="color: red; margin-bottom: 15px;">${errorMessage}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/products/edit" method="post"
              style="background-color: #fff; padding: 20px; border-radius: 10px; border: 1px solid #ddd; max-width: 600px;">

            <input type="hidden" name="productId" value="<%= product.getProductId() %>">

            <div style="margin-bottom: 12px;">
                <label for="productName">Product Name</label><br>
                <input type="text" id="productName" name="productName" required style="width: 100%;"
                       value="<%= product.getProductName() %>">
            </div>

            <div style="margin-bottom: 12px;">
                <label for="brand">Brand</label><br>
                <input type="text" id="brand" name="brand" required style="width: 100%;"
                       value="<%= product.getBrand() %>">
            </div>

            <div style="margin-bottom: 12px;">
                <label for="price">Price</label><br>
                <input type="number" step="0.01" id="price" name="price" required style="width: 100%;"
                       value="<%= product.getPrice() %>">
            </div>

            <div style="margin-bottom: 12px;">
                <label for="categoryId">Category ID</label><br>
                <input type="number" id="categoryId" name="categoryId" required style="width: 100%;"
                       value="<%= product.getCategoryId() %>">
            </div>

            <div style="margin-bottom: 12px;">
                <label for="stockQuantity">Stock Quantity</label><br>
                <input type="number" id="stockQuantity" name="stockQuantity" required style="width: 100%;"
                       value="<%= product.getStockQuantity() %>">
            </div>

            <div style="margin-bottom: 16px;">
                <label for="imageUrl">Image URL or File Path</label><br>
                <input type="text" id="imageUrl" name="imageUrl" required style="width: 100%;"
                       value="<%= product.getImageUrl() %>">
            </div>

            <button type="submit" class="fs-btn-primary">Update Product</button>
            <a href="${pageContext.request.contextPath}/admin/products" class="fs-secondary-btn" style="margin-left: 10px;">
                Cancel
            </a>
        </form>
    </div>
</main>

</body>
</html>