package berk.kocaborek.ecommerce.dto;

import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import lombok.Data;
@Data
public class OrderDTO {

    private Long id; // Response için gerekli olabilir (CREATE sonrası)

    private Long userId; // User ID'yi backend'den de alabiliriz, requestte almak opsiyonel

    @NotNull(message = "Shipping address must not be null")
    private Long shippingAddressId;

    private String status = "PENDING"; // Default değer

    private BigDecimal totalPrice; // Hesaplanabilir de olabilir

    private LocalDateTime createdAt;

    @NotNull(message = "Order items must not be empty")
    private List<OrderItemDTO> orderItems;

 
}
