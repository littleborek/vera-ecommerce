package berk.kocaborek.ecommerce.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import berk.kocaborek.ecommerce.entity.CartItem;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    List<CartItem> findByCartId(Long cartId);
}
