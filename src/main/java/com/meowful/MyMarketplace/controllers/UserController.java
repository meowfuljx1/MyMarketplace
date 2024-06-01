package com.meowful.MyMarketplace.controllers;

import com.meowful.MyMarketplace.models.User;
import com.meowful.MyMarketplace.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
public class UserController {
    private final UserService userService;

    @GetMapping("/login")
    public String login(@RequestParam(value = "error", required = false) String error, Model model){
        if (error != null) model.addAttribute("error", "Invalid email or password");
        return "loginPage";
    }

    @GetMapping("/registration")
    public String registration(){
        return "registrationPage";
    }

    @PostMapping("/registration")
    public String addUser(User user, Model model){
        boolean addingUser = userService.addUser(user);
        if (!addingUser) {
            model.addAttribute("error", "User with email " + user.getEmail() + " already exists");
            return "registrationPage";
        }
        return "redirect:/login";
    }
    @GetMapping("/seller/{user}")
    public String getUser(@PathVariable("user") User seller, Model model, Principal principal){
        model.addAttribute("user", userService.getUser(principal));
        model.addAttribute("seller", seller);
        return "userInfoPage";
    }
}
