package com.java4.user.dao;

import com.java4.user.entity.User;
import com.java4.utils.XJPA;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class UserDAOImpl implements UserDAO{
    EntityManager em = XJPA.getEntityManager();

    @Override
    protected void finalize() throws Throwable {
            em.close();
    }

    @Override
    public List<User> findAll(){
        String jpql = "SELECT u FROM User u";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        return query.getResultList();
    }

    @Override
    public User findById(String id){
        return em.find(User.class, id);
    }

    @Override
    public void create(User user){
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
            System.out.println("Create user successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    @Override
    public void update(User user){
        try {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
            System.out.println("Update user successfully!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    @Override
    public void deleteById(String id){
        User user = em.find(User.class, id);
        try {
            em.getTransaction().begin();
            em.remove(user);
            em.getTransaction().commit();
            System.out.println("Delete user successfully!");
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    public List<User> findByEmail(String email){
        String jpql = "SELECT u FROM User u WHERE u.email LIKE :email";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        query.setParameter("email", email);
        return query.getResultList();
    }

    public List<User> page(int pageNo){
        int pageSize = 5;
        String jpql = "SELECT u FROM User u";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        query.setFirstResult((pageNo - 1) * pageSize);
        query.setMaxResults(pageSize);
        return query.getResultList();
    }
}