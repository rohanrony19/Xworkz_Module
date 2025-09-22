<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sign Up</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

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
    <h3 class="signup-title text-center mb-2">Sign Up</h3>
    <div class="mb-3 text-center text-danger">
        <c:if test="${not empty errors}">
            <div class="alert alert-secondary" role="alert">
                <c:forEach var="error" items="${errors}">
                    <p>${error.defaultMessage}</p>
                </c:forEach>
            </div>
        </c:if>
    </div>
    <form action="signUp" method="post">
        <div class="mb-3">
            <label for="nameId" class="form-label">Name <span style="color:red">*</span></label>
            <input type="text" oninput="validateName()" id="nameId" class="form-control" name="name"
                   value="${dto.name}" required minlength="3" maxlength="50"/>
            <span id="nameError" class="text-danger"></span>
        </div>
        <div class="mb-3">
            <label for="phoneNumber" class="form-label">Phone Number <span style="color:red">*</span></label>
            <input type="number" oninput="validatePhoneNumber()" id="phoneNumber" class="form-control" name="phoneNumber" required/>
            <span id="phoneError" class="text-danger"></span>
        </div>
        <div class="mb-3">
            <label for="emailId" class="form-label">Email <span style="color:red">*</span></label>
            <input type="email" id="emailId" onchange="validateEmail()" class="form-control" name="email" required/>
            <span id="emailError" class="text-danger"></span>
        </div>
        <div class="mb-3">
            <label for="age" class="form-label">Age <span style="color:red">*</span></label>
            <input type="number" id="age" onchange="validateAge()" class="form-control" name="age" required/>
            <span id="ageError" class="text-danger"></span>
        </div>
        <div class="mb-3">
            <label for="genderId" class="form-label">Gender <span style="color:red">*</span></label>
            <select class="form-select" name="gender" id="genderId" onchange="validateGender()" required>
                <option value="" selected disabled>Select Gender</option>
                <option value="male">Male</option>
                <option value="female">Female</option>
                <option value="other">Other</option>
            </select>
            <span id="genderError" class="text-danger"></span>
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">Address <span style="color:red">*</span></label>
            <input type="text" id="address" class="form-control" name="address" required/>
            <span id="addressError" class="text-danger"></span>
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

        <div class="mb-3">
            <label for="confirmPassword" class="form-label">Confirm Password <span style="color:red">*</span></label>
            <div class="input-group">
                <input type="password" onchange="validateConfirmPassword()" id="confirmPassword" class="form-control" name="confirmPassword"
                       required minlength="8" maxlength="15" oninput="checkConfirmPassword()"/>
                <span class="input-group-text" onclick="togglePassword('confirmPassword', 'toggleIcon2')">
            <i class="bi bi-eye" id="toggleIcon2"></i>
        </span>
            </div>
            <span id="confirmError" class="text-danger"></span>
        </div>


        <button class="btn btn-success btn-signup mt-3" type="submit">Sign Up</button>
        <div class="text-success text-center">
            <c:if test="${not empty status}">
                <c:choose>
                    <c:when test="${status == true}">
                        <p>Successfully Registered</p>
                    </c:when>
                    <c:otherwise>
                        <p>Failed to Register</p>
                    </c:otherwise>
                </c:choose>
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

    function checkConfirmPassword() {
        const password = document.getElementById("password").value;
        const confirmPassword = document.getElementById("confirmPassword").value;
        const errorSpan = document.getElementById("confirmError");

        if (confirmPassword && password !== confirmPassword) {
            errorSpan.textContent = "Passwords do not match";
        } else {
            errorSpan.textContent = "";
        }
    }
</script>


</body>
</html>
