package com.java4.user.entity;

import com.java4.favorite.entity.Favorite;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Users")
public class User {
    @Id
    @Column(name = "Id")
    private String id;
    @Column(name = "Password")
    private String password;
    @Column(name = "Fullname")
    private String fullname;
    @Column(name = "Email")
    private String email;
    @Column(name = "Admin")
    private Boolean admin = false;
    @OneToMany(mappedBy = "user")
    private List<Favorite> favorites;
}
