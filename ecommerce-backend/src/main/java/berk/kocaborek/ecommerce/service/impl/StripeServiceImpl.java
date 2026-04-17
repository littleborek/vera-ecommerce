package berk.kocaborek.ecommerce.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.exception.SignatureVerificationException;
import com.stripe.model.Event;
import com.stripe.model.PaymentIntent;
import com.stripe.model.StripeObject;
import com.stripe.model.checkout.Session;
import com.stripe.net.Webhook;
import com.stripe.param.PaymentIntentCreateParams;
import com.stripe.param.checkout.SessionCreateParams;

import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import berk.kocaborek.ecommerce.entity.Order;
import berk.kocaborek.ecommerce.exception.BadRequestException;
import berk.kocaborek.ecommerce.repository.OrderRepository;
import berk.kocaborek.ecommerce.service.PaymentService;
import berk.kocaborek.ecommerce.service.StripeService;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;



@RequiredArgsConstructor
@Service
public class StripeServiceImpl implements StripeService {

    

    @Value("${stripe.secret.key}")
    private String secretKey;

    @Value("${stripe.public.key}")
    private String publishableKey;

    @Value("${stripe.success.url}")
    private String successUrl;

    @Value("${stripe.cancel.url}")
    private String cancelUrl;

    @Value("${stripe.webhook.secret:}")
    private String webhookSecret;

    private final OrderRepository orderRepository;
    private final PaymentService paymentService;

    @PostConstruct
    public void init() {
        Stripe.apiKey = secretKey;
    }

    @Override
    public String createCheckoutSession(Long orderId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new BadRequestException("Order not found"));

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String currentEmail = auth.getName();
        boolean isAdmin = auth.getAuthorities().stream()
                .anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN"));
        if (!isAdmin && (order.getUser() == null || !order.getUser().getEmail().equals(currentEmail))) {
            throw new AccessDeniedException("You are not authorized to pay for this order.");
        }
        if (order.getStatus() != Order.Status.PENDING) {
            throw new BadRequestException("Only pending orders can be paid.");
        }
        if (order.getOrderItems() == null || order.getOrderItems().isEmpty()) {
            throw new BadRequestException("Order has no payable items.");
        }

        try {
            List<SessionCreateParams.LineItem> lineItems = order.getOrderItems().stream()
                    .map(item -> SessionCreateParams.LineItem.builder()
                            .setQuantity(Long.valueOf(item.getQuantity()))
                            .setPriceData(SessionCreateParams.LineItem.PriceData.builder()
                                    .setCurrency("usd")
                                    .setUnitAmount(item.getUnitPrice().multiply(java.math.BigDecimal.valueOf(100)).longValue()) // cents!
                                    .setProductData(SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                            .setName(item.getProduct().getName())
                                            .build())
                                    .build())
                            .build())
                    .toList();

            SessionCreateParams params = SessionCreateParams.builder()
                    .setMode(SessionCreateParams.Mode.PAYMENT)
                    .setSuccessUrl(successUrl + "&session_id={CHECKOUT_SESSION_ID}&orderId=" + order.getId())
                    .setCancelUrl(cancelUrl)
                    .addAllLineItem(lineItems)
                    .putMetadata("order_id", order.getId().toString())
.putMetadata("user_id", order.getUser().getId().toString())

                    .build();

            Session session = Session.create(params);
            return session.getUrl();

        } catch (StripeException e) {
            throw new RuntimeException("Stripe checkout oturumu oluşturulamadı", e);
        }
    }

    public boolean isPaymentSucceeded(String paymentIntentId) {
        try {
            return PaymentIntent.retrieve(paymentIntentId)
                    .getStatus()
                    .equalsIgnoreCase("succeeded");
        } catch (Exception e) {
            throw new BadRequestException("Payment intent not found.");
        }
    }
    @Override
    public String createPaymentIntent(Long amount) {
        try {
            PaymentIntentCreateParams params = PaymentIntentCreateParams.builder()
                    .setAmount(amount)
                    .setCurrency("usd")
                    .build();

            PaymentIntent paymentIntent = PaymentIntent.create(params);
            return paymentIntent.getClientSecret();
        } catch (Exception e) {
            throw new RuntimeException("Stripe PaymentIntent oluşturulamadı", e);
        }
    }

    @Override
    public String getPublishableKey() {
        return publishableKey;
    }

    @Override
    public void handleWebhook(String payload, String signatureHeader) {
        if (webhookSecret == null || webhookSecret.isBlank()) {
            throw new BadRequestException("Stripe webhook secret is not configured.");
        }

        try {
            Event event = Webhook.constructEvent(payload, signatureHeader, webhookSecret);
            if ("checkout.session.completed".equals(event.getType())) {
                StripeObject stripeObject = event.getDataObjectDeserializer().getObject()
                        .orElseThrow(() -> new BadRequestException("Invalid Stripe event payload."));
                Session session = (Session) stripeObject;
                String orderIdValue = session.getMetadata() != null ? session.getMetadata().get("order_id") : null;
                if (orderIdValue == null) {
                    throw new BadRequestException("Missing order_id metadata in Stripe session.");
                }
                paymentService.markPaymentAsSucceeded(Long.valueOf(orderIdValue));
            }
        } catch (SignatureVerificationException e) {
            throw new AccessDeniedException("Invalid Stripe signature.");
        } catch (StripeException e) {
            throw new BadRequestException("Stripe webhook processing failed.");
        }
    }
}
