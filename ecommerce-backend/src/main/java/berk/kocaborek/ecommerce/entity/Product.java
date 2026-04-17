package berk.kocaborek.ecommerce.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data; // Or add getters/setters manually if not using Lombok
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.HashSet; // Import HashSet
import java.util.Set;     // Import Set

@Entity
@Data
@Table(name = "products")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "store_id", nullable = false)
    private Store store;

    @Column(nullable = false)
    private String name;

    @Column(unique = true)
    private String sku;

    private String description;

    @Column(name = "unit_price", nullable = false)
    private BigDecimal unitPrice;

    private Integer stockQuantity = 0;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    private Category category;

    private String imageUrl;

    private LocalDateTime createdAt;

    @PrePersist // Automatically set createdAt before saving
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    // --- Add this ManyToMany relationship ---
    @ManyToMany(fetch = FetchType.LAZY) // LAZY fetching is generally recommended for performance
    @JoinTable(
        name = "product_product_attribute_values", // Name for the intermediate table
        joinColumns = @JoinColumn(name = "product_id"), // Column in join table linking to Product
        inverseJoinColumns = @JoinColumn(name = "attribute_value_id") // Column linking to ProductAttributeValue
    )
    private Set<ProductAttributeValue> attributes = new HashSet<>(); // Initialize the Set
    // --- End of added relationship ---


    // --- Constructors, other methods, equals/hashCode if needed ---

    // Note: If you are NOT using Lombok's @Data annotation, you MUST manually add:
    // public Set<ProductAttributeValue> getAttributes() {
    //     return attributes;
    // }
    //
    // public void setAttributes(Set<ProductAttributeValue> attributes) {
    //     this.attributes = attributes;
    // }

}
