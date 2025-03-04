package org.example.back_end.security.jwt;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.example.back_end.security.dto.UserPrinciple;
import org.example.back_end.security.service.UserDetailsServiceImpl;
import org.example.back_end.utils.SecurityConstants;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Service;
import org.springframework.web.filter.OncePerRequestFilter;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Objects;

@Slf4j
@Service
@RequiredArgsConstructor
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtTokenManager jwtTokenManager;

    private final UserDetailsServiceImpl userDetailsService;

    @Override
    protected void doFilterInternal(HttpServletRequest req, HttpServletResponse res, FilterChain chain) throws IOException, ServletException {

        final String requestURI = req.getRequestURI();

        if (requestURI.contains(SecurityConstants.LOGIN_REQUEST_URI) || requestURI.contains(SecurityConstants.REGISTRATION_REQUEST_URI)) {
            chain.doFilter(req, res);
            return;
        }

        final String header = req.getHeader(SecurityConstants.HEADER_STRING);
        Long userId = null;
        String authToken = null;
        if (Objects.nonNull(header) && header.startsWith(SecurityConstants.TOKEN_PREFIX)) {

            authToken = header.replace(SecurityConstants.TOKEN_PREFIX, StringUtils.EMPTY);
            try {
                userId = jwtTokenManager.getUserIdFromToken(authToken);
            }
            catch (Exception e) {
                log.error("Authentication Exception : {}", e.getMessage());
            }
        }

        final SecurityContext securityContext = SecurityContextHolder.getContext();

        if (Objects.nonNull(userId) && Objects.isNull(securityContext.getAuthentication())) {

            final UserPrinciple userDetails = userDetailsService.loadUserByUserId(userId);

            if (jwtTokenManager.validateToken(authToken, userDetails.getId())) {

                final UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
                authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(req));
                log.info("Authentication successful. Logged in userId : {} ", userId);
                securityContext.setAuthentication(authentication);
            }

        }

        chain.doFilter(req, res);
    }

}
