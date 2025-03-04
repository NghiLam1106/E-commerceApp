package org.example.back_end.model;

import lombok.*;

import javax.persistence.*;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "USER")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String fullname;

    @Column(unique = true)
    private String email;

    private String password;
}
