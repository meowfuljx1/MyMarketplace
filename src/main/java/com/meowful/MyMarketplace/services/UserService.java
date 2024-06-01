package com.meowful.MyMarketplace.services;

import com.meowful.MyMarketplace.models.Role;
import com.meowful.MyMarketplace.models.ShoppingCart;
import com.meowful.MyMarketplace.models.User;
import com.meowful.MyMarketplace.repositories.ShoppingCartRepository;
import com.meowful.MyMarketplace.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.util.Collections;

@Service
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final ShoppingCartRepository shoppingCartRepository;


    public boolean addUser(User user){
        String email = user.getEmail();
        if (userRepository.findByEmail(email).isPresent()) return false;
        else {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            user.setActive(true);
            user.setRoles(Collections.singleton(Role.user));

            ShoppingCart shoppingCart = new ShoppingCart();
            shoppingCartRepository.save(shoppingCart);

            // Привязка корзины к пользователю
            user.setShoppingCart(shoppingCart);

            // Сохранение пользователя в базе данных
            userRepository.save(user);
            return true;
        }
    }
    public User getUser(Principal principal){
        if (principal == null) return new User();
        else return userRepository.findByEmail(principal.getName()).get();
    }
}
