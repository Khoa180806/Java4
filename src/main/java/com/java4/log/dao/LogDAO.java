package com.java4.log.dao;

import com.java4.log.entity.Log;

import java.util.List;

public interface LogDAO {
    void create(Log log);
    List<Log> findAll();
    List<Log> findByUsername(String username);
}
