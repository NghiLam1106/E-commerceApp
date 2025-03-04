package org.example.back_end.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back_end.security.dto.LoginRequest;
import org.example.back_end.security.dto.LoginResponse;
import org.example.back_end.security.dto.RegistrationRequest;
import org.example.back_end.security.dto.RegistrationResponse;
import org.example.back_end.security.jwt.JwtTokenService;
import org.example.back_end.service.UserService;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.validation.Valid;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
public class Authentication {

    private final JwtTokenService jwtTokenService;

    private final UserService userService;

    // private final ExceptionMessageAccessor accessor;

    @PostMapping(value="/login", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<LoginResponse> loginRequest(@Valid @RequestBody LoginRequest loginRequest) {

        final LoginResponse loginResponse = jwtTokenService.getLoginResponse(loginRequest);
        return ResponseEntity.ok(loginResponse);
    }

    @PostMapping(value="/register", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<RegistrationResponse> registrationRequest(@Valid @RequestBody RegistrationRequest registrationRequest) {
        if (!registrationRequest.getPassword().equals(registrationRequest.getConfirm_password())) {
            // throw new InvalidSyntaxException(accessor.getMessage(null, "password_and_confirm_password_no_match"));
        }

        final RegistrationResponse registrationResponse = userService.registration(registrationRequest);

        return ResponseEntity.status(HttpStatus.CREATED).body(registrationResponse);

    }

//    @ExceptionHandler(InvalidAuthenticationException.class)
//    @ResponseStatus(HttpStatus.UNAUTHORIZED)
//    ResponseEntity<ApiExceptionResponse> handleInvalidAuthenticationException(InvalidAuthenticationException exception) {
//
//        final ApiExceptionResponse response = new ApiExceptionResponse(ExceptionConstants.INVALID_AUTHENTICATED.getCode(),
//                accessor.getMessage(null, ExceptionConstants.INVALID_AUTHENTICATED.getMessageName()));
//        log.warn("InvalidAuthenticationException: {}", response.getMessage());
//        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
//    }

}
