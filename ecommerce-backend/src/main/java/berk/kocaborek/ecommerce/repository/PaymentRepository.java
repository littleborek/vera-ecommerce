package berk.kocaborek.ecommerce.repository;

import berk.kocaborek.ecommerce.entity.Payment;
import berk.kocaborek.ecommerce.entity.Order;



import java.util.List;


import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface PaymentRepository extends JpaRepository<Payment, Long> {

    List<Payment> findByOrderUserId(Long userId);
    List<Payment> findByOrder(Order order);
    boolean existsByOrderId(Long orderId);
    @Query("select p from Payment p where p.order.store.owner.id = :ownerId")
    List<Payment> findByOrderStoreOwnerId(@Param("ownerId") Long ownerId);

    @Query("select p from Payment p")
    List<Payment> findAllPayments();

}
