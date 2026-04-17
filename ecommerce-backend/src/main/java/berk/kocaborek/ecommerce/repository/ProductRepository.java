package berk.kocaborek.ecommerce.repository;

import berk.kocaborek.ecommerce.entity.Product;
import berk.kocaborek.ecommerce.entity.User;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;
import java.math.BigDecimal;


public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByCategoryName(String categoryName);
    List<Product> findByNameContainingIgnoreCase(String name);
    List<Product> findByStore(berk.kocaborek.ecommerce.entity.Store store);
    List<Product> findByStoreId(Long storeId);

    @EntityGraph(attributePaths = {"store.owner", "category"})
    @Query("""
            select p from Product p
            left join p.category c
            where (:category is null or c.name = :category)
              and (:minPrice is null or p.unitPrice >= :minPrice)
              and (:maxPrice is null or p.unitPrice <= :maxPrice)
            """)
    Page<Product> browseProductsWithoutSearch(
            @Param("category") String category,
            @Param("minPrice") BigDecimal minPrice,
            @Param("maxPrice") BigDecimal maxPrice,
            Pageable pageable
    );

    @EntityGraph(attributePaths = {"store.owner", "category"})
    @Query("""
            select p from Product p
            left join p.category c
            where (:category is null or c.name = :category)
              and (lower(p.name) like concat('%', :search, '%')
                   or (c.name is not null and lower(c.name) like concat('%', :search, '%')))
              and (:minPrice is null or p.unitPrice >= :minPrice)
              and (:maxPrice is null or p.unitPrice <= :maxPrice)
            """)
    Page<Product> browseProductsWithSearch(
            @Param("category") String category,
            @Param("search") String search,
            @Param("minPrice") BigDecimal minPrice,
            @Param("maxPrice") BigDecimal maxPrice,
            Pageable pageable
    );

    @Query("select min(p.unitPrice) from Product p")
    BigDecimal findMinUnitPrice();

    @Query("select max(p.unitPrice) from Product p")
    BigDecimal findMaxUnitPrice();
}
