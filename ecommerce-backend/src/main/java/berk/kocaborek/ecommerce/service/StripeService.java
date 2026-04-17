package berk.kocaborek.ecommerce.service;



public interface StripeService {

    String createCheckoutSession(Long orderId);

    String createPaymentIntent(Long amount);

    boolean isPaymentSucceeded(String paymentIntentId);

    String getPublishableKey();

    void handleWebhook(String payload, String signatureHeader);
}
