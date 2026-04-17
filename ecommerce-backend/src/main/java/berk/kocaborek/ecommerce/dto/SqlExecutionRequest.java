package berk.kocaborek.ecommerce.dto;

import lombok.Data;

@Data
public class SqlExecutionRequest {
    private String query;
    private Long userId;
    private String userRole;
}
