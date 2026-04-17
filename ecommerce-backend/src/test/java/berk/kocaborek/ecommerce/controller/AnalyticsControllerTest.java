package berk.kocaborek.ecommerce.controller;

import berk.kocaborek.ecommerce.dto.ChatRequest;
import berk.kocaborek.ecommerce.dto.ChatResponse;
import berk.kocaborek.ecommerce.dto.SqlExecutionRequest;
import berk.kocaborek.ecommerce.entity.User;
import berk.kocaborek.ecommerce.security.JwtAuthenticationFilter;
import berk.kocaborek.ecommerce.security.RateLimitFilter;
import berk.kocaborek.ecommerce.service.AiIntegrationService;
import berk.kocaborek.ecommerce.service.AnalyticsService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(AnalyticsController.class)
@AutoConfigureMockMvc(addFilters = false)
@TestPropertySource(properties = {
        "analytics.internal.api-key=test-internal-api-key-1234567890",
        "jwt.secret=01234567890123456789012345678901",
        "jwt.expirationMs=3600000",
        "app.cors.allowed-origins=http://localhost:4200"
})
@Import(AnalyticsControllerTest.TestBeans.class)
class AnalyticsControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @MockBean
    private JwtAuthenticationFilter jwtAuthenticationFilter;

    @MockBean
    private RateLimitFilter rateLimitFilter;

    @TestConfiguration
    static class TestBeans {
        @Bean
        AnalyticsService analyticsService() {
            JdbcTemplate jdbcTemplate = new JdbcTemplate() {
                @Override
                public List<Map<String, Object>> queryForList(String sql) {
                    return Collections.singletonList(Map.of("result", "success"));
                }
            };
            return new AnalyticsService(jdbcTemplate);
        }

        @Bean
        AiIntegrationService aiIntegrationService() {
            return new AiIntegrationService() {
                @Override
                public ChatResponse askQuestion(ChatRequest request, User currentUser) {
                    return ChatResponse.builder()
                            .answer("stub")
                            .isError(false)
                            .build();
                }
            };
        }
    }

    @Test
    void executeSql_WithoutInternalApiKey_ReturnsForbidden() throws Exception {
        SqlExecutionRequest req = new SqlExecutionRequest();
        req.setQuery("SELECT id FROM orders");
        req.setUserId(1L);
        req.setUserRole("ADMIN");

        mockMvc.perform(post("/api/analytics/execute")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isForbidden());
    }

    @Test
    void executeSql_WithInternalApiKey_ReturnsOk() throws Exception {
        SqlExecutionRequest req = new SqlExecutionRequest();
        req.setQuery("SELECT id FROM orders");
        req.setUserId(1L);
        req.setUserRole("ADMIN");

        mockMvc.perform(post("/api/analytics/execute")
                .header("X-Internal-Api-Key", "test-internal-api-key-1234567890")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(req)))
                .andExpect(status().isOk());
    }
}
