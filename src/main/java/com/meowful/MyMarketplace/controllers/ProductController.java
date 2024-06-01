package com.meowful.MyMarketplace.controllers;

import com.meowful.MyMarketplace.models.Product;
import com.meowful.MyMarketplace.models.User;
import com.meowful.MyMarketplace.services.ProductService;
import com.meowful.MyMarketplace.services.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class ProductController {
    private final ProductService productService;
    private final UserService userService;

    @GetMapping("/")
    public String mainPage(@RequestParam(name = "title", required = false, defaultValue = "") String title, Principal principal, Model model) {
        model.addAttribute("products", productService.getProducts(title));
        model.addAttribute("title", title);
        model.addAttribute("user", userService.getUser(principal));
        return "mainPage";
    }

    @GetMapping("product/new/creation-form")
    public String productCreation(Model model, Principal principal) {
        model.addAttribute("user", userService.getUser(principal));
        return "productCreationPage";
    }

    @PostMapping("/product/create")
    public String addProduct(@RequestParam("files") List<MultipartFile> files, Product product, Principal principal, Model model) {
        boolean result = productService.addProduct(product, principal, files);
        if (result) return "redirect:/";
        else{
            model.addAttribute("msg", "Something went wrong");
            model.addAttribute("user", userService.getUser(principal));
            return "productCreationPage";
        }
    }

    @GetMapping("/product/{product}")
    public String getProduct(@PathVariable Product product, Model model, Principal principal) {
        model.addAttribute("product", product);
        model.addAttribute("user", userService.getUser(principal));
        return "productInfoPage";
    }

    @GetMapping("/my-products")
    public String myProducts(Model model, Principal principal) {
        model.addAttribute("user", userService.getUser(principal));
        return "myProductsPage";
    }

    @PostMapping("/product/delete/{id}")
    public String deleteProduct(@PathVariable("id") Long productId) {
        productService.deleteProduct(productId);
        return "redirect:/my-products";
    }

    @GetMapping("/product/change/{id}")
    public String changingProductPage(@PathVariable("id") Long productId, Model model, Principal principal) {
        model.addAttribute("product", productService.getProductById(productId));
        model.addAttribute("user", userService.getUser(principal));
        return "productChangingPage";
    }

    @PostMapping("/product/update")
    public String updateProduct(Product newProduct, @RequestParam("files") List<MultipartFile> files, Long productId) {
        productService.updateProduct(newProduct, files, productId);
        return "redirect:/my-products";
    }
}
