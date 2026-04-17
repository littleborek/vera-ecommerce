package berk.kocaborek.ecommerce.service.impl;

import berk.kocaborek.ecommerce.dto.PaymentDTO;
import berk.kocaborek.ecommerce.dto.PaymentRequest;
import berk.kocaborek.ecommerce.entity.Order;
import berk.kocaborek.ecommerce.entity.Payment;
import berk.kocaborek.ecommerce.entity.User;
import berk.kocaborek.ecommerce.entity.Order.Status;
import berk.kocaborek.ecommerce.exception.BadRequestException;
import berk.kocaborek.ecommerce.repository.OrderRepository;
import berk.kocaborek.ecommerce.repository.PaymentRepository;
import berk.kocaborek.ecommerce.repository.UserRepository;
import berk.kocaborek.ecommerce.service.PaymentService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.stripe.model.PaymentIntent;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class PaymentServiceImpl implements PaymentService {

    private final PaymentRepository paymentRepository;
    private final OrderRepository orderRepository;
    private final UserRepository userRepository;

    @Override
    public PaymentDTO processPayment(PaymentRequest paymentRequest) {
        Order order = orderRepository.findById(paymentRequest.getOrderId())
                .orElseThrow(() -> new BadRequestException("Order not found."));

                
        Payment payment = Payment.builder()
                .order(order)
                .paymentMethod(Payment.PaymentMethod.valueOf(paymentRequest.getPaymentMethod().toUpperCase()))
                .paymentStatus(Payment.PaymentStatus.COMPLETED) // Şu anda sahte tamamlanmış kabul ediyoruz
                .amount(paymentRequest.getAmount())
                .createdAt(LocalDateTime.now())
                .build();
         
        Payment savedPayment = paymentRepository.save(payment);
        if(payment.getPaymentStatus() == Payment.PaymentStatus.COMPLETED) {
                order.setStatus(Status.PROCESSING);

                
        }else{
                order.setStatus(Status.CANCELLED);
        }

        orderRepository.save(order);


        return PaymentDTO.builder()
                .id(savedPayment.getId())
                .orderId(savedPayment.getOrder().getId())
                .paymentMethod(savedPayment.getPaymentMethod().name())
                .paymentStatus(savedPayment.getPaymentStatus().name())
                .amount(savedPayment.getAmount())
                .createdAt(savedPayment.getCreatedAt())
                .build();
    }

    @Override
    public List<PaymentDTO> getAllPaymentByUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));
        
        List<Payment> payment = paymentRepository.findByOrderUserId(user.getId());

        return payment.stream().map(p -> PaymentDTO.builder()
                .id(p.getId())
                .orderId(p.getOrder().getId())
                .paymentMethod(p.getPaymentMethod().name())
                .paymentStatus(p.getPaymentStatus().name())
                .amount(p.getAmount())
                .createdAt(p.getCreatedAt())
                .build()).toList();

                
    }

    @Override
    public List<PaymentDTO> getPaymentsForCurrentSeller() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        List<Payment> payments = paymentRepository.findByOrderStoreOwnerId(user.getId());

        return payments.stream().map(p -> PaymentDTO.builder()
                .id(p.getId())
                .orderId(p.getOrder().getId())
                .paymentMethod(p.getPaymentMethod().name())
                .paymentStatus(p.getPaymentStatus().name())
                .amount(p.getAmount())
                .createdAt(p.getCreatedAt())
                .build()).toList();
    }

    @Override
    public boolean isPaymentSucceeded(String paymentIntentId) {
        try
        {
                final boolean isSucceeded = PaymentIntent.retrieve(paymentIntentId).getStatus().equalsIgnoreCase("succeeded");
                return isSucceeded;
        } catch (Exception e) {
            throw new BadRequestException("Payment intent not found.");
        }
   
       
    }

    @Override
public PaymentDTO createPaymentAfterCheckout(Long orderId) {
    Order order = orderRepository.findById(orderId)
        .orElseThrow(() -> new EntityNotFoundException("Order not found"));

    if (paymentRepository.existsByOrderId(orderId)) {
        Payment existingPayment = paymentRepository.findByOrder(order).stream().findFirst()
                .orElseThrow(() -> new BadRequestException("Payment already exists for this order."));
        return PaymentDTO.builder()
            .id(existingPayment.getId())
            .orderId(existingPayment.getOrder().getId())
            .paymentMethod(existingPayment.getPaymentMethod().name())
            .paymentStatus(existingPayment.getPaymentStatus().name())
            .amount(existingPayment.getAmount())
            .createdAt(existingPayment.getCreatedAt())
            .build();
    }

    Payment payment = Payment.builder()
        .order(order)
        .paymentMethod(Payment.PaymentMethod.STRIPE)
        .paymentStatus(Payment.PaymentStatus.PENDING)
        .amount(order.getGrandTotal())
        .createdAt(LocalDateTime.now())
        .build();

    Payment savedPayment = paymentRepository.save(payment);

    return PaymentDTO.builder()
        .id(savedPayment.getId())
        .orderId(savedPayment.getOrder().getId())
        .paymentMethod(savedPayment.getPaymentMethod().name())
        .paymentStatus(savedPayment.getPaymentStatus().name())
        .amount(savedPayment.getAmount())
        .createdAt(savedPayment.getCreatedAt())
        .build();
}

@Override
@Transactional
public void markPaymentAsSucceeded(Long orderId) {
    // Sipariş durumunu güncelle
    Order order = orderRepository.findById(orderId)
            .orElseThrow(() -> new BadRequestException("Order not found"));
            order.setStatus(Order.Status.PROCESSING); // String değil, enum sabiti!

    orderRepository.save(order);

    BigDecimal totalAmount = order.getOrderItems().stream()
    .map(item -> item.getUnitPrice().multiply(BigDecimal.valueOf(item.getQuantity())))
    .reduce(BigDecimal.ZERO, BigDecimal::add);

    // Ödeme kaydı oluştur
    List<Payment> existingPayments = paymentRepository.findByOrder(order);
    if (existingPayments.isEmpty()) {
        Payment payment = Payment.builder()
        .order(order)
        .amount(totalAmount)
        .paymentMethod(Payment.PaymentMethod.STRIPE)
        .paymentStatus(Payment.PaymentStatus.COMPLETED)
        .createdAt(LocalDateTime.now())
        .build();

        paymentRepository.save(payment);
    } else {
        Payment payment = existingPayments.get(0);
        payment.setPaymentStatus(Payment.PaymentStatus.COMPLETED);
        payment.setAmount(totalAmount);
        paymentRepository.save(payment);
    }

    // (İsteğe bağlı) Kullanıcıya e-posta gönderilebilir
}

@Override
public List<PaymentDTO> getAllPaymentsForAdmin() {
    return paymentRepository.findAllPayments().stream().map(p -> PaymentDTO.builder()
            .id(p.getId())
            .orderId(p.getOrder().getId())
            .paymentMethod(p.getPaymentMethod().name())
            .paymentStatus(p.getPaymentStatus().name())
            .amount(p.getAmount())
            .createdAt(p.getCreatedAt())
            .build()).toList();
}


}
