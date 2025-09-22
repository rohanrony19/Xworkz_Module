package com.xworkz.rohan.service;

import com.xworkz.rohan.dto.SignUpDto;
import com.xworkz.rohan.dto.UpdateDto;

import javax.validation.Valid;

public interface SignUpService {
    boolean save(SignUpDto sign);
    SignUpDto find(String email,String password);
    SignUpDto findByEmail(String email);
    boolean updatePassword(String password);
    boolean updateProfile(@Valid UpdateDto sign);
    void sendOtp(String email);
    boolean verifyOtp(String otp);
    int countByEmail(String userEmail);
    boolean passwordValidate(String password);
}
