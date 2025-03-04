package org.example.back_end.security.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back_end.model.User;
import org.example.back_end.repository.UserRepository;
import org.example.back_end.security.dto.UserPrinciple;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final UserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        final User authenticatedUser = userRepository.findByEmail(username);

        if (authenticatedUser == null) {
            //throw new InvalidAuthenticationException();
        }
        UserPrinciple userPrinciple = UserPrinciple.build(authenticatedUser);
        log.debug("{} is {}", authenticatedUser.getEmail(), userPrinciple.getAuthorities());
        return UserPrinciple.build(authenticatedUser);
    }

    public UserPrinciple loadUserByUserId(Long userId) throws UsernameNotFoundException {
//		final User authenticatedUser = userRepository.findById(userId)
//				.orElseThrow(() -> new InvalidAuthenticationException());
        final User authenticatedUser = userRepository.findById(userId)
                .orElseThrow(() -> null);
        UserPrinciple userPrinciple = UserPrinciple.build(authenticatedUser);
        log.debug("{} is {}", authenticatedUser.getEmail(), userPrinciple.getAuthorities());
        return userPrinciple;
    }
}
