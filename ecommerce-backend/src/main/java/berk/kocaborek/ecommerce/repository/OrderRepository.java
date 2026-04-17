package berk.kocaborek.ecommerce.repository;

import berk.kocaborek.ecommerce.entity.Order;
import berk.kocaborek.ecommerce.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByUser(User user);

    List<Order> findByUserId(Long userId);

    List<Order> findByStatus(Order.Status status);

    @Query("select distinct o from Order o where o.store.owner.id = :ownerId")
    List<Order> findByStoreOwnerId(@Param("ownerId") Long ownerId);

}
