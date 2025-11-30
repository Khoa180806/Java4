package com.java4.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQueries;
import jakarta.persistence.NamedQuery;
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
@NamedQueries({
    @NamedQuery(name = "Video.findByTitleContaining", 
        query = "SELECT v FROM Video v WHERE v.title LIKE :keyword"),
    @NamedQuery(name = "Video.findTop10MostLiked",
        query = "SELECT v FROM Video v LEFT JOIN v.favorites f GROUP BY v ORDER BY COUNT(f) DESC"),
    @NamedQuery(name = "Video.findWithNoLikes",
        query = "SELECT v FROM Video v WHERE v.id NOT IN (SELECT DISTINCT f.video.id FROM Favorite f)")
})
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
