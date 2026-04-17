package berk.kocaborek.ecommerce.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import berk.kocaborek.ecommerce.entity.CustomerProfile;
import berk.kocaborek.ecommerce.entity.User;
import java.util.Optional;

@Repository
public interface CustomerProfileRepository extends JpaRepository<CustomerProfile, Long> {
    Optional<CustomerProfile> findByUser(User user);
}
