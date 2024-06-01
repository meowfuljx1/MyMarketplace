package com.meowful.MyMarketplace.repositories;

import com.meowful.MyMarketplace.models.Order;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<Order, Long> {
}
