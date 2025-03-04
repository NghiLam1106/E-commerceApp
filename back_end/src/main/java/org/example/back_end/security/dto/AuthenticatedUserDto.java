package org.example.back_end.security.dto;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class AuthenticatedUserDto {

    private Long id;

    private String fullname;

    private String email;

    private String password;

}
