<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.fashionstore.model.Admin" %>
<%@ page import="com.fashionstore.model.Product" %>

<%
    Admin loggedInAdmin = (Admin) session.getAttribute("loggedInAdmin");
    if (loggedInAdmin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
        return;
    }

    List<Product> productList = (List<Product>) request.getAttribute("productList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Products | FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/main.css">
</head>
<body>

<header class="fs-header">
    <div class="fs-container fs-header-inner">
        <div class="fs-logo">FASHION<span>STORE</span></div>

        <nav class="fs-nav">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/products">Manage Products</a>
            <a href="${pageContext.request.contextPath}/admin/orders">Manage Orders</a>
            <a href="${pageContext.request.contextPath}/admin/logout">Logout</a>
        </nav>
    </div>
</header>

<main class="fs-products-section">
    <div class="fs-container">
        <h1 class="fs-section-title">Manage Products</h1>

        <div class="fs-products-topbar">
            <a href="${pageContext.request.contextPath}/admin/products/add" class="fs-btn-primary">Add New Product</a>
        </div>

        <div class="products-table-wrapper">
    <table class="products-table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Brand</th>
                <th>Price</th>
                <th>Category ID</th>
                <th>Stock</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            if (productList != null && !productList.isEmpty()) {
                for (Product product : productList) {
        %>
            <tr>
                <td><%= product.getProductId() %></td>
                <td><%= product.getProductName() %></td>
                <td><%= product.getBrand() %></td>
                <td><%= product.getPrice() %></td>
                <td><%= product.getCategoryId() %></td>
                <td><%= product.getStockQuantity() %></td>
                <td>
                    <img src="<%= request.getContextPath() + "/" + product.getImageUrl() %>"
                         alt="Product Image"
                         class="product-thumb">
                </td>
                <td>
                    <div class="action-links">
                        <a href="${pageContext.request.contextPath}/admin/products/edit?id=<%= product.getProductId() %>" class="edit-btn">Edit</a>
                        <a href="${pageContext.request.contextPath}/admin/products/delete?id=<%= product.getProductId() %>"
                           class="delete-btn"
                           onclick="return confirm('Are you sure you want to delete this product?');">Delete</a>
                    </div>
                </td>
            </tr>
        <%
                }
            } else {
        %>
            <tr>
                <td colspan="8" class="no-products">No products found.</td>
            </tr>
        <%
            }
        %>
        </tbody>
    </table>
	</div>
    </div>
</main>

</body>
</html>