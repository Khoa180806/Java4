package com.java4.favorite.dao;

import com.java4.favorite.entity.Favorite;
import com.java4.utils.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class FavoriteDAOImpl implements FavoriteDAO {
    EntityManager em = XJPA.getEntityManager();

    @Override
    protected void finalize() throws Throwable {
        em.close();
    }

    @Override
    public List<Favorite> findAll() {
        String jpql = "SELECT f FROM Favorite f";
        TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
        return query.getResultList();
    }

    @Override
    public Favorite findById(Integer id) {
        return em.find(Favorite.class, id);
    }

    @Override
    public void create(Favorite favorite) {
        try {
            em.getTransaction().begin();
            em.persist(favorite);
            em.getTransaction().commit();
            System.out.println("Create favorite successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void update(Favorite favorite) {
        try {
            em.getTransaction().begin();
            em.merge(favorite);
            em.getTransaction().commit();
            System.out.println("Update favorite successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void deleteById(Integer id) {
        Favorite favorite = em.find(Favorite.class, id);
        try {
            em.getTransaction().begin();
            em.remove(favorite);
            em.getTransaction().commit();
            System.out.println("Delete favorite successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public List<Favorite> findByUserId(String userId) {
        String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :userId ORDER BY f.likeDate DESC";
        TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }
}
