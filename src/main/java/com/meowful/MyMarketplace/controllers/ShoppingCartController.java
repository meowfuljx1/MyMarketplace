package com.meowful.MyMarketplace.controllers;

import com.meowful.MyMarketplace.models.ShoppingCart;
import com.meowful.MyMarketplace.models.User;
import com.meowful.MyMarketplace.services.ShoppingCartService;
import com.meowful.MyMarketplace.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequiredArgsConstructor
public class ShoppingCartController {
    private final ShoppingCartService shoppingCartService;
    private final UserService userService;

    @GetMapping("/show-shopping-cart")
    public String showShoppingCart(Principal principal, Model model){
        User user = userService.getUser(principal);
        ShoppingCart shoppingCart = shoppingCartService.getShoppingCartByUser(user);
        model.addAttribute("user", user);
        model.addAttribute("cart", shoppingCart);
        return "shoppingCart";
    }

    @PostMapping("/add-to-cart")
    @ResponseBody
    public void addProductToCart(Principal principal, @RequestBody Map<String, Object> map){
        Long productId = Long.parseLong(map.get("productId").toString());
        shoppingCartService.addProductToCart(principal, productId);
    }

    @PostMapping("/delete-from-cart")
    @ResponseBody
    public Map<String, Integer> deleteProductFromCart(Principal principal, @RequestBody Map<String, Object> map){
        Long productId = Long.parseLong(map.get("productId").toString());
        return shoppingCartService.deleteProductFromCart(principal, productId);
    }

}
