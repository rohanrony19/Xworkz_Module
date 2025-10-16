package com.xworkz.rohan.repository;

import com.xworkz.rohan.entity.SignUpEntity;
import com.xworkz.rohan.service.SignUpService;

import java.util.List;

public interface SignUpRepository {
    boolean save(SignUpEntity signUpEntity);
    SignUpEntity find(String email);
    SignUpEntity findByEmail(String email);
    boolean updatePassword(String email,String password);
    boolean updateProfile(SignUpEntity signUpEntity);
    void updateTable(SignUpEntity entity);
    long countEmail(String userEmail);
    List<String> checkPassword(String password);
    String getLastPassword(String email);
    boolean updateNewPassword(String email, String encodedPassword);

}
