package com.meowful.MyMarketplace.services;

import com.meowful.MyMarketplace.configurations.CustomUserDetails;
import com.meowful.MyMarketplace.models.User;
import com.meowful.MyMarketplace.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Optional;
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
    private final UserRepository repository;
    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Optional<User> user = repository.findByEmail(email);
        return user.map(CustomUserDetails::new)
                .orElseThrow( () -> new UsernameNotFoundException("User with email " + email + " not found"));
    }
}
