package com.meowful.MyMarketplace.models;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    private Integer sum;

    @ManyToOne(cascade = CascadeType.REFRESH, fetch = FetchType.LAZY)
    private User user;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "order")
    private List<Product> products;
}
