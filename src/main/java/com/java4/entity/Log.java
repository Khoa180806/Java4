package com.java4.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "Logs")
public class Log {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id")
    private Integer id;
    
    @Column(name = "Url", length = 500)
    private String url;
    
    @Column(name = "Time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date time;
    
    @Column(name = "Username", length = 50)
    private String username;
}
