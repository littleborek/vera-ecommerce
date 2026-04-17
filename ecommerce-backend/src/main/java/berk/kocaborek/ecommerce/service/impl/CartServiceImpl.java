package berk.kocaborek.ecommerce.service.impl;

import berk.kocaborek.ecommerce.dto.CartItemDTO;
import berk.kocaborek.ecommerce.dto.CheckoutResponse;
import berk.kocaborek.ecommerce.entity.Cart;
import berk.kocaborek.ecommerce.entity.CartItem;
import berk.kocaborek.ecommerce.entity.Order;
import berk.kocaborek.ecommerce.entity.OrderItem;
import berk.kocaborek.ecommerce.entity.Product;
import berk.kocaborek.ecommerce.entity.User;
import berk.kocaborek.ecommerce.exception.BadRequestException;
import berk.kocaborek.ecommerce.repository.CartItemRepository;
import berk.kocaborek.ecommerce.repository.CartRepository;
import berk.kocaborek.ecommerce.repository.OrderItemRepository;
import berk.kocaborek.ecommerce.repository.OrderRepository;
import berk.kocaborek.ecommerce.repository.ProductRepository;
import berk.kocaborek.ecommerce.repository.UserRepository;
import berk.kocaborek.ecommerce.service.CartService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Transactional
public class CartServiceImpl implements CartService {

        private final CartRepository cartRepository;
        private final CartItemRepository cartItemRepository;
        private final ProductRepository productRepository;
        private final UserRepository userRepository;
        private final OrderRepository orderRepository;
        private final OrderItemRepository orderItemRepository;
        

    // Kullanıcının sepetine ürün ekle
    public void addToCart(Long productId, int quantity) {
        if (quantity <= 0) {
            throw new BadRequestException("Quantity must be greater than zero.");
        }

        User user = getCurrentUser();

        // Kullanıcının cart'ı var mı kontrol et
        Cart cart = cartRepository.findByUser(user)
                .orElseGet(() -> {
                    Cart newCart = Cart.builder()
                            .user(user)
                            .createdAt(java.time.LocalDateTime.now())
                            .build();
                    return cartRepository.save(newCart);
                });

        // Ürünü bul
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new EntityNotFoundException("Product not found"));

        if (product.getStockQuantity() == null || product.getStockQuantity() < quantity) {
            throw new BadRequestException("Not enough stock for this product.");
        }

        Optional<CartItem> existingCartItem = cart.getItems() == null
                ? Optional.empty()
                : cart.getItems().stream()
                        .filter(item -> item.getProduct() != null && item.getProduct().getId().equals(productId))
                        .findFirst();

        CartItem cartItem = existingCartItem.orElseGet(() -> CartItem.builder()
                .cart(cart)
                .product(product)
                .quantity(0)
                .build());

        int updatedQuantity = cartItem.getQuantity() + quantity;
        if (product.getStockQuantity() < updatedQuantity) {
            throw new BadRequestException("Requested quantity exceeds available stock.");
        }

        cartItem.setQuantity(updatedQuantity);
        cartItemRepository.save(cartItem);
    }

    // Kullanıcının sepetini getir
  @Override // getMyCart metodunu @Override ile işaretlemek iyi bir pratiktir.
