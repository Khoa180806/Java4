package com.java4.share.dao;

import com.java4.share.entity.Share;
import com.java4.utils.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ShareDAOImpl implements ShareDAO {
    EntityManager em = XJPA.getEntityManager();

    @Override
    protected void finalize() throws Throwable {
        em.close();
    }

    @Override
    public List<Share> findAll() {
        String jpql = "SELECT s FROM Share s";
        TypedQuery<Share> query = em.createQuery(jpql, Share.class);
        return query.getResultList();
    }

    @Override
    public Share findById(Integer id) {
        return em.find(Share.class, id);
    }

    @Override
    public void create(Share share) {
        try {
            em.getTransaction().begin();
            em.persist(share);
            em.getTransaction().commit();
            System.out.println("Create share successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void update(Share share) {
        try {
            em.getTransaction().begin();
            em.merge(share);
            em.getTransaction().commit();
            System.out.println("Update share successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void deleteById(Integer id) {
        Share share = em.find(Share.class, id);
        try {
            em.getTransaction().begin();
            em.remove(share);
            em.getTransaction().commit();
            System.out.println("Delete share successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }
}
