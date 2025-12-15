package com.java4.dao;

import com.java4.entity.Product;
import com.java4.utils.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class ProductDAOImpl implements ProductDAO {
    EntityManager em = XJPA.getEntityManager();

    @Override
    protected void finalize() throws Throwable {
        em.close();
    }

    @Override
    public List<Product> findAll() {
        String jpql = "SELECT p FROM Product p";
        TypedQuery<Product> query = em.createQuery(jpql, Product.class);
        return query.getResultList();
    }

    @Override
    public Product findById(String id) {
        return em.find(Product.class, id);
    }

    @Override
    public void create(Product product) {
        try {
            em.getTransaction().begin();
            em.persist(product);
            em.getTransaction().commit();
            System.out.println("Create product successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void update(Product product) {
        try {
            em.getTransaction().begin();
            em.merge(product);
            em.getTransaction().commit();
            System.out.println("Update product successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void deleteById(String id) {
        Product product = em.find(Product.class, id);
        try {
            em.getTransaction().begin();
            em.remove(product);
            em.getTransaction().commit();
            System.out.println("Delete product successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }
}
