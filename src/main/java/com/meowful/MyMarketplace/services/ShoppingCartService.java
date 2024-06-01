package com.meowful.MyMarketplace.services;

import com.meowful.MyMarketplace.models.Product;
import com.meowful.MyMarketplace.models.ShoppingCart;
import com.meowful.MyMarketplace.models.User;
import com.meowful.MyMarketplace.repositories.ShoppingCartRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ShoppingCartService {
    private final ShoppingCartRepository shoppingCartRepository;
    private final UserService userService;
    private final ProductService productService;

    @Transactional
    public void deleteProductFromCart(Principal principal, Long productId){
        User user = userService.getUser(principal);
        ShoppingCart shoppingCart = user.getShoppingCart();
        Product product = productService.getProductById(productId);

        shoppingCart.setSum(shoppingCart.getSum() - product.getPrice());
        shoppingCart.getProducts().remove(product);
        product.setShoppingCart(null);
        shoppingCartRepository.save(shoppingCart);

    }

    public void addProductToCart(Principal principal, Long productId){

        User user = userService.getUser(principal);
        Product product = productService.getProductById(productId);
        ShoppingCart shoppingCart = user.getShoppingCart();
        shoppingCart.setSum(shoppingCart.getSum() + product.getPrice());

        List<Product> products = shoppingCart.getProducts();
        products.add(product);
        product.setShoppingCart(shoppingCart);
        shoppingCartRepository.save(shoppingCart);
    }

    public ShoppingCart getShoppingCartByUser(User user){
        return shoppingCartRepository.findShoppingCartByUser(user);
    }
    @Transactional
    public void clear(ShoppingCart shoppingCart){
        for (Product product : shoppingCart.getProducts()) {
            product.setShoppingCart(null);
        }
        // Очищаем список товаров из корзины
        shoppingCart.getProducts().clear();
        shoppingCart.setSum(0);
        // Сохраняем изменения в корзине
        shoppingCartRepository.save(shoppingCart);
    }


}
