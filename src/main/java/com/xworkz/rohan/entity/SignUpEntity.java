package com.xworkz.rohan.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "signup_details")
@NamedQuery(name="getSignUpDetails",query = "select e from SignUpEntity e where email=:emailBy")
@NamedQuery(name="checkEmail",query = "select e from SignUpEntity e where email=:emailBy")
@NamedQuery(name = "countEmail",query = "select count(e.email) from SignUpEntity e where email=:email")
@NamedQuery(name = "fetchPassword",query = "select e.password from SignUpEntity e")
public class SignUpEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "Name")
    private String name;

    @Column(name = "Phone_Number")
    private Long phoneNumber;

    @Column(name = "Email")
    private String email;

    @Column(name = "Age")
    private int age;

    @Column(name = "Password")
    private String password;

    @Column(name = "Address")
    private String address;

    @Column(name = "Gender")
    private String gender;

    @Column(name="login_attempt")
    private int loginAttempt=0;

    @Column(name="local_date_time")
    private LocalDateTime localDateTime;

    @Column(name = "image_path")
    private String imagePath;
}
