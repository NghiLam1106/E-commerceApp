package org.example.back_end.security.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;

@Getter
@Setter
@NoArgsConstructor
public class LoginRequest {

    @NotEmpty(message = "{email_not_empty}")
    private String email;

    @NotEmpty(message = "{password_not_empty}")
    private String password;

}
