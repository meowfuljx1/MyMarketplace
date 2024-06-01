package com.meowful.MyMarketplace.controllers;

import com.meowful.MyMarketplace.models.ShoppingCart;
import com.meowful.MyMarketplace.models.User;
import com.meowful.MyMarketplace.services.ShoppingCartService;
import com.meowful.MyMarketplace.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

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
    public String addProductToCart(Principal principal, Long productId, String template){
        shoppingCartService.addProductToCart(principal, productId);
        return "redirect:" + template;
    }


    @PostMapping("/delete-from-cart")
    public String deleteProductFromCart(Principal principal, Long productId){
        shoppingCartService.deleteProductFromCart(principal, productId);
        return "redirect:show-shopping-cart";
    }

}
