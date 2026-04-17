package berk.kocaborek.ecommerce.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ProductBrowseResponse {
    private List<ProductDTO> items;
    private int page;
    private int size;
    private int totalPages;
    private long totalElements;
}
