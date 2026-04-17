package berk.kocaborek.ecommerce.service.impl;

import berk.kocaborek.ecommerce.dto.OrderDTO;
import berk.kocaborek.ecommerce.entity.Order;
import berk.kocaborek.ecommerce.entity.User;
import berk.kocaborek.ecommerce.repository.AddressRepository;
import berk.kocaborek.ecommerce.repository.OrderRepository;
import berk.kocaborek.ecommerce.repository.PaymentRepository;
import berk.kocaborek.ecommerce.repository.ProductRepository;
import berk.kocaborek.ecommerce.repository.UserRepository;
import berk.kocaborek.ecommerce.service.StripeService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.MockitoAnnotations;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Collections;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.anyLong;

class OrderServiceImplTest {

    @Mock
    private OrderRepository orderRepository;
    @Mock
    private UserRepository userRepository;
    @Mock
    private AddressRepository addressRepository;
    @Mock
    private ProductRepository productRepository;
    @Mock
    private StripeService stripeService;
    @Mock
    private PaymentRepository paymentRepository;

    @InjectMocks
    private OrderServiceImpl orderService;

    private User authUser;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        
        authUser = new User();
        authUser.setId(100L);
        authUser.setEmail("test@user.com");
        authUser.setRole(User.Role.CUSTOMER);

        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                authUser.getEmail(), null, Collections.singletonList(new SimpleGrantedAuthority("ROLE_CUSTOMER")));
        SecurityContextHolder.getContext().setAuthentication(authentication);

        Mockito.when(userRepository.findByEmail(authUser.getEmail())).thenReturn(Optional.of(authUser));
    }

    @Test
    void cancelOrder_UserOwnsOrder_CancelsSuccessfully() {
        Order mockOrder = new Order();
        mockOrder.setId(1L);
        mockOrder.setUser(authUser);
        mockOrder.setStatus(Order.Status.PENDING);

        Mockito.when(orderRepository.findById(1L)).thenReturn(Optional.of(mockOrder));
        Mockito.when(orderRepository.save(any(Order.class))).thenReturn(mockOrder);

        OrderDTO result = orderService.cancelOrder(1L);

        assertEquals(Order.Status.CANCELLED.name(), result.getStatus());
        Mockito.verify(orderRepository).save(mockOrder);
    }

    @Test
    void cancelOrder_UserDoesNotOwnOrder_ThrowsAccessDeniedException() {
        User otherUser = new User();
        otherUser.setId(200L);
        otherUser.setEmail("other@user.com");

        Order mockOrder = new Order();
        mockOrder.setId(1L);
        mockOrder.setUser(otherUser);
        mockOrder.setStatus(Order.Status.PENDING);

        Mockito.when(orderRepository.findById(1L)).thenReturn(Optional.of(mockOrder));

        assertThrows(AccessDeniedException.class, () -> orderService.cancelOrder(1L));
        Mockito.verify(orderRepository, Mockito.never()).save(any(Order.class));
    }
}
