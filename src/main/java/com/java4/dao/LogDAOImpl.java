package com.java4.dao;

import com.java4.entity.Log;
import com.java4.utils.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class LogDAOImpl implements LogDAO {
    EntityManager em = XJPA.getEntityManager();

    @Override
    protected void finalize() throws Throwable {
        em.close();
    }

    @Override
    public void create(Log log) {
        try {
            em.getTransaction().begin();
            em.persist(log);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            System.err.println("Error creating log: " + e.getMessage());
        }
    }

    @Override
    public List<Log> findAll() {
        String jpql = "SELECT l FROM Log l ORDER BY l.time DESC";
        TypedQuery<Log> query = em.createQuery(jpql, Log.class);
        return query.getResultList();
    }

    @Override
    public List<Log> findByUsername(String username) {
        String jpql = "SELECT l FROM Log l WHERE l.username = :username ORDER BY l.time DESC";
        TypedQuery<Log> query = em.createQuery(jpql, Log.class);
        query.setParameter("username", username);
        return query.getResultList();
    }
}
