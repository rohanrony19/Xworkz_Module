package com.xworkz.rohan.service;

import com.xworkz.rohan.dto.SignUpDto;
import com.xworkz.rohan.dto.UpdateDto;
import com.xworkz.rohan.entity.SignUpEntity;
import com.xworkz.rohan.repository.SignUpRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.validation.Valid;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Properties;
import java.util.Random;

@Service
public class SignUpServiceImpl implements SignUpService{

    @Autowired
    SignUpRepository repository;
    BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public boolean save(SignUpDto sign) {
        SignUpEntity signUpEntity = new SignUpEntity();
        signUpEntity.setName(sign.getName());
        signUpEntity.setAge(sign.getAge());
        signUpEntity.setEmail(sign.getEmail());
        getEmail(signUpEntity.getEmail(),"Register Successful","Dear User," + "\n\n Your registration for xworkz is succesful"); //email integration
        signUpEntity.setAddress(sign.getAddress());
        signUpEntity.setGender(sign.getGender());
        signUpEntity.setPhoneNumber(sign.getPhoneNumber());
        signUpEntity.setLocalDateTime(LocalDateTime.now());
        signUpEntity.setPassword(passwordEncoder.encode(sign.getPassword()));
        return repository.save(signUpEntity);
    }

    @Override
    public SignUpDto find(String email, String password) {
        SignUpDto registerDto=new SignUpDto();
        LocalDateTime localDateTime=LocalDateTime.now();

        SignUpEntity entity = repository.find(email);
        if(entity==null){
            registerDto.setEmail("notfound");
            return registerDto;
        }
        else {
                if(entity.getLoginAttempt()==3 ) {
                    if(localDateTime.isAfter(entity.getLocalDateTime())){
                        SignUpDto dto = new SignUpDto();
                        dto.setEmail("TimeOut");
                        return dto;
                    }else{
                        SignUpDto dto = new SignUpDto();
                        dto.setEmail("Locked");
                        getEmail(entity.getEmail(), "Account Status","Dear "+entity.getName()+"\n\nYour account has been Blocked for 24hrs .Please reset the password after 24hrs");
                        return dto;
                    }
                }
            else {
                if (passwordEncoder.matches(password, entity.getPassword())) {
                    BeanUtils.copyProperties(entity, registerDto);
                    entity.setLoginAttempt(0);
                    entity.setLocalDateTime(null);
                    return registerDto;
                } else {
                    int trails = entity.getLoginAttempt() + 1;
                    entity.setLocalDateTime(localDateTime);
                    entity.setLoginAttempt(trails);
                    if(entity.getLoginAttempt()==3){
                        entity.setLocalDateTime(entity.getLocalDateTime().plusDays(1));
                    }
                }
            }
            repository.updateTable(entity);
            return null;
        }
    }

    String fetchedEmail="";
    @Override
    public SignUpDto findByEmail(String email) {
        SignUpEntity sign = repository.findByEmail(email);
        System.out.println("in findby email");
        if (sign == null) {
            System.out.println("no record found" + email);
            return null;
        } else {
            SignUpDto signUpDto = new SignUpDto();
            BeanUtils.copyProperties(sign, signUpDto);
            System.out.println(signUpDto.toString());
            fetchedEmail = signUpDto.getEmail();
            return signUpDto;
        }
    }


    @Override
    public String updatePassword(String newPassword) {
        // 1️⃣ Fetch last stored password
        String lastPasswordHash = repository.getLastPassword(fetchedEmail);

        // 2️⃣ Check if new password matches the old one
        if (lastPasswordHash != null && passwordEncoder.matches(newPassword, lastPasswordHash)) {
            return "reuseError"; // prevent reuse
        }

        // 3️⃣ Encode new password
        String encodedPassword = passwordEncoder.encode(newPassword);

        // 4️⃣ Update in DB
        boolean updated = repository.updateNewPassword(fetchedEmail, encodedPassword);

        // 5️⃣ Return a String instead of boolean
        if (updated) {
            getEmail(
                    fetchedEmail,
                    "Password Changed",
                    "Dear User,\n\nYour account password has been changed successfully."
            );
            return "success";
        } else {
            return "fail";
        }
    }


    @Override
    public boolean updateProfile(@Valid UpdateDto sign) {
        SignUpEntity signUp=new SignUpEntity();
        signUp.setName(sign.getName());
        signUp.setEmail(sign.getEmail());
        signUp.setPhoneNumber(sign.getPhoneNumber());
        signUp.setAge(sign.getAge());
        signUp.setAddress(sign.getAddress());
        signUp.setLocalDateTime(LocalDateTime.now());
        signUp.setImagePath(sign.getImagePath());
        return repository.updateProfile(signUp);
    }


    private String generatedOtp="";
    @Override
    public void sendOtp(String email) {
        Random random=new Random();
        StringBuilder builder=new StringBuilder();
        for (int i = 0; i <6 ; i++) {
            builder.append(random.nextInt(10));
        }
        generatedOtp=builder.toString();
        getEmail(email,"OTP Sent","Dear User ,"+"\nThe Otp for  you is \n"+generatedOtp);
    }


    @Override
    public boolean verifyOtp(String otp) {
        return otp.equals(generatedOtp);
    }

    @Override
    public int countByEmail(String userEmail) {
        return Math.toIntExact(repository.countEmail(userEmail));
    }

    @Override
    public boolean passwordValidate(String password) {
        List<String> fetchedPasswords= repository.checkPassword(password);
        for (String fetchedPassword:fetchedPasswords){
            if(passwordEncoder.matches(password,fetchedPassword)){
                return true;
            }
        }
        return false;
    }

    private void getEmail(String email,String subject,String body){
        final String username = "rohanprasad.rony@gmail.com";
        final String password = "mlom rihf ptwn ahdz";

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); //TLS

        Session session = Session.getInstance(prop,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });
        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(email)
            );
            message.setSubject(subject);
            message.setText(body);

            Transport.send(message);


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
