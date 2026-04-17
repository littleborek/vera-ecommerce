package berk.kocaborek.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data               // Getter, Setter, toString, equals, hashCode metodlarını otomatik oluşturur
@NoArgsConstructor  // Parametresiz constructor oluşturur
@AllArgsConstructor // Tüm alanları içeren constructor oluşturur
@Builder            // Builder pattern implementasyonunu sağlar
public class ReviewDTO {

    private Long id;
    private Long userId; // User nesnesi yerine sadece ID'sini tutuyoruz
    private String username; // Fixed field name from 'Username' to 'username'
    private Long productId; // Product nesnesi yerine sadece ID'sini tutuyoruz
    private Integer starRating;
    private String sentiment;
    private String comment;
    private LocalDateTime createdAt;

    // İsteğe bağlı: Entity'den DTO'ya dönüşüm için statik bir metot eklenebilir
    // Bu genellikle bir Mapper sınıfında yapılır ama basitlik için buraya eklenebilir.
    
    public static ReviewDTO fromEntity(berk.kocaborek.ecommerce.entity.Review review) {
        if (review == null) {
            return null;
        }
        return ReviewDTO.builder()
                .id(review.getId())
                .userId(review.getUser() != null ? review.getUser().getId() : null) // Null kontrolü önemli
                .productId(review.getProduct() != null ? review.getProduct().getId() : null) // Null kontrolü önemli
                .starRating(review.getStarRating())
                .sentiment(review.getSentiment())
                .comment(review.getComment())
                .createdAt(review.getCreatedAt())
                .build();
    }
    

    // İsteğe bağlı: DTO'dan Entity'ye dönüşüm için bir metot eklenebilir
    // Bu genellikle bir Mapper sınıfında yapılır. User ve Product nesnelerini
    // ID'lerden yola çıkarak repository'den çekmeniz gerekecektir.
    
    public berk.kocaborek.ecommerce.entity.Review toEntity() {
        // Dikkat: Bu metot User ve Product nesnelerini set etmez.
        // Bunları Service katmanında ID'leri kullanarak bulup set etmeniz gerekir.
        berk.kocaborek.ecommerce.entity.Review review = new berk.kocaborek.ecommerce.entity.Review();
        review.setId(this.id); // Genellikle yeni entity oluştururken ID null olur veya set edilmez.
        review.setStarRating(this.starRating);
        review.setSentiment(this.sentiment);
        review.setComment(this.comment);
        review.setCreatedAt(this.createdAt != null ? this.createdAt : LocalDateTime.now()); // Oluşturma zamanını ayarla
         //review.setUser(...) // Service katmanında userId ile User bulunup set edilmeli
        // review.setProduct(...) // Service katmanında productId ile Product bulunup set edilmeli
        return review;
    }
    
}