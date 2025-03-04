package org.example.back_end.security.mapper;

import org.example.back_end.model.User;
import org.example.back_end.security.dto.RegistrationRequest;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface AuthenticationMapper {

    AuthenticationMapper INSTANCE = Mappers.getMapper(AuthenticationMapper.class);

    User convertToUser(RegistrationRequest registrationRequest);


}
