package com.xworkz.rohan.controller;

import com.xworkz.rohan.dto.PasswordDto;
import com.xworkz.rohan.dto.SignUpDto;
import com.xworkz.rohan.dto.UpdateDto;
import com.xworkz.rohan.service.SignUpService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;

@Slf4j
@Controller
@RequestMapping("/")
public class SignUpController {

    @Autowired
    private SignUpService signUpService;

    // ---------------- SIGN UP ----------------
    @RequestMapping("signUp")
    public ModelAndView signUpForm(@Valid SignUpDto signUpDto, BindingResult result, ModelAndView modelAndView) {
        modelAndView.setViewName("SignUp");
        if (result.hasErrors()) {
            modelAndView.addObject("errors", result.getAllErrors());
            modelAndView.addObject("dto", signUpDto);
        } else {
            boolean status = signUpService.save(signUpDto);
            modelAndView.addObject("status", status);
            modelAndView.setViewName("SignIn");
        }
        return modelAndView;
    }

    // ---------------- SIGN IN ----------------
    @RequestMapping("SignIn")
    public ModelAndView signIn(String email, String password, ModelAndView modelAndView, HttpSession session) {
        SignUpDto dto = signUpService.find(email, password);

        if (dto == null) {
            modelAndView.addObject("result", "false");
            modelAndView.setViewName("Signin");
        } else if(dto.getEmail().equals("Locked")){
            modelAndView.addObject("result", "fail");
            modelAndView.setViewName("Signin");
        } else if (dto.getEmail().equals("TimeOut")) {
            modelAndView.addObject("result", "reset");
            modelAndView.setViewName("Signin");
        } else if (dto.getEmail().equals("notfound")) {
            modelAndView.addObject("result", "notfound");
            modelAndView.setViewName("Signin");
        } else {
            session.setAttribute("loginEmail", dto.getEmail());
            session.setAttribute("loginName",dto.getName());
//            session.setAttribute("loginName", dto.getName());
            session.setAttribute("loginPassword", dto.getPassword());
            modelAndView.setViewName("Home");
        }

        return modelAndView;
    }

    @RequestMapping("update")
    public ModelAndView showUpdate(ModelAndView view, HttpSession session) {
        String sessionEmail=(String)session.getAttribute("loginEmail");
        SignUpDto registerDto = signUpService.findByEmail(sessionEmail);
        UpdateDto updateDto=new UpdateDto();
        BeanUtils.copyProperties(registerDto,updateDto);
        log.info(registerDto.toString());
        view.addObject("dto", updateDto);
        view.setViewName("UpdateProfile");
        return view;
    }



    // ---------------- UPDATE PROFILE (POST) ----------------
    @PostMapping("/UpdateProfile")
    public ModelAndView updateProfile(@Valid UpdateDto dto, BindingResult result,
                                      @RequestParam("profileImage") MultipartFile file,
                                      ModelAndView view, HttpSession session) throws IOException {

        if (result.hasErrors()) {
            view.addObject("errors", result.getAllErrors());
            view.setViewName("UpdateProfile");
            return view;
        }

        if (file != null && !file.isEmpty()) {
            // Directory path
            Path dirPath = Paths.get("D:\\moduleImages");

            // Create directories if not exists
            if (!Files.exists(dirPath)) {
                Files.createDirectories(dirPath);
            }

            // Save the file
            String filename = dto.getName() + System.currentTimeMillis() + ".jpg";
            Path filePath = dirPath.resolve(filename);
            Files.write(filePath, file.getBytes());
            dto.setImagePath(filename);
        }

        dto.setLocalDateTime(LocalDateTime.now());
        // Update profile in service
        boolean status = signUpService.updateProfile(dto);

        if (status) {
            SignUpDto updatedDto = signUpService.findByEmail(dto.getEmail());
            view.addObject("status", "done");
            view.addObject("dto", updatedDto);
            session.setAttribute("loginName", updatedDto.getName());
        } else {
            view.addObject("status", "error");
            view.addObject("dto", dto);
        }

        view.setViewName("UpdateProfile");
        return view;
    }


    // ---------------- DOWNLOAD IMAGE ----------------
    @GetMapping("download")
    public void download(HttpServletResponse response, @RequestParam String imagePath) throws IOException {
        response.setContentType("image/jpeg");
        File file=new File("D:\\moduleImages\\"+imagePath);
        InputStream inputStream=new BufferedInputStream(new FileInputStream(file));
        ServletOutputStream outputStream=response.getOutputStream();
        IOUtils.copy(inputStream,outputStream);
        response.flushBuffer();
    }


    // ---------------- PASSWORD RESET ----------------
    @RequestMapping("verifyUserEmail")
    public ModelAndView verifyEmail(String email, ModelAndView modelAndView) {
        SignUpDto signUpDto = signUpService.findByEmail(email);
        modelAndView.addObject("email", email);
        if (signUpDto != null) {
            modelAndView.addObject("status", "success");
            modelAndView.setViewName("ForgotPassword");
        } else {
            modelAndView.addObject("status", "fail");
            modelAndView.setViewName("VerifyEmail");
        }
        return modelAndView;
    }

    @RequestMapping("updatePassword")
    public ModelAndView updatePassword(@Valid PasswordDto passwordDto, BindingResult result, ModelAndView view) {
        if (result.hasErrors()) {
            view.addObject("errors", result.getAllErrors());
            view.setViewName("ForgotPassword");
        } else {
            boolean updateStatus = signUpService.updatePassword(passwordDto.getPassword());
            view.addObject("submitted", true);
            view.addObject("status", updateStatus);
            view.setViewName("ForgotPassword");
        }
        return view;
    }

    // ---------------- HOME ----------------
    @RequestMapping("home")
    public ModelAndView getHomePage(ModelAndView modelAndView) {
        modelAndView.setViewName("Home");
        return modelAndView;
    }

    // ---------------- OTP LOGIN ----------------
    @RequestMapping("emailVerify")
    public ModelAndView verifyUserMail(String email, ModelAndView modelAndView, HttpSession session) {
        SignUpDto dto = signUpService.findByEmail(email);
        if (dto != null) {
            signUpService.sendOtp(email);
            session.setAttribute("loginEmailForOtp", email);
            modelAndView.addObject("result", "verified");
            modelAndView.setViewName("OtpLogin");
        } else {
            modelAndView.addObject("result", "notVerified");
            modelAndView.addObject("email", email);
            modelAndView.setViewName("OtpLogin");
        }
        return modelAndView;
    }

    @RequestMapping("otpVerify")
    public ModelAndView verifyOtp(String otp, ModelAndView view, HttpSession session) {
        String email = (String) session.getAttribute("loginEmailForOtp");
        boolean check = signUpService.verifyOtp(otp);
        if (!check) {
            view.addObject("status", "fail");
            view.addObject("email", email);
            view.setViewName("OtpLogin");
        } else {
            SignUpDto dto = signUpService.findByEmail(email);
            session.setAttribute("loginName", dto.getName());
            session.setAttribute("loginEmail", dto.getEmail());
            view.setViewName("Home");
        }
        return view;
    }

    @RequestMapping("resendOtp")
    public ModelAndView resendOtp(ModelAndView view, HttpSession session) {
        String email = (String) session.getAttribute("loginEmailForOtp");
        signUpService.sendOtp(email);
        view.addObject("email", email);
        view.addObject("result", "verified");
        view.setViewName("OtpLogin");
        return view;
    }
}
