package berk.kocaborek.ecommerce.service.impl;

import berk.kocaborek.ecommerce.dto.ProductAttributeValueDTO;
import berk.kocaborek.ecommerce.dto.ProductBrowseResponse;
import berk.kocaborek.ecommerce.dto.ProductDTO;
import berk.kocaborek.ecommerce.dto.ProductFilterOptionsDto;
import berk.kocaborek.ecommerce.dto.ReviewDTO;
import berk.kocaborek.ecommerce.entity.Product;
import berk.kocaborek.ecommerce.entity.ProductAttributeValue; // Import entity
import berk.kocaborek.ecommerce.entity.Review;
import berk.kocaborek.ecommerce.entity.Store;
import berk.kocaborek.ecommerce.entity.User;
import berk.kocaborek.ecommerce.exception.BadRequestException;
import berk.kocaborek.ecommerce.repository.ProductAttributeValueRepository; // Import repository
import berk.kocaborek.ecommerce.repository.ProductRepository;
import berk.kocaborek.ecommerce.repository.ReviewRepository;
import berk.kocaborek.ecommerce.repository.UserRepository;
import berk.kocaborek.ecommerce.repository.StoreRepository;
import berk.kocaborek.ecommerce.repository.CategoryRepository;
import berk.kocaborek.ecommerce.entity.Category;
import berk.kocaborek.ecommerce.service.ProductService;
import jakarta.persistence.EntityNotFoundException;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.transaction.annotation.Transactional; // Import Transactional
import org.springframework.security.core.Authentication;
import org.springframework.security.access.AccessDeniedException;

