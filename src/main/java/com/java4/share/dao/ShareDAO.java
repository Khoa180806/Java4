package com.java4.share.dao;

import com.java4.share.dto.VideoShareReport;
import com.java4.share.entity.Share;

import java.util.List;

public interface ShareDAO {
    List<Share> findAll();
    Share findById(Integer id);
    List<VideoShareReport> getVideoShareReport();
    void create(Share share);
    void update(Share share);
    void deleteById(Integer id);
}
