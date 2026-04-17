package berk.kocaborek.ecommerce.service;

import berk.kocaborek.ecommerce.dto.CheckoutResponse;
import berk.kocaborek.ecommerce.dto.CartItemDTO;

import java.util.List;

public interface CartService {

    // Sepete ürün ekleme
    void addToCart(Long productId, int quantity);

    // Kullanıcının sepetini getirme
    List<CartItemDTO> getMyCart();

    // Sepetten ürün çıkarma
    void removeFromCart(Long cartItemId);

    // Sepetteki ürün adedini güncelleme
    void updateCartItem(Long cartItemId, int newQuantity);

    // Sepeti temizleme
    void clearCart();

    // Sepeti satın alma işlemi (checkout)
    CheckoutResponse checkout();
}
