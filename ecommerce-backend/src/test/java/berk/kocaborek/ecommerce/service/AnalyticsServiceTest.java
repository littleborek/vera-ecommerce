package berk.kocaborek.ecommerce.service;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;

class AnalyticsServiceTest {

    private AnalyticsService analyticsService;
    private JdbcTemplate jdbcTemplate;

    @BeforeEach
    void setUp() {
        jdbcTemplate = new JdbcTemplate() {
            @Override
            public List<Map<String, Object>> queryForList(String sql) {
                return Collections.singletonList(Map.of("result", "success"));
            }
        };
        analyticsService = new AnalyticsService(jdbcTemplate);
    }

    @Test
    void executeDynamicQuery_NullOrEmptySQL_ThrowsException() {
        assertThrows(IllegalArgumentException.class, () -> analyticsService.executeDynamicQuery(null, 1L, "ADMIN"));
        assertThrows(IllegalArgumentException.class, () -> analyticsService.executeDynamicQuery("   ", 1L, "ADMIN"));
    }

    @Test
    void executeDynamicQuery_NotSelect_ThrowsException() {
        assertThrows(SecurityException.class, () -> 
            analyticsService.executeDynamicQuery("UPDATE orders SET grand_total = 100", 1L, "ADMIN")
        );
        assertThrows(SecurityException.class, () -> 
            analyticsService.executeDynamicQuery("DROP TABLE users", 1L, "ADMIN")
        );
    }

    @Test
    void executeDynamicQuery_SelectAll_ThrowsException() {
        assertThrows(SecurityException.class, () -> 
            analyticsService.executeDynamicQuery("SELECT * FROM orders", 1L, "ADMIN")
        );
    }

    @Test
    void executeDynamicQuery_SensitiveColumns_ThrowsException() {
        assertThrows(SecurityException.class, () -> 
            analyticsService.executeDynamicQuery("SELECT id, password_hash FROM users", 1L, "ADMIN")
        );
    }

    @Test
    void executeDynamicQuery_Union_ThrowsException() {
        assertThrows(SecurityException.class, () -> 
            analyticsService.executeDynamicQuery("SELECT id FROM users UNION SELECT id FROM stores", 1L, "ADMIN")
        );
    }

    @Test
    void executeDynamicQuery_NonAdminWithoutOwnershipWhere_ThrowsException() {
         assertThrows(SecurityException.class, () -> 
            analyticsService.executeDynamicQuery("SELECT id, grand_total FROM orders", 2L, "CUSTOMER")
        );
    }

    @Test
    void executeDynamicQuery_NonAdminWithOrBypass_ThrowsException() {
        assertThrows(SecurityException.class, () -> 
            analyticsService.executeDynamicQuery("SELECT id, grand_total FROM orders WHERE user_id = 2 OR 1=1", 2L, "CUSTOMER")
        );
    }

    @Test
    void executeDynamicQuery_NonAdminWithValidOwnership_ReturnsSuccess() {
        List<Map<String, Object>> result = analyticsService.executeDynamicQuery("SELECT id, grand_total FROM orders WHERE user_id = 2", 2L, "CUSTOMER");
        assertEquals(1, result.size());
        assertEquals("success", result.get(0).get("result"));
    }

    @Test
    void executeDynamicQuery_AdminWithoutOwnership_ReturnsSuccess() {
        // Admin doesn't need ownership rules
        List<Map<String, Object>> result = analyticsService.executeDynamicQuery("SELECT id, grand_total FROM orders", 1L, "ADMIN");
        assertEquals(1, result.size());
    }

    @Test
    void executeDynamicQuery_CustomerPublicCatalogWithoutOwnership_ReturnsSuccess() {
        List<Map<String, Object>> result = analyticsService.executeDynamicQuery(
                "SELECT id, name, unit_price FROM products ORDER BY unit_price DESC LIMIT 5",
                9L,
                "CUSTOMER"
        );
        assertEquals(1, result.size());
        assertEquals("success", result.get(0).get("result"));
    }

    @Test
    void executeDynamicQuery_CustomerPublicReviewAnalytics_ReturnsSuccess() {
        List<Map<String, Object>> result = analyticsService.executeDynamicQuery(
                "SELECT p.id, p.name, COUNT(r.id) AS review_count FROM products p JOIN reviews r ON r.product_id = p.id GROUP BY p.id, p.name ORDER BY review_count DESC LIMIT 1",
                9L,
                "CUSTOMER"
        );
        assertEquals(1, result.size());
        assertEquals("success", result.get(0).get("result"));
    }
}
