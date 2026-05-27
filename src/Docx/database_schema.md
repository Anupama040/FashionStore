# Database Schema Documentation

This document describes the database tables, their relationships, and how they map to the respective Java model classes in the Fashion Store application.

## Entity-Relationship Overview

```mermaid
erDiagram
    USERS ||--o| CARTS : has
    USERS ||--o{ ORDERS : places
    CATEGORIES ||--|{ PRODUCTS : contains
    PRODUCTS ||--|{ PRODUCT_SIZES : has
    PRODUCTS ||--o{ CART_ITEMS : referenced_in
    PRODUCTS ||--o{ ORDER_ITEMS : referenced_in
    CARTS ||--o{ CART_ITEMS : contains
    ORDERS ||--|{ ORDER_ITEMS : contains

    USERS {
        int user_id PK
        string full_name
        string email
        string password
        string phone
        string address
        timestamp created_at
    }
    
    ADMINS {
        int admin_id PK
        string name
        string email
        string password
        timestamp created_at
    }

    CATEGORIES {
        int category_id PK
        string category_name
        string description
    }

    PRODUCTS {
        int product_id PK
        int category_id FK
        string product_name
        string brand
        text description
        decimal price
        string image_url
        int stock_quantity
        timestamp created_at
    }
    
    PRODUCT_SIZES {
        int product_size_id PK
        int product_id FK
        string size
        int stock_quantity
    }

    CARTS {
        int cart_id PK
        int user_id FK
        timestamp created_at
    }

    CART_ITEMS {
        int cart_item_id PK
        int cart_id FK
        int product_id FK
        int product_size_id FK
        int quantity
    }

    ORDERS {
        int order_id PK
        int user_id FK
        decimal total_amount
        string order_status
        string shipping_address
        string payment_method
        timestamp order_date
    }

    ORDER_ITEMS {
        int order_item_id PK
        int order_id FK
        int product_id FK
        int product_size_id FK
        int quantity
        decimal price
    }
```

## Table to Java Class Mapping

| Database Table | Java Model Class | Description |
| :--- | :--- | :--- |
| `users` | `com.fashionstore.model.User` | Stores registered customer information including authentication and contact details. |
| `admins` | `com.fashionstore.model.Admin` | Stores administrator accounts for dashboard access. |
| `categories` | `com.fashionstore.model.Category` | Classifies products into different logical groupings (e.g., Men, Women, Accessories). |
| `products` | `com.fashionstore.model.Product` | Contains product details such as name, brand, overall stock, and price. Mapped to a category. |
| `product_sizes`| `com.fashionstore.model.ProductSize` | Tracks inventory for specific sizes of a product. Maps back to the `products` table. |
| `carts` | `com.fashionstore.model.Cart` | Represents a user's active shopping session. Each user typically has one active cart. |
| `cart_items` | `com.fashionstore.model.CartItem` | Items currently added to a cart. Links the cart to the specific product, size, and quantity. |
| `orders` | `com.fashionstore.model.Order` | Finalized purchases placed by a user, including total cost and shipping information. |
| `order_items` | `com.fashionstore.model.OrderItem` | Snapshot of the products purchased in a specific order, including the price at the time of purchase. |

## Relationships

- **One-to-Many**: `Category` -> `Product`. One category can have multiple products.
- **One-to-Many**: `Product` -> `ProductSize`. A single product can be available in multiple sizes.
- **One-to-One**: `User` -> `Cart`. A user is assigned a single cart for their session.
- **One-to-Many**: `Cart` -> `CartItem`. A cart contains multiple items.
- **One-to-Many**: `User` -> `Order`. A user can place multiple orders over time.
- **One-to-Many**: `Order` -> `OrderItem`. An order consists of one or more items.