public List<CartItemDTO> getMyCart() {
    User user = getCurrentUser();

    // Cart'ı user ID ile bulmak daha verimli olabilir
    Cart cart = cartRepository.findByUserId(user.getId())
            .orElseGet(() -> {
                Cart newCart = Cart.builder()
                        .user(user)
                        .createdAt(java.time.LocalDateTime.now())
                        .build();
                return cartRepository.save(newCart);
            });

    // CartItem'ları direkt Cart üzerinden alalım (ilişki zaten var)
    // List<CartItem> cartItems = cartItemRepository.findByCartId(cart.getId()); // Bu sorguya gerek kalmayabilir

    if (cart.getItems() == null) { // Null kontrolü
        return Collections.emptyList(); // Boş liste döndür
    }

    // Stream API ile DTO'ya map'leme
    return cart.getItems().stream().map(item -> {
        CartItemDTO dto = new CartItemDTO();
        dto.setId(item.getId()); // CartItem ID'sini set et
        dto.setProductId(item.getProduct().getId());
        dto.setQuantity(item.getQuantity());

        // Product bilgilerini ekle
        Product product = item.getProduct(); // İlişkili ürünü al
        if (product != null) { // Null kontrolü
             dto.setProductName(product.getName());
             dto.setPrice(product.getUnitPrice());       // Fiyatı ekle
             dto.setImageUrl(product.getImageUrl()); // Resmi ekle
        } else {
            // Ürün bulunamazsa varsayılan değerler atanabilir
            dto.setProductName("Product not found");
            dto.setPrice(BigDecimal.ZERO);
            dto.setImageUrl(null);
        }
        return dto;
    }).collect(Collectors.toList()); // .toList() daha modern
}



    // Sepetten ürün çıkar
    public void removeFromCart(Long cartItemId) {
        CartItem cartItem = getOwnedCartItem(cartItemId);

        cartItemRepository.delete(cartItem);
    }

    //sepette ki ürünleri güncelle
    public void updateCartItem(Long cartItemId, int newQuantity) {
        CartItem cartItem = getOwnedCartItem(cartItemId);
    
        if (newQuantity <= 0) {
            throw new IllegalArgumentException("Quantity must be greater than zero");
        }

        Product product = cartItem.getProduct();
        if (product.getStockQuantity() == null || product.getStockQuantity() < newQuantity) {
            throw new BadRequestException("Requested quantity exceeds available stock.");
        }
    
        cartItem.setQuantity(newQuantity);
        cartItemRepository.save(cartItem);
    }

    // Sepeti temizle (tüm ürünleri kaldır)
    public void clearCart() {
        User user = getCurrentUser();
    
        Cart cart = cartRepository.findByUser(user)
                .orElseThrow(() -> new EntityNotFoundException("Cart not found"));
    
        cart.getItems().clear(); // Sepetteki tüm ürünleri temizle
        cartRepository.save(cart); // Değişikliği kaydet
    }
@Override
public CheckoutResponse checkout() {
    User user = getCurrentUser();

    Cart cart = cartRepository.findByUserId(user.getId())
            .orElseThrow(() -> new EntityNotFoundException("Cart not found"));

    List<CartItem> cartItems = cartItemRepository.findByCartId(cart.getId());

    if (cartItems.isEmpty()) {
        throw new BadRequestException("Cart is empty, cannot checkout.");
    }

    Order order = new Order();
    order.setUser(user);
    order.setStatus(Order.Status.PENDING);
    order.setCreatedAt(LocalDateTime.now());
    order.setGrandTotal(BigDecimal.ZERO);

    Order savedOrder = orderRepository.save(order);

    BigDecimal totalPrice = BigDecimal.ZERO;

    for (CartItem cartItem : cartItems) {
        Product product = cartItem.getProduct();

        if (product.getStockQuantity() == null || product.getStockQuantity() < cartItem.getQuantity()) {
            throw new BadRequestException("Insufficient stock for product: " + product.getName());
        }

        OrderItem orderItem = OrderItem.builder()
                .order(savedOrder)
                .product(product)
                .quantity(cartItem.getQuantity())
                .unitPrice(product.getUnitPrice())
                .build();

        orderItemRepository.save(orderItem);

        totalPrice = totalPrice.add(product.getUnitPrice().multiply(BigDecimal.valueOf(cartItem.getQuantity())));
        product.setStockQuantity(product.getStockQuantity() - cartItem.getQuantity());
        productRepository.save(product);
    }

    savedOrder.setGrandTotal(totalPrice);
    orderRepository.save(savedOrder);

    cartItemRepository.deleteAll(cartItems);

    return new CheckoutResponse("Sipariş başarıyla oluşturuldu!", savedOrder.getId());
}

    private User getCurrentUser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User not found with email: " + email));
    }

    private CartItem getOwnedCartItem(Long cartItemId) {
        CartItem cartItem = cartItemRepository.findById(cartItemId)
                .orElseThrow(() -> new EntityNotFoundException("Cart item not found"));

        User user = getCurrentUser();
        if (cartItem.getCart() == null || cartItem.getCart().getUser() == null
                || !cartItem.getCart().getUser().getId().equals(user.getId())) {
            throw new BadRequestException("You are not authorized to modify this cart item.");
        }

        return cartItem;
    }


}
