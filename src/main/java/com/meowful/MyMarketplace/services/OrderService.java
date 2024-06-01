package com.meowful.MyMarketplace.services;

import com.meowful.MyMarketplace.models.Order;
import com.meowful.MyMarketplace.models.Product;
import com.meowful.MyMarketplace.models.ShoppingCart;
import com.meowful.MyMarketplace.models.User;
import com.meowful.MyMarketplace.repositories.OrderRepository;
import com.meowful.MyMarketplace.repositories.ShoppingCartRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final ShoppingCartService shoppingCartService;
    public Order createOrder(Principal principal) {
        User user = userService.getUser(principal);
        ShoppingCart shoppingCart = shoppingCartService.getShoppingCartByUser(user);

        Order order = new Order();
        order.setSum(shoppingCart.getSum());
        order.setUser(user);
        order = orderRepository.save(order);

        List<Product> products = new ArrayList<>(shoppingCart.getProducts());
        order.setProducts(products);

        for(Product product: shoppingCart.getProducts()){
            product.setOrder(order);
        }
        orderRepository.save(order);

        shoppingCartService.clear(shoppingCart);
        return order;
    }

    public void cancelOrder(Order order){
        for(Product product: order.getProducts()){
            product.setOrder(null);
        }
        orderRepository.delete(order);
    }
}
