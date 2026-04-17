package berk.kocaborek.ecommerce.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import berk.kocaborek.ecommerce.entity.Cart;
import berk.kocaborek.ecommerce.entity.User;

import java.util.Optional;

public interface CartRepository extends JpaRepository<Cart, Long> {
    Optional<Cart> findByUser(User user);
    Optional<Cart> findByUserId(Long userId);

}
