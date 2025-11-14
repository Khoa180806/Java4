package com.java4.favorite.dao;

import com.java4.favorite.entity.Favorite;

import java.util.List;

public interface FavoriteDAO {
    List<Favorite> findAll();
    Favorite findById(Integer id);
    void create(Favorite favorite);
    void update(Favorite favorite);
    void deleteById(Integer id);
    List<Favorite> findByUserId(String userId);
}
