package com.fashionstore.dao;

import java.util.List;
import com.fashionstore.model.Cart;
import com.fashionstore.model.CartItem;

public interface CartDAO {

    boolean createCart(int userId);

    Cart getCartByUserId(int userId);

    boolean addToCart(CartItem cartItem);

    boolean updateCartItemQuantity(int cartItemId, int quantity);

    boolean removeCartItem(int cartItemId);

    List<CartItem> getCartItemsByCartId(int cartId);

    boolean clearCart(int cartId);
    double getCartTotalAmount(int cartId);
}