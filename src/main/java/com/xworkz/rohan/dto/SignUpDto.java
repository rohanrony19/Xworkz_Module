package com.xworkz.rohan.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.*;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SignUpDto {
    @NotNull
    @Size(min = 3,max = 30,message = "Name should be between 3 and 30")
    @Pattern(regexp = "^[A-Za-z]+$",message = "Name has numbers")
    private String name;

    @NotNull(message = "Phone number is required")
    @Min(value = 6000000000L, message = "Number should start from 6|7|8|9")
    @Max(value = 9999999999L, message = "Phone number must be 10 digits")
    private Long phoneNumber;

    @NotNull
    @Pattern(regexp = "^[A-Za-z0-9]+@gmail\\.com$", message = "Email not Matching")
    private String email;

    @NotNull
    @Min(value = 15,message = "Age should be between 15 to 50")
    @Max(value = 50,message = "Age should not be above 50")
    private Integer age;

    @NotNull(message = "gender should not be empty")
    private String gender;
    @NotNull(message = "Address should be empty")
    private String address;
    @NotNull(message = "Password should not be empty")
    @Pattern(regexp = "^(?=.*[A-Z])(?=.*[^A-Za-z0-9])(?=(?:.*\\d){2,}).{3,15}$", message = "password should match")
    private String password;

    private LocalDateTime localDateTime;
    private String imagePath;
}
