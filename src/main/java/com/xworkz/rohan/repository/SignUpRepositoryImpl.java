package com.xworkz.rohan.repository;

import com.xworkz.rohan.entity.SignUpEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Repository
public class SignUpRepositoryImpl implements SignUpRepository{

    @Autowired
    EntityManagerFactory emf;

    @Override
    public boolean save(SignUpEntity signUpEntity) {
        EntityManager em = null;
        EntityTransaction et = null;
        try {
            em = emf.createEntityManager();
            et = em.getTransaction();

            et.begin();

            em.persist(signUpEntity);

            et.commit();
            return true;
        }catch (Exception e){
            if(et!=null && et.isActive()){
                et.rollback();
            }
            e.printStackTrace();
        }finally {
            em.close();
        }

        return false;
    }

    @Override
    public SignUpEntity find(String email) {
        EntityManager manager=null;
        EntityTransaction transaction=null;
        SignUpEntity signUp = new SignUpEntity();
        try{
            manager = emf.createEntityManager();
            transaction = manager.getTransaction();
            transaction.begin();
            try {
                Query query = manager.createNamedQuery("getSignUpDetails");
                query.setParameter("emailBy",email);
                signUp = (SignUpEntity) query.getSingleResult();
            }catch (NoResultException e){
                return null;
            }
            transaction.commit();
        }catch (Exception e){
            if(transaction != null && transaction.isActive()){
                transaction.rollback();
            }e.printStackTrace();
        }finally {
            manager.close();
        }
        return signUp;
    }

    @Override
    public SignUpEntity findByEmail(String email) {
        EntityManager entityManager=null;
        EntityTransaction transaction=null;
        SignUpEntity signUp= null;
        try{
            entityManager=emf.createEntityManager();
            transaction= entityManager.getTransaction();
            transaction.begin();

            Query query= entityManager.createNamedQuery("checkEmail");
            query.setParameter("emailBy",email);
            signUp=(SignUpEntity) query.getSingleResult();

            transaction.commit();


        }catch (Exception e){
            if(transaction.isActive()){
                transaction.rollback();
            }
        }finally {
            entityManager.close();
        }

        return signUp;
    }

    @Override
    public boolean updatePassword(String email, String password) {
        EntityManager entityManager=null;
        EntityTransaction transaction=null;
        SignUpEntity signUp= new SignUpEntity();
        try{
            entityManager=emf.createEntityManager();
            transaction= entityManager.getTransaction();
            transaction.begin();



            signUp=findByEmail(email);
            signUp.setPassword(password);
            signUp.setLoginAttempt(0);
            signUp.setLocalDateTime(null);

            entityManager.merge(signUp);
            transaction.commit();

            return true;
        }catch (Exception e){
            if(transaction.isActive()){
                transaction.rollback();
            }
        }finally {
            entityManager.close();
        }

        return false;
    }

    @Override
    public boolean updateProfile(SignUpEntity signUpEntity) {
        EntityManager entityManager = null;
        EntityTransaction transaction = null;
        SignUpEntity signUp = new SignUpEntity();

        try{
            entityManager=emf.createEntityManager();
            transaction= entityManager.getTransaction();
            transaction.begin();
            signUp=findByEmail(signUpEntity.getEmail());
            signUp.setName(signUpEntity.getName());
            signUp.setEmail(signUpEntity.getEmail());
            signUp.setPhoneNumber(signUpEntity.getPhoneNumber());
            signUp.setAge(signUpEntity.getAge());
            signUp.setAddress(signUpEntity.getAddress());
            signUp.setLocalDateTime(LocalDateTime.now());
            signUp.setImagePath(signUpEntity.getImagePath());


            entityManager.merge(signUp);

            transaction.commit();

            return true;
        } catch (NoResultException nre) {
            // Email not found
            if(transaction.isActive()){
                transaction.rollback();
            }
        }finally {
            entityManager.close();
        }
        return false;
    }

    public String getLastPassword(String email) {
        EntityManager em = emf.createEntityManager();
        try {
            Query query = em.createNamedQuery("getCurrentPassword");
            query.setParameter("email", email);
            return (String) query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }

    public boolean updateNewPassword(String email, String encodedPassword) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Query query = em.createQuery("UPDATE SignUpEntity p SET p.password = :password WHERE p.email = :email");
            query.setParameter("password", encodedPassword);
            query.setParameter("email", email);
            int updated = query.executeUpdate();
            tx.commit();
            return updated > 0;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            return false;
        } finally {
            em.close();
        }
    }
    @Override
    public void updateTable(SignUpEntity entity) {
        EntityManager manager=null;
        EntityTransaction transaction=null;
        try {
            manager= emf.createEntityManager();
            transaction=manager.getTransaction();
            transaction.begin();

            manager.merge(entity);

            transaction.commit();
        }catch (Exception e){
            if(transaction!=null && transaction.isActive()){
                transaction.rollback();
            }
            e.printStackTrace();
        }finally {
            manager.close();
        }
    }

    @Override
    public long countEmail(String userEmail) {
        EntityManager manager=null;
        EntityTransaction transaction=null;
        long count = 0;
        try {
            manager= emf.createEntityManager();
            transaction=manager.getTransaction();
            transaction.begin();

            Query query=manager.createNamedQuery("countEmail");
            query.setParameter("email",userEmail);
            count=(Long) query.getSingleResult();

            transaction.commit();
        }catch (Exception e){
            if(transaction!=null && transaction.isActive()){
                transaction.rollback();
            }
            e.printStackTrace();
        }finally {
            manager.close();
        }
        return count;
    }

    @Override
    public List<String> checkPassword(String password) {
        EntityManager manager=null;
        EntityTransaction transaction=null;
        List<String> fetchedPassword=new ArrayList<>();
        try {
            manager= emf.createEntityManager();
            transaction=manager.getTransaction();
            transaction.begin();

            Query query= manager.createNamedQuery("fetchPassword");
            fetchedPassword= query.getResultList();

            transaction.commit();
        }catch (Exception e){
            if(transaction!=null && transaction.isActive()){
                transaction.rollback();
            }
            e.printStackTrace();
        }finally {
            manager.close();
        }
        return fetchedPassword;
    }
}
