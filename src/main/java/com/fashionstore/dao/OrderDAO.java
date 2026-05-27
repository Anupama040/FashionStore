package com.fashionstore.dao;

import java.util.List;
import com.fashionstore.model.Order;
import com.fashionstore.model.OrderItem;

public interface OrderDAO {

    boolean placeOrder(Order order, List<OrderItem> orderItems);

    Order getOrderById(int orderId);

    List<Order> getOrdersByUserId(int userId);

    List<Order> getAllOrders();

    List<OrderItem> getOrderItemsByOrderId(int orderId);

    boolean updateOrderStatus(int orderId, String orderStatus);
}