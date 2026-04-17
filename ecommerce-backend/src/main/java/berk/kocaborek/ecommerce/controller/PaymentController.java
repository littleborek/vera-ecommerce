package berk.kocaborek.ecommerce.controller;

import berk.kocaborek.ecommerce.dto.PaymentDTO;
import berk.kocaborek.ecommerce.service.PaymentService;
import berk.kocaborek.ecommerce.service.StripeService;
import lombok.RequiredArgsConstructor;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/payments")
@RequiredArgsConstructor
public class PaymentController {

    private final PaymentService paymentService;
    private final StripeService stripeService;

   /*  @PostMapping
    public ResponseEntity<PaymentDTO> processPayment(@Valid @RequestBody PaymentRequest paymentRequest) {
        PaymentDTO paymentDTO = paymentService.processPayment(paymentRequest);
        return ResponseEntity.ok(paymentDTO);
    }*/

    @GetMapping("/my")
    public ResponseEntity<List<PaymentDTO>> getPaymentList() {
        List<PaymentDTO> paymentDTOs = paymentService.getAllPaymentByUser();
        return ResponseEntity.ok(paymentDTOs);
    }

    @PostMapping("/intent")
    public ResponseEntity<String> createPaymentIntent(@RequestParam Long amount) {
        String clientSecret = stripeService.createPaymentIntent(amount);
        return ResponseEntity.ok(clientSecret);

    }

    @PostMapping("/checkout-session")
    public ResponseEntity<String> createCheckoutSession(@RequestParam Long orderId) {
        String checkoutUrl = stripeService.createCheckoutSession(orderId);
        return ResponseEntity.ok(checkoutUrl);
    }

    @GetMapping("/config")
    public ResponseEntity<String> getStripePublishableKey() {
        return ResponseEntity.ok(stripeService.getPublishableKey());
    }

    @PostMapping("/webhook")
    public ResponseEntity<Void> handleStripeWebhook(
            @RequestBody String payload,
            @RequestHeader("Stripe-Signature") String signatureHeader) {
        stripeService.handleWebhook(payload, signatureHeader);
        return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
    }

}
