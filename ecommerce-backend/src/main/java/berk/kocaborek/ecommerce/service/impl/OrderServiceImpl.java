package berk.kocaborek.ecommerce.service.impl;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import berk.kocaborek.ecommerce.dto.OrderDTO;
import berk.kocaborek.ecommerce.dto.OrderItemDTO;
import berk.kocaborek.ecommerce.entity.*;
import berk.kocaborek.ecommerce.exception.BadRequestException;
import berk.kocaborek.ecommerce.repository.*;
import berk.kocaborek.ecommerce.service.OrderService;
import berk.kocaborek.ecommerce.service.StripeService;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;
@RequiredArgsConstructor
@Service
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;
    private final UserRepository userRepository;
    private final AddressRepository addressRepository;
    private final ProductRepository productRepository;
    private final StripeService stripeService;
    private final PaymentRepository paymentRepository;


    
    @Override
    public OrderDTO createOrder(OrderDTO orderDto) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        Address shippingAddress = addressRepository.findById(orderDto.getShippingAddressId())
                .orElseThrow(() -> new EntityNotFoundException("Shipping address not found"));

        Order order = new Order();
        order.setUser(user);
        order.setShippingAddress(shippingAddress);
        order.setStatus(Order.Status.PENDING);

        BigDecimal total = BigDecimal.ZERO;
        List<OrderItem> orderItems = new java.util.ArrayList<>();

        // 🔥 Klasik for döngüsü ile topluyoruz
        for (OrderItemDTO itemDto : orderDto.getOrderItems()) {
            Product product = productRepository.findById(itemDto.getProductId())
                    .orElseThrow(() -> new EntityNotFoundException("Product not found: " + itemDto.getProductId()));

            OrderItem orderItem = new OrderItem();
            orderItem.setProduct(product);
            orderItem.setQuantity(itemDto.getQuantity());
            orderItem.setUnitPrice(itemDto.getUnitPrice());
            orderItem.setOrder(order);

            // Toplam fiyatı hesaplıyoruz
            total = total.add(itemDto.getUnitPrice().multiply(BigDecimal.valueOf(itemDto.getQuantity())));

            orderItems.add(orderItem); // Listeye ekliyoruz
        }

        order.setGrandTotal(total);
        order.setOrderItems(orderItems);

        Order savedOrder = orderRepository.save(order);

        return mapToDto(savedOrder);
    }

    @Override
    public List<OrderDTO> getMyOrders() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        List<Order> orders = orderRepository.findByUserId(user.getId());

        return orders.stream()
                .map(this::mapToDto)
                .toList();
    }

    @Override
    public OrderDTO getOrderById(Long orderId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new EntityNotFoundException("Order not found with id: " + orderId));

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String username = auth.getName();
        boolean isAdmin = auth.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"));

        if (!isAdmin && !order.getUser().getEmail().equals(username)) {
            throw new AccessDeniedException("You are not authorized to view this order.");
        }

        return mapToDto(order);
    }

    @Override
    public List<OrderDTO> getAllOrders(Long userId) {
        List<Order> orders;
    
        if (userId == null) {
            // Admin tüm siparişleri görmek istiyor
            orders = orderRepository.findAll();
        } else {
            // Kullanıcı kendi siparişlerini görmek istiyor
            orders = orderRepository.findByUserId(userId);
        }
    
        return orders.stream()
                .map(this::mapToDto)
                .toList();
    }

    @Override
    public List<OrderDTO> getOrdersForCurrentSeller() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        User seller = userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        List<Order> orders = orderRepository.findByStoreOwnerId(seller.getId());
        return orders.stream()
                .map(this::mapToDto)
                .toList();
    }
    

    @Override
    public OrderDTO cancelOrder(Long orderId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName(); // Şu anda login olan kullanıcının email'ini alıyoruz

        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new EntityNotFoundException("Order not found"));

        // 🔥 Kullanıcı sadece kendi siparişini iptal edebilir
        if (!order.getUser().getEmail().equals(email)) {
            throw new AccessDeniedException("You are not authorized to cancel this order.");
        }

        // 🔥 Sipariş kargoya verildiyse veya teslim edildiyse iptal edemez
        if (order.getStatus() == Order.Status.SHIPPED || order.getStatus() == Order.Status.DELIVERED) {
            throw new BadRequestException("Cannot cancel order after it is shipped or delivered.");
        }

        // 🔥 Sipariş durumunu CANCELLED yapıyoruz
        order.setStatus(Order.Status.CANCELLED);

        Order updatedOrder = orderRepository.save(order);

        return mapToDto(updatedOrder);
    }

    @Override
