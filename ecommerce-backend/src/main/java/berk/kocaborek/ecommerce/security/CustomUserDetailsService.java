
package berk.kocaborek.ecommerce.security;

import berk.kocaborek.ecommerce.entity.User;
import berk.kocaborek.ecommerce.repository.UserRepository;
import lombok.RequiredArgsConstructor;

import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(email)
            .orElseThrow(() -> new UsernameNotFoundException("User not found with email: " + email));

        return user;
    }
}
