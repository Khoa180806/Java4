package com.java4.favorite.entity;

import com.java4.user.entity.User;
import com.java4.video.entity.Video;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Favorite")
public class Favorite {
    @Id
    @Column(name = "Id")
    private Integer id;
    @ManyToOne
    @JoinColumn(name = "UserId")
    private User user;
    @ManyToOne
    @JoinColumn(name = "VideoId")
    private Video video;
    @Column
    private Date likeDate;
}
