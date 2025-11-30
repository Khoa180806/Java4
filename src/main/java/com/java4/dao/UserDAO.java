package com.java4.dao;

import com.java4.entity.User;

import java.util.List;

public interface UserDAO {
    List<User> findAll();
    User findById(String id);
    User findByIdOrEmail(String username);
    void create(User user);
    void update(User user);
    void deleteById(String id);
}
