package org.example.back_end.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.example.back_end.model.User;
import org.example.back_end.repository.UserRepository;
import org.example.back_end.security.dto.RegistrationRequest;
import org.example.back_end.security.dto.RegistrationResponse;
import org.example.back_end.security.mapper.AuthenticationMapper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {

    private static final String REGISTRATION_SUCCESSFUL = "registration_successful";

    private final UserRepository userRepository;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    private final UserValidationService userValidationService;


    @Override
    public User findByEmail(String email) {
        User user = userRepository.findByEmail(email);

        return user;
    }

    @Override
    public RegistrationResponse registration(RegistrationRequest registrationRequest) {

        userValidationService.checkEmail(registrationRequest.getEmail());

        final User user = AuthenticationMapper.INSTANCE.convertToUser(registrationRequest);
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));


        //try {
        final String fullname = registrationRequest.getFull_name();
        final String email = registrationRequest.getEmail();

        user.setFullname(fullname);
        User savedUser = userRepository.save(user);
        Long userId = savedUser.getId();

        log.info("{} registered successfully!", email);

        return new RegistrationResponse(userId, email, fullname);
//		} catch (Exception e) {
//			//throw new InternalServerException();
//			//throw new Exception();
//		}
    }

}
