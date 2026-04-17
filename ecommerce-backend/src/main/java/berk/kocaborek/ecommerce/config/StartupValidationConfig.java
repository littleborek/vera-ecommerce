package berk.kocaborek.ecommerce.config;

import jakarta.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class StartupValidationConfig {

    @Value("${analytics.internal.api-key}")
    private String analyticsInternalApiKey;

    @Value("${stripe.secret.key:}")
    private String stripeSecretKey;

    @PostConstruct
    void validate() {
        if (analyticsInternalApiKey == null || analyticsInternalApiKey.isBlank()) {
            throw new IllegalStateException("ANALYTICS_INTERNAL_API_KEY must be configured.");
        }
        if (analyticsInternalApiKey.length() < 24) {
            throw new IllegalStateException("ANALYTICS_INTERNAL_API_KEY must be at least 24 characters.");
        }
        if (stripeSecretKey != null && !stripeSecretKey.isBlank() && !stripeSecretKey.startsWith("sk_")) {
            throw new IllegalStateException("STRIPE_SECRET_KEY is invalid.");
        }
    }
}
