package berk.kocaborek.ecommerce.repository;
import org.springframework.data.jpa.repository.JpaRepository;
import berk.kocaborek.ecommerce.entity.OrderItem;

public interface OrderItemRepository extends JpaRepository<OrderItem, Long> {
    // Şimdilik ekstra metod yazmaya gerek yok, JpaRepository yetiyor.
}
 
    