public void deleteOrder(Long orderId) {
    Authentication auth = SecurityContextHolder.getContext().getAuthentication();
    String currentEmail = auth.getName();
    boolean isAdmin = auth.getAuthorities().stream()
            .anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN"));

    Order order = orderRepository.findById(orderId)
            .orElseThrow(() -> new EntityNotFoundException("Order not found"));

    if (!isAdmin && (order.getUser() == null || !order.getUser().getEmail().equals(currentEmail))) {
        throw new AccessDeniedException("You are not authorized to delete this order.");
    }

    // Önce order'a bağlı tüm payment kayıtlarını silelim
    List<Payment> payments = paymentRepository.findByOrder(order);
    paymentRepository.deleteAll(payments);

    // Sonra order'ı silelim
    orderRepository.delete(order);
}


    @Override
    public OrderDTO updateOrderStatus(Long orderId, String newStatus) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new EntityNotFoundException("Order not found"));

        // 🔥 Enum kontrolü
        try {
            Order.Status statusEnum = Order.Status.valueOf(newStatus.toUpperCase());
            order.setStatus(statusEnum);
        } catch (IllegalArgumentException e) {
            throw new RuntimeException("Invalid order status: " + newStatus);
        }

        Order updatedOrder = orderRepository.save(order);

        return mapToDto(updatedOrder);
    }

    // DTO-Entity Mapper
    private OrderDTO mapToDto(Order order) {
        OrderDTO dto = new OrderDTO();
        dto.setId(order.getId());
        dto.setUserId(order.getUser().getId());
        if (order.getShippingAddress() != null) {
            dto.setShippingAddressId(order.getShippingAddress().getId());
        } else {
            dto.setShippingAddressId(null);
        }
        dto.setStatus(order.getStatus().name());
        dto.setTotalPrice(order.getGrandTotal());
        dto.setCreatedAt(order.getCreatedAt());

        List<OrderItemDTO> itemDtos = order.getOrderItems().stream().map(item -> {
            OrderItemDTO itemDto = new OrderItemDTO();
            itemDto.setProductId(item.getProduct().getId());
            itemDto.setQuantity(item.getQuantity());
            itemDto.setUnitPrice(item.getUnitPrice());
            itemDto.setProductName(item.getProduct().getName());
            itemDto.setImageUrl(item.getProduct().getImageUrl());
            itemDto.setSellerId(
                    item.getProduct().getStore() != null && item.getProduct().getStore().getOwner() != null
                            ? item.getProduct().getStore().getOwner().getId()
                            : null);
            return itemDto;
        }).collect(Collectors.toList());

        dto.setOrderItems(itemDtos);
        return dto;
    }

    @Override
    public void completeOrderIfPaymentSucceeded(Long orderId, String paymentIntentId) {
        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new EntityNotFoundException("Order not found with id: " + orderId));

        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String currentEmail = auth.getName();
        boolean isAdmin = auth.getAuthorities().stream()
                .anyMatch(authority -> authority.getAuthority().equals("ROLE_ADMIN"));
        if (!isAdmin && (order.getUser() == null || !order.getUser().getEmail().equals(currentEmail))) {
            throw new AccessDeniedException("You are not authorized to complete this order.");
        }
        if (order.getStatus() != Order.Status.PENDING) {
            throw new BadRequestException("Order is not in a payable state.");
        }

        // Ödeme başarılıysa sipariş durumunu güncelle
        if (stripeService.isPaymentSucceeded(paymentIntentId)) {
            order.setStatus(Order.Status.PROCESSING);
            orderRepository.save(order);
        } else {
            throw new BadRequestException("Payment not succeeded for order ID: " + orderId);
        }
    }

    @Override
public List<OrderDTO> getAllOrdersForUser(Long userId) {
    List<Order> orders;

    if (userId == null) {
        orders = orderRepository.findAll(); // 🔥 Tüm siparişleri getir
    } else {
        orders = orderRepository.findByUserId(userId); // 🔥 Sadece bu kullanıcıya ait siparişleri getir
    }

    return orders.stream().map(this::mapToDto).toList();
}

@Override
    public List<OrderDTO> getOrdersByStatus(String status) {
    try {
        Order.Status orderStatus = Order.Status.valueOf(status.toUpperCase());
        List<Order> orders = orderRepository.findByStatus(orderStatus);
        return orders.stream().map(this::mapToDto).toList();
    } catch (IllegalArgumentException e) {
        throw new BadRequestException("Invalid status: " + status);
    }
}

    @Override
    public OrderDTO requestReturn(Long orderId) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String currentEmail = auth.getName();

        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new EntityNotFoundException("Order not found"));

        if (order.getUser() == null || !order.getUser().getEmail().equals(currentEmail)) {
            throw new AccessDeniedException("You are not authorized to request a return for this order.");
        }
        if (order.getStatus() != Order.Status.DELIVERED) {
            throw new BadRequestException("Returns can only be requested for delivered orders.");
        }

        order.setStatus(Order.Status.RETURN_REQUESTED);
        return mapToDto(orderRepository.save(order));
    }

    @Override
    public OrderDTO updateOrderStatusForCurrentSeller(Long orderId, String newStatus) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String email = auth.getName();

        User seller = userRepository.findByEmail(email)
                .orElseThrow(() -> new EntityNotFoundException("User not found"));

        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> new EntityNotFoundException("Order not found"));

        boolean ownsOrder = order.getOrderItems().stream().anyMatch(item ->
                item.getProduct() != null
                        && item.getProduct().getStore() != null
                        && item.getProduct().getStore().getOwner() != null
                        && item.getProduct().getStore().getOwner().getId().equals(seller.getId()));
        if (!ownsOrder) {
            throw new AccessDeniedException("You are not authorized to update this order.");
        }

        Order.Status targetStatus;
        try {
            targetStatus = Order.Status.valueOf(newStatus.toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new BadRequestException("Invalid order status: " + newStatus);
        }

        Order.Status currentStatus = order.getStatus();
        boolean allowedTransition =
                (currentStatus == Order.Status.PENDING && targetStatus == Order.Status.PROCESSING)
                        || (currentStatus == Order.Status.PROCESSING && targetStatus == Order.Status.SHIPPED);
        if (!allowedTransition) {
            throw new BadRequestException(
                    "Seller cannot change order status from " + currentStatus + " to " + targetStatus + ".");
        }

        order.setStatus(targetStatus);
        return mapToDto(orderRepository.save(order));
    }


   



}
