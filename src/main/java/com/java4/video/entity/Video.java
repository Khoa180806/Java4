package com.java4.video.entity;

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
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Video")
public class Video {
    @Id
    @Column(name = "Id")
    private String id;
    @Column(name = "Title")
    private String title;
    @Column(name = "Poster")
    private String poster;
    @Column(name = "Views")
    private Integer views;
    @Column(name = "Description")
    private String description;
    @Column(name = "Active")
    private Boolean active;
    @OneToMany(mappedBy = "video")
    private List<Favorite> favorites;
}
