<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>OTP Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #e9ecef 70%, #eaf0fb 100%);
        }
        .otp-container {
            max-width: 420px;
            margin: 60px auto;
            padding: 32px 28px 28px 28px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 12px 32px rgba(0,0,0,.12);
        }
        .otp-title {
            font-weight: 700;
            color: #198754; /* Green like SignUp */
            margin-bottom: 10px;
        }
        .btn-verify {
            width: 100%;
            font-weight: 600;
        }
        .form-control {
            border-radius: 7px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-light bg-light border-bottom">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="https://www.x-workz.in/Logo.png" alt="xworkz" width="100" height="50">
        </a>
        <div class="d-grid gap-2 d-md-block">
            <a class="btn btn-success rounded-pill m-2" href="index.jsp" role="button">Home</a>
        </div>
    </div>
</nav>

<div class="otp-container">
    <h3 class="otp-title text-center mb-4">OTP Login</h3>

    <!-- Email Verify -->
    <form action="emailVerify" method="post" class="mb-3">
        <div class="mb-3">
            <label for="emailId" class="form-label">Email</label>
            <input type="email" class="form-control" id="emailId" name="email" value="${email}" required>
        </div>
        <div class="text-center">
            <button class="btn btn-success btn-verify">Verify Email</button>
        </div>
    </form>

    <c:if test="${not empty result}">
        <c:if test="${result eq 'notVerified'}">
            <div class="alert alert-warning text-center">Email Not Verified</div>
        </c:if>
        <c:if test="${result eq 'verified'}">
            <div class="alert alert-success text-center py-2">
                Email Verified. OTP has been sent to your mail.
            </div>
        </c:if>
    </c:if>

    <!-- OTP Verify -->
    <form action="otpVerify" method="post" class="mt-3">
        <div class="mb-3">
            <label for="otpId" class="form-label">Enter OTP</label>
            <input type="text" class="form-control" id="otpId" name="otp" required>
        </div>
        <div class="text-center">
            <button class="btn btn-success btn-verify">Verify OTP</button>
        </div>
    </form>

    <c:if test="${not empty status}">
        <c:if test="${status eq 'fail'}">
            <div class="alert alert-danger text-center mt-3">
                OTP Not Verified. <a href="resendOtp" class="alert-link">Resend OTP</a>
            </div>
        </c:if>
    </c:if>
</div>

<script src="index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
</body>
</html>
