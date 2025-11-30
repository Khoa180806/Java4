package com.java4.dao;

import com.java4.dto.VideoShareReport;
import com.java4.entity.Share;

import java.util.List;

public interface ShareDAO {
    List<Share> findAll();
    Share findById(Integer id);
    List<VideoShareReport> getVideoShareReport();
    void create(Share share);
    void update(Share share);
    void deleteById(Integer id);
}
