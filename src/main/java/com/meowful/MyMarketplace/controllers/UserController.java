package com.meowful.MyMarketplace.controllers;

import com.meowful.MyMarketplace.models.User;
import com.meowful.MyMarketplace.services.UserService;
import jakarta.servlet.http.HttpSession;
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

    private final String invalidData = "Invalid email or password";
    private final String commonError = "Something went wrong!";
    private final String invalidEmail = " email is already taken";
    private final String checkEmail = "Check your email to verify account.";
    private final String accCreated = "Your account has been created";

    @GetMapping("/registration")
    public String registration(){
        return "registrationPage";
    }

    @PostMapping("/waiting-for-activation") // нужно ли отображать этот адрес?
    public String waitingForActivation(User user, Model model, HttpSession session){
        boolean isEmailValid = userService.emailValidation(user);
        if (isEmailValid) {
            session.setAttribute("user", user);
            model.addAttribute("msg", checkEmail); // добавить сообщение в tmp
            return "tempPage";
        }
        else {
            model.addAttribute("error", user.getEmail() + invalidEmail); // есть ли сообщение в tmp?
            return "registrationPage";
        }
    }

    @GetMapping("/activation/{code}")
    public String activation(@PathVariable String code, HttpSession session, Model model){
        User user = (User) session.getAttribute("user");
        if (userService.codeValidation(code, user)) {
            userService.addUser(user);
            model.addAttribute("msg", accCreated);
        }
        else {
            model.addAttribute("error", commonError);
        }
        return "loginPage";
    }

    @GetMapping("/example")
    public String example(Model model){
        model.addAttribute("msg", accCreated);
        return "tempPage";
    }


    @GetMapping("/login")
    public String login(@RequestParam(value = "error", required = false) String error, Model model){
        if (error != null) {
            model.addAttribute("error", invalidData);
        }
        return "loginPage";
    }


    @GetMapping("/seller/{user}")
    public String getUser(@PathVariable("user") User seller, Model model, Principal principal){
        model.addAttribute("user", userService.getUser(principal));
        model.addAttribute("seller", seller);
        return "userInfoPage";
    }
}
