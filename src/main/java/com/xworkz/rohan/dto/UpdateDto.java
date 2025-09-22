package com.xworkz.rohan.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import javax.validation.constraints.*;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpdateDto {
    @NotNull
    @Size(min = 3,max = 10,message = "Name should be Between 3 to 10")
    private String name;

    @NotNull
    @Pattern(regexp = "^[A-Za-z0-9._%+-]+@gmail\\.com$", message = "Email not Matching")
    private String email;


//    @NotNull(message = "Phone number is required")
    @NotNull
    @Min(value = 1000000000L, message = "Phone number must be 10 digits")
    @Max(value = 9999999999L, message = "Phone number must be 10 digits")
    private Long phoneNumber;

    @NotNull
    @Min(15)
    @Max(50)
    private Integer age;

    @NotNull(message = "gender should not be empty")
    private String gender;

    @NotNull(message = "Address should be empty")
    private String address;

    private MultipartFile profileImage;  // file upload

    private LocalDateTime localDateTime;

    private String imagePath;
}



