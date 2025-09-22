<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<style>
    .update-title {
            font-weight: 700;
            color: #198754;
            margin-bottom: 10px;
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
</style>
<body class="bg-light">

<!-- Navbar -->
<nav class="navbar top-navbar">
    <div class="container d-flex justify-content-between align-items-center">
        <!-- Logo -->
        <a class="navbar-brand" href="#">
            <img src="https://www.x-workz.in/Logo.png" alt="Logo" style="height: 50px;">
        </a>

        <!-- Menu -->
        <ul class="navbar-nav flex-row">
            <li class="nav-item">
                <a class="nav-link" href="Home.jsp">Home</a>
            </li>
            <!-- Add more menu items here -->
        </ul>
    </div>
</nav>


<!-- Update Profile Form -->
<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="bg-white shadow-lg rounded p-4 w-100" style="max-width: 600px;">
        <h3 class="update-title text-center mb-2">Update Profile</h3>

        <!-- Validation Errors -->
        <c:if test="${not empty errors}">
            <div class="alert alert-warning">
                <c:forEach var="error" items="${errors}">
                    <p class="mb-1">${error.defaultMessage}</p>
                </c:forEach>
            </div>
        </c:if>


        <!-- Profile Image -->
        <c:choose>
            <c:when test="${not empty dto.imagePath}">
                <img src="download?imagePath=${dto.imagePath}"
                     class="rounded-circle" style="width:120px; height:120px;" alt="Profile">
            </c:when>
            <c:otherwise>
                <img src="https://static.vecteezy.com/system/resources/previews/013/042/571/non_2x/default-avatar-profile-icon-social-media-user-photo-in-flat-style-vector.jpg"
                     class="rounded-circle" style="width:120px; height:120px;" alt="Default Profile">
            </c:otherwise>
        </c:choose>

        <!-- Update Form -->
        <form action="UpdateProfile" method="post" enctype="multipart/form-data">
            <div class="row mb-3">
                <div class="col-6">
                    <label for="nameId" class="form-label">Name</label>
                    <input type="text" oninput="validateName()" class="form-control"
                           id="nameId" name="name" value="${dto.name}" required minlength="3" maxlength="10">
                    <span id="nameErrorId" class="text-danger"></span>
                </div>

                <!-- Email (readonly + hidden for backend) -->
                <div class="col">
                    <label for="emailId" class="form-label">Email</label>
                    <input type="email" class="form-control" id="emailId" value="${dto.email}" readonly>
                    <!-- hidden ensures value is submitted -->
                    <input type="hidden" name="email" value="${dto.email}">
                </div>

                <!-- Phone (fix name to phoneNumber) -->
                <div class="col-6">
                    <label for="phoneNumber" class="form-label">Phone No</label>
                    <input type="text" class="form-control" oninput="validatePhone()"
                           id="phoneNumber" name="phoneNumber" value="${dto.phoneNumber}" maxlength="10">
                    <span class="text-danger" id="phoneError"></span>
                </div>

                <div class="col-3">
                    <label for="age" class="form-label">Age</label>
                    <input type="text" class="form-control" oninput="validateAge()"
                           id="age" name="age" value="${dto.age}" required maxlength="2">
                    <span class="text-danger" id="ageErrorId"></span>
                </div>

                <div class="col-3">
                    <label for="genderId" class="form-label">Gender</label>
                    <select id="genderId" class="form-select" disabled>
                        <option value="${dto.gender}">${dto.gender}</option>
                    </select>
                    <!-- hidden ensures value is submitted -->
                    <input type="hidden" name="gender" value="${dto.gender}">
                </div>
            </div>

            <div class="form-floating mb-3">
        <textarea class="form-control" name="address" id="addressId"
                  style="height: 100px" required>${dto.address}</textarea>
                <label for="addressId">Address</label>
            </div>

            <div class="input-group mb-3">
                <input type="file" class="form-control" id="inputGroupFile02" name="profileImage">
                <label class="input-group-text" for="inputGroupFile02">Upload</label>
            </div>

            <div class="text-center">
                <button type="submit" class="btn btn-success w-50">Update</button>
            </div>

            <div class="text-success text-center">
                <c:if test="${not empty status}">
                    <c:choose>
                        <c:when test="${status eq 'done'}">
                            <p>Successfully Updated</p>
                        </c:when>
                        <c:otherwise>
                            <p>Failed to Update</p>
                        </c:otherwise>
                    </c:choose>
                </c:if>
            </div>
        </form>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
