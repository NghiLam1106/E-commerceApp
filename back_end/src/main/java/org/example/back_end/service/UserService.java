package org.example.back_end.service;

import org.example.back_end.model.User;
import org.example.back_end.security.dto.RegistrationRequest;
import org.example.back_end.security.dto.RegistrationResponse;

public interface UserService {

    User findByEmail(String email);
    RegistrationResponse registration(RegistrationRequest registrationRequest);
}