import java.math.BigDecimal;
import java.util.HashSet; // Import HashSet
import java.util.List;
import java.util.Locale;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements ProductService {

    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final ProductAttributeValueRepository attributeValueRepository; // Inject repository
    private final ReviewRepository reviewRepository;
    private final StoreRepository storeRepository;
    private final CategoryRepository categoryRepository;

    // Updated constructor
    public ProductServiceImpl(ProductRepository productRepository,
                              UserRepository userRepository,
                              ProductAttributeValueRepository attributeValueRepository,
                              ReviewRepository reviewRepository,
                              StoreRepository storeRepository,
                              CategoryRepository categoryRepository) {
        this.productRepository = productRepository;
        this.userRepository = userRepository;
        this.attributeValueRepository = attributeValueRepository; // Initialize repository
        this.reviewRepository = reviewRepository;
        this.storeRepository = storeRepository;
        this.categoryRepository = categoryRepository;
    }

    // --- Existing Methods (with minor potential adjustments if needed) ---

    @Override
    @Transactional // Good practice for create operations
    public ProductDTO createProduct(ProductDTO productDto) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User not found with email: " + email));

        if (user.getStatus() == User.Status.BANNED) {
            throw new AccessDeniedException("Banned users cannot create products.");
        }

        if (productDto.getPrice() == null || productDto.getPrice().doubleValue() <= 0) {
            throw new BadRequestException("Product price must be greater than zero.");
        }

        // Assuming stockQuantity is a field in your Product entity/DTO
        // if (productDto.getStockQuantity() == null || productDto.getStockQuantity() < 0) {
        //     throw new BadRequestException("Stock quantity cannot be negative.");
        // }

        Product product = mapToEntity(productDto);
        Store store = storeRepository.findByOwner(user)
                .orElseThrow(() -> new EntityNotFoundException("Store not found for user: " + email));
        product.setStore(store); // Set the store instead of seller

        // --- Handle initial attributes if provided in DTO ---
        // This part depends on whether your createProduct DTO includes attribute IDs
        // If it does, fetch and associate them here.
        if (productDto.getAttributes() != null && !productDto.getAttributes().isEmpty()) {
             Set<Long> attributeValueIds = productDto.getAttributes().stream()
                                                    .map(ProductAttributeValueDTO::getId) // Assuming DTO has ID
                                                    .collect(Collectors.toSet());
             Set<ProductAttributeValue> attributeValues = new HashSet<>(attributeValueRepository.findAllById(attributeValueIds));
             // Ensure all requested IDs were found (optional check)
             if(attributeValues.size() != attributeValueIds.size()){
                 // Handle error - some attribute values not found
                 throw new EntityNotFoundException("One or more attribute values not found.");
             }
             product.setAttributes(attributeValues);
        }
        // --- End attribute handling ---


        Product savedProduct = productRepository.save(product);
        return mapToDto(savedProduct); // Mapper now includes attributes
    }

    @Override
    @Transactional(readOnly = true) // Good practice for read operations
    public ProductDTO getProductById(Long id) {
        Product product = productRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + id));
        return mapToDto(product); // Mapper now includes attributes
    }

    @Override
    @Transactional(readOnly = true)
    public List<ProductDTO> getAllProducts() {
        List<Product> products = productRepository.findAll();
        return products.stream().map(this::mapToDto).collect(Collectors.toList()); // Mapper now includes attributes
    }

    @Override
    @Transactional(readOnly = true)
    public ProductBrowseResponse browseProducts(String category, String search, BigDecimal minPrice, BigDecimal maxPrice, String sort, int page, int size) {
        int normalizedPage = Math.max(page, 0);
        int normalizedSize = Math.min(Math.max(size, 1), 48);
        Pageable pageable = PageRequest.of(normalizedPage, normalizedSize, resolveSort(sort));

        String normalizedCategory = normalize(category);
        String normalizedSearch = normalizeSearch(search);

        Page<Product> resultPage = normalizedSearch == null
                ? productRepository.browseProductsWithoutSearch(
                        normalizedCategory,
                        minPrice,
                        maxPrice,
                        pageable
                )
                : productRepository.browseProductsWithSearch(
                        normalizedCategory,
                        normalizedSearch,
                        minPrice,
                        maxPrice,
                        pageable
                );

        return ProductBrowseResponse.builder()
                .items(resultPage.getContent().stream().map(this::mapToDto).toList())
                .page(resultPage.getNumber())
                .size(resultPage.getSize())
                .totalPages(resultPage.getTotalPages())
                .totalElements(resultPage.getTotalElements())
                .build();
    }

    @Override
    @Transactional(readOnly = true)
    public ProductFilterOptionsDto getFilterOptions() {
        List<String> categories = categoryRepository.findAll().stream()
                .map(Category::getName)
                .filter(Objects::nonNull)
                .sorted(String.CASE_INSENSITIVE_ORDER)
                .toList();

        BigDecimal min = Optional.ofNullable(productRepository.findMinUnitPrice()).orElse(BigDecimal.ZERO);
        BigDecimal max = Optional.ofNullable(productRepository.findMaxUnitPrice()).orElse(BigDecimal.ZERO);

        return ProductFilterOptionsDto.builder()
                .categories(categories)
                .priceRange(ProductFilterOptionsDto.PriceRangeDto.builder()
                        .min(min)
                        .max(max)
                        .build())
                .build();
    }

    @Override
    @Transactional
    public ProductDTO updateProduct(Long id, ProductDTO productDto) {
        Product product = findProductByIdOrThrow(id);

        // Authorization check
        checkProductAuthorization(product, "update");

        if (productDto.getPrice() != null && productDto.getPrice().doubleValue() <= 0) {
             throw new BadRequestException("Product price must be greater than zero.");
        }
        // Assuming stockQuantity is a field
        // if (productDto.getStockQuantity() != null && productDto.getStockQuantity() < 0) {
        //     throw new BadRequestException("Stock quantity cannot be negative.");
        // }

        // Update basic fields (attributes are handled by separate methods)
        product.setName(productDto.getName());
        product.setDescription(productDto.getDescription());
        if (productDto.getPrice() != null) product.setUnitPrice(productDto.getPrice());
        // if (productDto.getStockQuantity() != null) product.setStockQuantity(productDto.getStockQuantity());
        if (productDto.getCategory() != null) {
            Category category = categoryRepository.findByName(productDto.getCategory())
                    .orElseGet(() -> {
                        Category newCat = new Category();
                        newCat.setName(productDto.getCategory());
                        return categoryRepository.save(newCat);
                    });
            product.setCategory(category);
        }
        // if (productDto.getImageUrl() != null) product.setImageUrl(productDto.getImageUrl());

        // Note: We are NOT updating the attributes collection here.
        // Use updateProductAttributes or add/remove methods for that.

        Product updatedProduct = productRepository.save(product);
        return mapToDto(updatedProduct); // Mapper now includes attributes
    }

    @Override
    @Transactional
    public void deleteProduct(Long id) {
        Product product = findProductByIdOrThrow(id);

        // Authorization check
        checkProductAuthorization(product, "delete");

        productRepository.delete(product);
    }

    @Override
    @Transactional(readOnly = true)
    public List<ProductDTO> productsFilter(String category) {
        // Assuming findByCategoryName exists in ProductRepository
        List<Product> products = productRepository.findByCategoryName(category);
        return products.stream().map(this::mapToDto).collect(Collectors.toList());
    }

    @Override
    @Transactional(readOnly = true)
    public List<ProductDTO> getAllProductsForUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User not found with email: " + email));

        if (user.getStatus() == User.Status.BANNED) {
            // Decide if banned users can view their own products or none
             throw new AccessDeniedException("Banned users cannot view products.");
            // return Collections.emptyList(); // Or return empty list
        }

        // Assuming findBySeller exists in ProductRepository
        Store store = storeRepository.findByOwner(user)
                .orElseThrow(() -> new EntityNotFoundException("Store not found for user: " + email));
        List<Product> products = productRepository.findByStore(store);
        return products.stream().map(this::mapToDto).collect(Collectors.toList());
    }


    // ====== NEW Attribute Management Implementations ======

    @Override
    @Transactional(readOnly = true)
    public Set<ProductAttributeValueDTO> getProductAttributes(Long productId) {
        Product product = findProductByIdOrThrow(productId);
        // No specific auth check needed here usually, depends on requirements
        // If only seller/admin can see attributes, add checkProductAuthorization(product, "view attributes");

        return product.getAttributes().stream()
                .map(this::mapAttributeValueToDto) // Use helper mapper
                .collect(Collectors.toSet());
    }

    @Override
    @Transactional
    public ProductDTO addAttributeToProduct(Long productId, Long attributeValueId) {
        Product product = findProductByIdOrThrow(productId);
        checkProductAuthorization(product, "update attributes for"); // Check authorization

        ProductAttributeValue attributeValue = findAttributeValueByIdOrThrow(attributeValueId);

        product.getAttributes().add(attributeValue); // Add to the set
        Product updatedProduct = productRepository.save(product);

        return mapToDto(updatedProduct);
    }

    @Override
    @Transactional
    public ProductDTO addAttributesToProduct(Long productId, List<Long> attributeValueIds) {
        Product product = findProductByIdOrThrow(productId);
        checkProductAuthorization(product, "update attributes for"); // Check authorization

        if (attributeValueIds == null || attributeValueIds.isEmpty()) {
             return mapToDto(product); // Nothing to add
            // Or throw new BadRequestException("Attribute value IDs list cannot be empty.");
        }

        List<ProductAttributeValue> attributeValuesToAdd = attributeValueRepository.findAllById(attributeValueIds);

        // Optional: Check if all requested IDs were found
        if (attributeValuesToAdd.size() != attributeValueIds.size()) {
            Set<Long> foundIds = attributeValuesToAdd.stream().map(ProductAttributeValue::getId).collect(Collectors.toSet());
            List<Long> missingIds = attributeValueIds.stream().filter(id -> !foundIds.contains(id)).collect(Collectors.toList());
            throw new EntityNotFoundException("Could not find attribute values with IDs: " + missingIds);
        }

        product.getAttributes().addAll(attributeValuesToAdd); // Add all found values
        Product updatedProduct = productRepository.save(product);

        return mapToDto(updatedProduct);
    }


    @Override
    @Transactional
    public void removeAttributeFromProduct(Long productId, Long attributeValueId) {
        Product product = findProductByIdOrThrow(productId);
        checkProductAuthorization(product, "update attributes for"); // Check authorization

        ProductAttributeValue attributeValueToRemove = findAttributeValueByIdOrThrow(attributeValueId);

        boolean removed = product.getAttributes().remove(attributeValueToRemove); // Remove from set
        if (removed) {
            productRepository.save(product); // Save only if something was actually removed
        } else {
            // Optional: Log or handle the case where the attribute wasn't associated in the first place
            // System.out.println("Attribute value " + attributeValueId + " was not associated with product " + productId);
        }
    }

    @Override
    @Transactional
    public ProductDTO updateProductAttributes(Long productId, List<Long> attributeValueIds) {
        Product product = findProductByIdOrThrow(productId);
        checkProductAuthorization(product, "update attributes for"); // Check authorization

        Set<ProductAttributeValue> newAttributeValues;
        if (attributeValueIds == null || attributeValueIds.isEmpty()) {
            newAttributeValues = new HashSet<>(); // Empty set if list is null or empty
        } else {
            List<ProductAttributeValue> foundValues = attributeValueRepository.findAllById(attributeValueIds);
             // Optional: Check if all requested IDs were found
            if (foundValues.size() != attributeValueIds.size()) {
                 Set<Long> foundIds = foundValues.stream().map(ProductAttributeValue::getId).collect(Collectors.toSet());
                 List<Long> missingIds = attributeValueIds.stream().filter(id -> !foundIds.contains(id)).collect(Collectors.toList());
                throw new EntityNotFoundException("Could not find attribute values with IDs: " + missingIds);
            }
            newAttributeValues = new HashSet<>(foundValues);
        }

        product.setAttributes(newAttributeValues); // Replace the entire set
        Product updatedProduct = productRepository.save(product);

        return mapToDto(updatedProduct);
    }


    // ====== Helper Methods ======

    /**
     * Finds a Product by ID or throws EntityNotFoundException.
     */
    private Product findProductByIdOrThrow(Long productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product not found with id: " + productId));
    }

    /**
     * Finds a ProductAttributeValue by ID or throws EntityNotFoundException.
     */
    private ProductAttributeValue findAttributeValueByIdOrThrow(Long attributeValueId) {
        return attributeValueRepository.findById(attributeValueId)
                .orElseThrow(() -> new EntityNotFoundException("ProductAttributeValue not found with id: " + attributeValueId));
    }

     /**
     * Checks if the current authenticated user is authorized to modify/delete the product.
     * Throws AccessDeniedException if not authorized.
     * @param product The product entity.
     * @param actionDescription Description of the action (e.g., "update", "delete", "update attributes for").
     */
    private void checkProductAuthorization(Product product, String actionDescription) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
         if (authentication == null || !authentication.isAuthenticated()) {
             throw new AccessDeniedException("User is not authenticated.");
         }
        String username = authentication.getName(); // Typically email or username

        // Check if the product has a seller and if the seller's username matches
        // Assuming User entity has getUsername() or getEmail() that matches authentication.getName()
        boolean isOwner = product.getStore() != null && product.getStore().getOwner().getEmail().equals(username); // Adjust field if needed (e.g., getUsername())

        boolean isAdmin = authentication.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .anyMatch(role -> role.equals("ROLE_ADMIN")); // Make sure your admin role name is correct

        if (!isOwner && !isAdmin) {
            throw new AccessDeniedException("You are not authorized to " + actionDescription + " this product.");
        }

        // Optional: Check if the owner is banned (might prevent updates even if owner)
        // if (isOwner && product.getSeller().getStatus() == User.Status.BANNED) {
        //    throw new AccessDeniedException("Banned users cannot " + actionDescription + " their products.");
        // }
    }


    // ====== Mappers (Updated) ======

    /**
     * Maps a Product entity to a ProductDTO, including its attributes.
     */
    private ProductDTO mapToDto(Product product) {
        if (product == null) return null;
        ProductDTO dto = new ProductDTO();
        dto.setId(product.getId());
        dto.setName(product.getName());
        dto.setDescription(product.getDescription());
        dto.setPrice(product.getUnitPrice());
        dto.setStockQuantity(product.getStockQuantity());
        dto.setSeller_id(product.getStore().getOwner().getId());
        dto.setSellerUsername(product.getStore().getOwner().getUsername()); // or getFullName() etc.
        dto.setCategory(product.getCategory() != null ? product.getCategory().getName() : null);
        dto.setImageUrl(product.getImageUrl());

        // Map the associated attributes
        if (product.getAttributes() != null) {
            dto.setAttributes(product.getAttributes().stream()
                    .map(this::mapAttributeValueToDto) // Use the new helper mapper
                    .collect(Collectors.toSet()));
        } else {
            dto.setAttributes(new HashSet<>()); // Initialize empty set if null
        }

        // Map seller info if needed in DTO
        // if (product.getSeller() != null) {
        //     dto.setSellerId(product.getSeller().getId());
        //     dto.setSellerName(product.getSeller().getUsername()); // or getFullName() etc.
        // }

        return dto;
    }

    private String normalize(String value) {
        if (value == null || value.isBlank()) {
            return null;
        }
        return value.trim();
    }

    private String normalizeSearch(String value) {
        String normalized = normalize(value);
        return normalized == null ? null : normalized.toLowerCase(Locale.ROOT);
    }

    private Sort resolveSort(String sort) {
        return switch (sort) {
            case "price_asc" -> Sort.by(Sort.Direction.ASC, "unitPrice");
            case "price_desc" -> Sort.by(Sort.Direction.DESC, "unitPrice");
            case "newest" -> Sort.by(Sort.Direction.DESC, "createdAt");
            default -> Sort.by(Sort.Direction.ASC, "id");
        };
    }

    /**
     * Maps a ProductDTO to a Product entity.
     * NOTE: This basic version does NOT map attributes *from* the DTO.
     * Attribute association is handled within specific service methods like createProduct, addAttributeToProduct etc.
     */
    private Product mapToEntity(ProductDTO dto) {
         if (dto == null) return null;
        Product product = new Product();
        // ID is usually not set here, it's generated or comes from path variable for updates
        product.setName(dto.getName());
        product.setDescription(dto.getDescription());
        product.setUnitPrice(dto.getPrice());
        product.setStockQuantity(dto.getStockQuantity());
        if (dto.getCategory() != null) {
            Category category = categoryRepository.findByName(dto.getCategory())
                    .orElseGet(() -> {
                        Category newCat = new Category();
                        newCat.setName(dto.getCategory());
                        return categoryRepository.save(newCat);
                    });
            product.setCategory(category);
        }
        product.setImageUrl(dto.getImageUrl());

        // DO NOT map attributes here directly from DTO in this basic mapper.
        // The service methods handle fetching and setting the attribute entities based on IDs.
        // product.setAttributes( ... ); // Leave this out here

        return product;
    }

    /**
     * Maps a ProductAttributeValue entity to its DTO representation.
     */
    private ProductAttributeValueDTO mapAttributeValueToDto(ProductAttributeValue entity) {
        if (entity == null) return null;
        ProductAttributeValueDTO dto = new ProductAttributeValueDTO();
        dto.setId(entity.getId());
        dto.setValue(entity.getValue());

        // Include information about the parent Attribute (Name, ID)
        if (entity.getAttribute() != null) {
            dto.setAttributeId(entity.getAttribute().getId());
            dto.setAttributeName(entity.getAttribute().getName());
            // Optionally map the full attribute DTO if needed:
            // dto.setAttribute(mapAttributeToDto(entity.getAttribute()));
        }
        return dto;
    }

    @Override
