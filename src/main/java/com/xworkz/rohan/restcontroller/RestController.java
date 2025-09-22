package com.xworkz.rohan.restcontroller;

import com.xworkz.rohan.service.SignUpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@org.springframework.web.bind.annotation.RestController
@RequestMapping("/")
public class RestController {
    @Autowired
    SignUpService signUpService;

    @GetMapping(value = "checkEmail/{userEmail}",produces = MediaType.APPLICATION_JSON_VALUE)
    public String checkEmailCount(@PathVariable String userEmail){

        int count= signUpService.countByEmail(userEmail);
        if(count==0) return " ";
        else return "Email already exists";
    }

    @GetMapping(value = "checkPassword/{password}",produces = MediaType.APPLICATION_JSON_VALUE)
    public String checkPassword(@PathVariable String password){
        boolean check=signUpService.passwordValidate(password);
        if (check){
            return "Password already in use";
        }else {
            return " ";
        }
    }

}
