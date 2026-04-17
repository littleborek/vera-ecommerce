package berk.kocaborek.ecommerce.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import berk.kocaborek.ecommerce.dto.ChatRequest;
import berk.kocaborek.ecommerce.dto.ChatResponse;
import berk.kocaborek.ecommerce.entity.User;

import java.util.HashMap;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class AiIntegrationService {

    private final RestTemplate restTemplate = new RestTemplate();

    @Value("${ai.service.url:http://localhost:8000}")
    private String aiServiceUrl;

    @Value("${analytics.internal.api-key}")
    private String analyticsInternalApiKey;

    public ChatResponse askQuestion(ChatRequest request, User currentUser) {
        log.info("Sending chat request to AI Service for user: {}", currentUser.getUsername());

        // Construct the payload for the Python AI Service.
        // It includes the user's role to enforce data segregation bounds within LangGraph.
        Map<String, Object> payload = new HashMap<>();
        payload.put("question", request.getQuestion());
        payload.put("userRole", currentUser.getRole().name());
        payload.put("userId", currentUser.getId());

        String endpoint = aiServiceUrl + "/chat";

        try {
            HttpHeaders headers = new HttpHeaders();
            headers.set("X-Internal-Api-Key", analyticsInternalApiKey);
            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(payload, headers);
            ResponseEntity<ChatResponse> response = restTemplate.postForEntity(endpoint, entity, ChatResponse.class);
            return response.getBody();
        } catch (Exception e) {
            log.error("Failed to communicate with AI Service: {}", e.getMessage());
            return ChatResponse.builder()
                    .answer("I'm currently unable to connect to the AI analytics engine. Please try again later.")
                    .isError(true)
                    .build();
        }
    }
}
