package berk.kocaborek.ecommerce.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import berk.kocaborek.ecommerce.entity.Store;
import berk.kocaborek.ecommerce.entity.User;
import java.util.Optional;

@Repository
public interface StoreRepository extends JpaRepository<Store, Long> {
    Optional<Store> findByOwner(User owner);
    Optional<Store> findByName(String name);
}
