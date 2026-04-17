package berk.kocaborek.ecommerce.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Data
@Table(name = "shipments")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Shipment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    private Order order;

    private String warehouse; // Warehouse Block (A, B, C, D, F)

    private String mode; // Ship, Flight, Road

    private String status; // IN_TRANSIT, DELIVERED, DELAYED

    @Column(name = "customer_care_calls")
    private Integer customerCareCalls;

    @Column(name = "product_importance")
    private String productImportance; // low, medium, high

    @Column(name = "estimated_arrival")
    private LocalDateTime estimatedArrival;
}
