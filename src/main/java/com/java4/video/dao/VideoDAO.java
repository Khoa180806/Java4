package com.java4.video.dao;

import com.java4.video.entity.Video;

import java.util.List;

public interface VideoDAO {
    List<Video> findAll();
    Video findById(String id);
    List<Video> findByTitleContaining(String keyword);
    void create(Video video);
    void update(Video video);
    void deleteById(String id);
}
