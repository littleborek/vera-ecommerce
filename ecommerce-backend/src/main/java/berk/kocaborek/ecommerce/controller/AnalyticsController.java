package berk.kocaborek.ecommerce.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;
import berk.kocaborek.ecommerce.dto.ChatRequest;
import berk.kocaborek.ecommerce.dto.ChatResponse;
import berk.kocaborek.ecommerce.dto.SqlExecutionRequest;
import berk.kocaborek.ecommerce.entity.User;
import berk.kocaborek.ecommerce.service.AiIntegrationService;
import berk.kocaborek.ecommerce.service.AnalyticsService;

import java.util.List;
import java.util.Map;
import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api")
@RequiredArgsConstructor
@Tag(name = "Analytics & AI Chat", description = "Endpoints for AI Chatbot and Analytics Execution")
public class AnalyticsController {

    private final AnalyticsService analyticsService;
    private final AiIntegrationService aiIntegrationService;

    @Value("${analytics.internal.api-key}")
    private String analyticsInternalApiKey;

    /**
     * Endpoint for the Angular frontend to ask questions to the AI.
     */
    @PostMapping("/chat/ask")
    @Operation(summary = "Ask a natural language question to the AI text2sql agent")
    public ResponseEntity<ChatResponse> askQuestion(@RequestBody ChatRequest request, @AuthenticationPrincipal User currentUser) {
        // Enforce that only logged in users can use the chatbot
        if (currentUser == null) {
            return ResponseEntity.status(401).build();
        }

        ChatResponse response = aiIntegrationService.askQuestion(request, currentUser);
        return ResponseEntity.ok(response);
    }

    /**
     * Endpoint for the Python AI Service to strictly and safely execute SQL.
     * In a real production scenario, this endpoint should be protected by an internal API key or network partition 
     * to prevent public access.
     */
    @PostMapping("/analytics/execute")
    @Operation(summary = "Execute AI generated SQL (Internal use by LangGraph Agent)")
    public ResponseEntity<List<Map<String, Object>>> executeSql(@RequestBody SqlExecutionRequest request, HttpServletRequest httpRequest) {
        String providedKey = httpRequest.getHeader("X-Internal-Api-Key");
        if (providedKey == null || !providedKey.equals(analyticsInternalApiKey)) {
            return ResponseEntity.status(403).body(List.of(Map.of("error", "Forbidden")));
        }

        try {
            List<Map<String, Object>> result = analyticsService.executeDynamicQuery(request.getQuery(), request.getUserId(), request.getUserRole());
            return ResponseEntity.ok(result);
        } catch (SecurityException e) {
            return ResponseEntity.status(403).body(List.of(Map.of("error", e.getMessage())));
        } catch (Exception e) {
            return ResponseEntity.badRequest().body(List.of(Map.of("error", e.getMessage())));
        }
    }
}
