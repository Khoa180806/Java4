package com.java4.lab1;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;

import java.util.List;

public class UserManager {
    EntityManagerFactory factory = Persistence.createEntityManagerFactory("PolyOE");
    EntityManager em = factory.createEntityManager();

    public void findAll(){
        String jpql = "SELECT u FROM User u";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        List<User> list = query.getResultList();
        list.forEach(user -> {
            String fullname = user.getFullname();
            Boolean Admin = user.getAdmin();
            System.out.println(fullname + ": " + Admin);
        });
    }

    public void findById(){
        User user = em.find(User.class, "PS45143");
        String fullname = user.getFullname();
        Boolean admin = user.getAdmin();
        System.out.println(fullname + ": " + admin);
    }

    public void create(){
        User user = new User("PS12345", "123", "Vinh", "vinh@gmail.com", false);
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    public void update(){
        User user = em.find(User.class, "PS12345");
        user.setFullname("Long");
        user.setEmail("long@gmail.com");
        try {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteById(){
        User user = em.find(User.class, "PS12345");
        try {
            em.getTransaction().begin();
            em.remove(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
        }
    }

    public void findByEmail(){
        String jpql = "SELECT u FROM User u WHERE u.email LIKE :email AND u.admin = :role";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        query.setParameter("email", "%@fpt.edu.vn");
        query.setParameter("role", false);
        List<User> list = query.getResultList();
        list.forEach(user -> {
            String fullname = user.getFullname();
            String email = user.getEmail();
            System.out.println(fullname + ": " + email);
        });
    }

    public void page(){
        int pageNo = 3;
        int pageSize = 5;
        String jpql = "SELECT u FROM User u";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        query.setFirstResult((pageNo - 1) * pageSize);
        query.setMaxResults(pageSize);
        List<User> list = query.getResultList();
        list.forEach(user -> {
            String fullname = user.getFullname();
            String email = user.getEmail();
            Boolean admin = user.getAdmin();
            System.out.println(fullname + " - " + email + " - " + admin);
        });
    }
}