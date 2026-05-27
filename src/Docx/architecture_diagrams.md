# Architecture Diagrams

## MVC Architecture Overview

The Fashion Store application follows a standard Model-View-Controller (MVC) architecture pattern:

```mermaid
flowchart TD
    Client[Web Browser / Client] -->|HTTP Request| Controller[Controller Layer\nServlets]
    Controller -->|Use| DAO[DAO Layer\nData Access Objects]
    DAO -->|CRUD Operations| Database[(Relational Database)]
    Database -->|Result Sets| DAO
    DAO -->|Map to| Model[Model Layer\nJava Beans/POJOs]
    Controller -->|Pass Model Data| View[View Layer\nJSP Pages]
    View -->|HTTP Response| Client
```

### Components:
- **Model**: Represents the application data and business rules (`com.fashionstore.model`).
- **View**: Presents the data to the user, typically implemented using JSP and HTML in `src/main/webapp`.
- **Controller**: Servlets in `com.fashionstore.controller` that handle user requests, process them using DAOs, and forward the request to the appropriate View.
- **DAO Layer**: Interfaces and implementation classes in `com.fashionstore.dao` abstracting the database logic using JDBC.

## Class Diagram

The following diagram illustrates the primary model classes and their relationships:

```mermaid
classDiagram
    class User {
        -int userId
        -String fullName
        -String email
        -String password
        -String phone
        -String address
        -Timestamp createdAt
    }

    class Admin {
        -int adminId
        -String name
        -String email
        -String password
        -Timestamp createdAt
    }

    class Category {
        -int categoryId
        -String categoryName
        -String description
    }

    class Product {
        -int productId
        -int categoryId
        -String productName
        -String brand
        -String description
        -BigDecimal price
        -String imageUrl
        -int stockQuantity
        -Timestamp createdAt
    }

    class ProductSize {
        -int productSizeId
        -int productId
        -String size
        -int stockQuantity
    }

    class Cart {
        -int cartId
        -int userId
        -Timestamp createdAt
    }

    class CartItem {
        -int cartItemId
        -int cartId
        -int productId
        -int productSizeId
        -int quantity
    }

    class Order {
        -int orderId
        -int userId
        -BigDecimal totalAmount
        -String orderStatus
        -String shippingAddress
        -String paymentMethod
        -Timestamp orderDate
    }

    class OrderItem {
        -int orderItemId
        -int orderId
        -int productId
        -int productSizeId
        -int quantity
        -BigDecimal price
    }

    User "1" -- "0..1" Cart : has
    User "1" -- "0..*" Order : places
    Category "1" -- "0..*" Product : contains
    Product "1" -- "1..*" ProductSize : has sizes
    Cart "1" -- "0..*" CartItem : contains
    CartItem "*" -- "1" Product : references
    Order "1" -- "1..*" OrderItem : contains
    OrderItem "*" -- "1" Product : references
```

## Sequence Diagram: Place Order Flow

The sequence diagram below shows the flow when a user places an order:

```mermaid
sequenceDiagram
    actor User
    participant View as JSP Page
    participant Servlet as PlaceOrderServlet
    participant CartDAO
    participant OrderDAO
    participant Database

    User->>View: Clicks "Place Order"
    View->>Servlet: POST /PlaceOrderServlet (shipping, payment info)
    Servlet->>CartDAO: getCartByUserId(userId)
    CartDAO->>Database: SELECT * FROM carts WHERE user_id=?
    Database-->>CartDAO: ResultSet
    CartDAO-->>Servlet: Cart object
    
    Servlet->>CartDAO: getCartItemsByCartId(cartId)
    CartDAO->>Database: SELECT * FROM cart_items WHERE cart_id=?
    Database-->>CartDAO: ResultSet
    CartDAO-->>Servlet: List<CartItem>
    
    Servlet->>OrderDAO: placeOrder(Order, List<OrderItem>)
    OrderDAO->>Database: INSERT INTO orders
    OrderDAO->>Database: INSERT INTO order_items (loop)
    Database-->>OrderDAO: Success
    OrderDAO-->>Servlet: boolean true
    
    Servlet->>CartDAO: clearCart(cartId)
    CartDAO->>Database: DELETE FROM cart_items WHERE cart_id=?
    Database-->>CartDAO: Success
    CartDAO-->>Servlet: void
    
    Servlet-->>View: Redirect to OrderSuccessServlet
    View-->>User: Display Order Confirmation
```
