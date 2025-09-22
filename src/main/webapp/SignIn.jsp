<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign Up</title>
    <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">-->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #e9ecef 70%, #eaf0fb 100%);
        }
        .signup-container {
            max-width: 420px;
            margin: 60px auto;
            padding: 32px 28px 28px 28px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 12px 32px rgba(0,0,0,.12);
        }
        .form-label, .col-form-label {
            font-weight: 500;
        }
        .signup-title {
            font-weight: 700;
            color: #198754;
            margin-bottom: 10px;
        }
        .btn-signup {
            width: 100%;
            font-weight: 600;
        }
        .form-control {
            border-radius: 7px;
        }
        .input-group-text {
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="signup-container">
    <h3 class="signup-title text-center mb-2">Sign In</h3>
    <div class="mb-3 text-center text-danger">
        <c:if test="${not empty errors}">
            <div class="alert alert-secondary" role="alert">
                <c:forEach var="error" items="${errors}">
                    <p>${error.defaultMessage}</p>
                </c:forEach>
            </div>
        </c:if>
    </div>

    <form action="SignIn" method="post">

        <div class="mb-3">
            <label for="emailId" class="form-label">Email <span style="color:red">*</span></label>
            <input type="email" id="emailId" onchange="validateEmail()" class="form-control" name="email" required/>
            <span id="emailError" class="text-danger"></span>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password <span style="color:red">*</span></label>
            <div class="input-group">
                <input type="password" onchange="validatePassword()" id="password" class="form-control" name="password"
                       required minlength="8" maxlength="15"/>
                <span class="input-group-text" onclick="togglePassword('password', 'toggleIcon1')">
            <i class="bi bi-eye" id="toggleIcon1"></i>
        </span>
            </div>
            <span id="passwordError" class="text-danger"></span>
        </div>
        <div><a href="OtpLogin.jsp">OTP Login</a> </div>
        <div class="mb-3">
            <button class="btn btn-success btn-signup mt-3" type="submit">Sign In</button>
        </div>

        <div>
            <c:if test="${not empty result}">

                <c:if test="${result eq 'false'}">
                    <p class="text-warning text-center">Invalid Credentials</p>
                </c:if>
                <c:if test="${result eq 'notfound'}">
                    <p class="text-warning text-center">Invalid UserName</p>
                </c:if>
                <c:if test="${result eq 'fail'}">
                    <p class="text-warning text-center">Your Account has Been Blocked till 24hrs</p>
                    <p class="text-center"><a class="link-opacity-50 " href="VerifyEmail.jsp">forgot password</a></p>
                </c:if>
                <c:if test="${result eq 'reset'}">
                    <div class="mt-2">
                        <p class="text-warning text-center">You can Reset Password</p>
                        <p class="text-center"><a class="link-opacity-50 " href="VerifyEmail.jsp">forgot password</a></p>
                    </div>
                </c:if>
            </c:if>

        </div>
    </form>
</div>
<script src="index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script>
    function togglePassword(inputId, iconId) {
        const input = document.getElementById(inputId);
        const icon = document.getElementById(iconId);
        if (input.type === "password") {
            input.type = "text";
            icon.classList.remove("bi-eye");
            icon.classList.add("bi-eye-slash");
        } else {
            input.type = "password";
            icon.classList.remove("bi-eye-slash");
            icon.classList.add("bi-eye");
        }
    }
</script>
</body>
</html>
