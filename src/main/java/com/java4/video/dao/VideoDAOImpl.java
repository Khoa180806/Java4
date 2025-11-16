package com.java4.video.dao;

import com.java4.video.entity.Video;
import com.java4.utils.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class VideoDAOImpl implements VideoDAO {
    EntityManager em = XJPA.getEntityManager();

    @Override
    protected void finalize() throws Throwable {
        em.close();
    }

    @Override
    public List<Video> findAll() {
        String jpql = "SELECT v FROM Video v";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        return query.getResultList();
    }

    @Override
    public Video findById(String id) {
        return em.find(Video.class, id);
    }

    @Override
    public List<Video> findByTitleContaining(String keyword) {
        TypedQuery<Video> query = em.createNamedQuery("Video.findByTitleContaining", Video.class);
        query.setParameter("keyword", "%" + keyword + "%");
        return query.getResultList();
    }

    @Override
    public void create(Video video) {
        try {
            em.getTransaction().begin();
            em.persist(video);
            em.getTransaction().commit();
            System.out.println("Create video successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void update(Video video) {
        try {
            em.getTransaction().begin();
            em.merge(video);
            em.getTransaction().commit();
            System.out.println("Update video successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void deleteById(String id) {
        Video video = em.find(Video.class, id);
        try {
            em.getTransaction().begin();
            em.remove(video);
            em.getTransaction().commit();
            System.out.println("Delete video successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }
}
