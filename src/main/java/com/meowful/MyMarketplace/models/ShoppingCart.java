package com.meowful.MyMarketplace.models;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.Fetch;

import java.util.List;
@Setter

@Getter

@AllArgsConstructor

@NoArgsConstructor

@Entity

/*@Entity
@Data*/
@Table(name = "shopping_cart")
public class ShoppingCart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private int sum;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "shoppingCart")
    private List<Product> products;
}
