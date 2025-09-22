<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" isELIgnored="false"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.0/css/all.min.css"
          integrity="sha512-DxV+EoADOkOygM4IR9yXP8Sb2qwgidEmeqAEmDKIOfPRQZOWbXCzLC6vjbZyy0vPisbH2SyW27+ddLVCN+OMzQ=="
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>Home</title>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .top-navbar {
            background-color: #28a745; /* green top navbar */
        }
        .top-navbar .navbar-brand img {
            height: 40px;
        }
        .navbar-nav .nav-link {
            margin-right: 15px;
            font-weight: 500;
            color: #333;
        }
        .navbar-nav .nav-link:hover {
            color: #19692c;
        }
        .main-content {
            padding: 50px 15px;
            text-align: center;
        }
        .main-content h1 {
            color: #28a745;
            margin-bottom: 30px;
        }
        .main-content a.btn {
            margin: 10px;
        }
    </style>
</head>
<body>

<!-- Top Navbar with Logo -->
<nav class="navbar top-navbar">
    <div class="container">
        <a class="navbar-brand" href="#">
            <img src="https://www.x-workz.in/Logo.png" alt="Logo">
        </a>
        <div>
            <ul class="navbar-nav flex-row">
                <li class="nav-item">
                    <a class="nav-link" href="update" role="button">Update</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Optional Main Content -->
<div class="main-content container">
    <h1>Welcome to X-Workz </h1>
    <h3>${sessionScope.loginName}</h3>
    <img src="https://backiee.com/static/wallpapers/1000x563/386745.jpg">
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
