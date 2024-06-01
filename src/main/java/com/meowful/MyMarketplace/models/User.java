package com.meowful.MyMarketplace.models;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "users")
@Data
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String password;
    @Column(unique = true)
    private String email;
    private String telegram;
    private String phoneNumber;
    private LocalDate dateOfBirth;
    private String city;
    // статус пользователя
    private boolean isActive;
    /* @ElementCollection: Эта аннотация указывает, что поле roles представляет собой коллекцию элементов,
    которые не являются сущностями (то есть, не связаны с отдельной таблицей в базе данных),
    а являются встраиваемыми объектами или простыми типами данных.
    targetClass = Role.class: Этот атрибут указывает тип элементов коллекции */
    @ElementCollection(targetClass = Role.class, fetch = FetchType.EAGER)
/*  Аннотация создает таблицу в БД с указанным именем и соединяет таблицы по ключу id
    в таблице users = полю user_id в таблице "user_roles" */
    @CollectionTable(name = "user_roles", joinColumns = @JoinColumn(name = "user_id"))
    // хранить enum в виде строки
    @Enumerated(EnumType.STRING)
    private Set<Role> roles;
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "user")
    private List<Product> products;

    @OneToOne
    @JoinColumn(name = "shopping_cart_id")
    private ShoppingCart shoppingCart;

    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "user")
    private List<Order> orders;

    @PostPersist
    private void afterSave() {
        this.shoppingCart.setUser(this);
    }

}
