package berk.kocaborek.ecommerce.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import berk.kocaborek.ecommerce.entity.Shipment;
import berk.kocaborek.ecommerce.entity.Order;
import java.util.Optional;

@Repository
public interface ShipmentRepository extends JpaRepository<Shipment, Long> {
    Optional<Shipment> findByOrder(Order order);
}
