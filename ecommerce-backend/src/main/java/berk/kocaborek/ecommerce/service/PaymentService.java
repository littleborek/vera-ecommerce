package berk.kocaborek.ecommerce.service;

import java.util.List;

import berk.kocaborek.ecommerce.dto.PaymentDTO;
import berk.kocaborek.ecommerce.dto.PaymentRequest;

public interface PaymentService {
    PaymentDTO processPayment(PaymentRequest paymentRequest);
    List<PaymentDTO> getAllPaymentByUser();
    boolean isPaymentSucceeded(String paymentIntentId);
    PaymentDTO createPaymentAfterCheckout(Long orderId);
    void markPaymentAsSucceeded(Long orderId);
    List<PaymentDTO> getPaymentsForCurrentSeller();
    List<PaymentDTO> getAllPaymentsForAdmin();

    

}