@Transactional(readOnly = true) // Good practice for read operations
public List<ReviewDTO> getReviewsForProduct(Long productId) {
    // Optional: Check if product exists first
    // if (!productRepository.existsById(productId)) {
    //     throw new EntityNotFoundException("Product not found with id: " + productId);
    // }

    List<Review> reviews = reviewRepository.findByProductId(productId);
    // Use the correct mapper for Review objects
    return reviews.stream()
                  .map(this::mapReviewToDto) // Use the new mapper method
                  .collect(Collectors.toList());
}

    private ReviewDTO mapReviewToDto(Review review) {
        if (review == null) {
            return null;
        }
        ReviewDTO dto = new ReviewDTO();
        dto.setId(review.getId());
        dto.setStarRating(review.getStarRating());
        dto.setComment(review.getComment());
        // Assuming ReviewDTO has fields for user and product IDs/names
        if (review.getUser() != null) {
             dto.setUserId(review.getUser().getId());
             dto.setUsername(review.getUser().getUsername()); // Or email/full name as needed in DTO
        }
         if (review.getProduct() != null) {
             dto.setProductId(review.getProduct().getId());
             // Optionally add product name if needed in ReviewDTO
            // dto.setProductName(review.getProduct().getName());
         }
         // Map other relevant fields like review date if they exist in both entities
         // dto.setReviewDate(review.getCreatedAt()); // Example
    
        return dto;
    }

     /**
     * Helper to map ProductAttribute entity to DTO (if needed).
     * Create ProductAttributeDTO if you don't have it.
     */
    // private ProductAttributeDTO mapAttributeToDto(ProductAttribute entity) {
    //     if (entity == null) return null;
    //     ProductAttributeDTO dto = new ProductAttributeDTO();
    //     dto.setId(entity.getId());
    //     dto.setName(entity.getName());
    //     return dto;
    // }

}
