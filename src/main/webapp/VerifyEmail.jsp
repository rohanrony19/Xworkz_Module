<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Verify Email - Module Project</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #e9ecef 70%, #eaf0fb 100%);
        }
        .navbar {
            background-color: #28a745 !important; /* green top navbar */
        }
        .navbar .nav-link {
            font-weight: 500;
            color: #fff !important; /* make links visible on green background */
            margin-left: 15px;
        }
        .signup-container {
            max-width: 420px;
            margin: 80px auto;
            padding: 32px 28px;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 12px 32px rgba(0,0,0,.12);
        }
        .signup-title {
            font-weight: 700;
            color: #198754;
            text-align: center;
            margin-bottom: 20px;
        }
        .btn-signup {
            width: 100%;
            font-weight: 600;
        }
        .form-control {
            border-radius: 7px;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand text-white fw-bold" href="Home.jsp">
            <img src="https://www.x-workz.in/Logo.png" alt="Logo" width="100">
        </a>
        <button class="navbar-toggler text-white border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="Home.jsp">Home</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="signup-container">
    <h3 class="signup-title">Verify Email</h3>

    <form action="verifyUserEmail" method="post">
        <div class="mb-3">
            <label for="emailId" class="form-label">Email <span class="text-danger">*</span></label>
            <input type="email" id="emailId" onchange="validateEmail()" class="form-control" name="email" value="${email}" required/>
            <span id="emailError" class="text-danger"></span>
        </div>

        <div class="mb-3">
            <button class="btn btn-success btn-signup mt-2" type="submit">Verify</button>
        </div>
    </form>

    <c:if test="${not empty status}">
        <c:if test="${status eq 'fail'}">
            <p class="text-center text-warning mt-2">Email Not Found</p>
        </c:if>
    </c:if>
</div>

<script src="index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
