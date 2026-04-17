package berk.kocaborek.ecommerce.service;



import berk.kocaborek.ecommerce.dto.ProductAttributeValueDTO;
import berk.kocaborek.ecommerce.dto.ProductBrowseResponse;
import berk.kocaborek.ecommerce.dto.ProductDTO;
import berk.kocaborek.ecommerce.dto.ProductFilterOptionsDto;
import berk.kocaborek.ecommerce.dto.ReviewDTO;

import java.math.BigDecimal;
import java.util.List;
import java.util.Set;

public interface ProductService {

    ProductDTO createProduct(ProductDTO productDto);

    ProductDTO getProductById(Long id);

    List<ProductDTO> getAllProducts();

    ProductBrowseResponse browseProducts(String category, String search, BigDecimal minPrice, BigDecimal maxPrice, String sort, int page, int size);

    ProductFilterOptionsDto getFilterOptions();

    ProductDTO updateProduct(Long id, ProductDTO productDto);

    void deleteProduct(Long id);

    List<ProductDTO> productsFilter(String category);

    List<ProductDTO> getAllProductsForUser(); // Get all products for the logged-in user
    Set<ProductAttributeValueDTO> getProductAttributes(Long productId);
    ProductDTO addAttributeToProduct(Long productId, Long attributeValueId);
    ProductDTO addAttributesToProduct(Long productId, List<Long> attributeValueIds);
    void removeAttributeFromProduct(Long productId, Long attributeValueId);
    ProductDTO updateProductAttributes(Long productId, List<Long> attributeValueIds);

    List<ReviewDTO> getReviewsForProduct(Long productId);
}
