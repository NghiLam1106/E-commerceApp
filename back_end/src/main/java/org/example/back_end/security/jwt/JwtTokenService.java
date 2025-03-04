package org.example.back_end.security.jwt;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back_end.security.dto.LoginRequest;
import org.example.back_end.security.dto.LoginResponse;
import org.example.back_end.security.dto.UserPrinciple;
import org.example.back_end.service.UserService;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class JwtTokenService {

    private final UserService userService;

    private final JwtTokenManager 			jwtTokenManager;

    private final AuthenticationManager authenticationManager;

    public LoginResponse getLoginResponse(LoginRequest loginRequest) {

        final String email 				= 	loginRequest.getEmail();
        final String password 			= 	loginRequest.getPassword();

        final UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(
                email, password);

        // Xác thực từ username và password.
        Authentication authentication 	= authenticationManager.authenticate(usernamePasswordAuthenticationToken);

        UserPrinciple userPrinciple 	= (UserPrinciple) authentication.getPrincipal();
        final String token 				= jwtTokenManager.generateToken(userPrinciple);

        log.info("{} has successfully logged in!", userPrinciple.getUsername());

        return new LoginResponse(token);
    }

}
