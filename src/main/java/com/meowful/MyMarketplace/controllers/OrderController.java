package com.meowful.MyMarketplace.controllers;

import com.meowful.MyMarketplace.models.Order;
import com.meowful.MyMarketplace.models.Product;
import com.meowful.MyMarketplace.services.OrderService;
import com.meowful.MyMarketplace.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class OrderController {
    private final OrderService orderService;
    private final UserService userService;

    @GetMapping("/my-orders")
    public String myOrders(Principal principal, Model model){
        model.addAttribute("user", userService.getUser(principal));
        return "myOrders";
    }

    @PostMapping("/my-orders/cancel/{order}")
    public String cancelOrder(@PathVariable Order order){
        orderService.cancelOrder(order);
        return "redirect:/my-orders";
    }
    @PostMapping("/order/create")
    public String createOrder(Principal principal, Model model){
        model.addAttribute("user", userService.getUser(principal));
        model.addAttribute("order", orderService.createOrder(principal));
        return "redirect:/order/created";
    }

    @GetMapping("/order/created")
    public String orderCreated(Principal principal, Model model){
        model.addAttribute("user", userService.getUser(principal));
        return "orderCreated";
    }
}
