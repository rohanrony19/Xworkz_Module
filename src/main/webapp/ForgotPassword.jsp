<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html lang="en" xmlns:c="http://www.w3.org/1999/XSL/Transform">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Update Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.13.1/font/bootstrap-icons.min.css">
</head>
<body class="bg-light text-dark">

<!-- Navbar -->
<nav class="navbar navbar-light bg-white border-bottom shadow-sm">
    <div class="container">
        <a class="navbar-brand fw-bold text-success" href="#">
            <img src="https://www.x-workz.in/Logo.png" alt="xworkz" width="100" height="50">
        </a>
        <div class="d-grid gap-2 d-md-block">
            <a class="btn btn-success rounded-pill m-2" href="index.jsp" role="button">Home</a>
        </div>
    </div>
</nav>


<!-- Update Password Form -->
<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="p-5 shadow-lg rounded bg-white border border-success w-75">
        <h3 class="fw-bold display-6 text-center text-success mb-4">Update Password</h3>

        <!-- Message from Controller -->
        <c:if test="${not empty message}">
            <div class="alert ${status == true ? 'alert-success' : 'alert-danger'} text-center">
                ${message}
            </div>
        </c:if>

        <form action="updatePassword" method="post" class="px-4">
            <!-- New Password -->
            <!-- New Password -->
            <!-- New Password -->
            <div class="row mb-3">
                <div class="col-6 mx-auto">
                    <label for="password" class="form-label fw-semibold">New Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control border-success"
                               oninput="validatePassword()" name="password" id="password" required>
                        <button type="button" class="btn btn-outline-success" onclick="togglePassword('password','toggleIcon1')">
                            <i class="bi bi-eye-slash" id="toggleIcon1"></i>
                        </button>
                    </div>
                    <span id="passwordError" class="text-danger small"></span>
                </div>
            </div>

            <!-- Confirm Password -->
            <div class="row mb-3">
                <div class="col-6 mx-auto">
                    <label for="confirmPassword" class="form-label fw-semibold">Confirm Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control border-success"
                               oninput="validateConfirmPassword()" id="confirmPassword" name="cpassword" required>
                        <button type="button" class="btn btn-outline-success" onclick="togglePassword('confirmPassword','toggleIcon2')">
                            <i class="bi bi-eye-slash" id="toggleIcon2"></i>
                        </button>
                    </div>
                    <span id="confirmError" class="text-danger small"></span>
                </div>
            </div>



            <!-- Submit -->
            <div class="mb-3 text-center">
                <button class="btn btn-success w-50 fw-semibold shadow">Submit</button>
            </div>
        </form>



    </div>
    </div>


<script src="index.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q"
        crossorigin="anonymous"></script>
<script>

    function togglePassword(inputId, iconId) {
       const input = document.getElementById(inputId);
       const icon = document.getElementById(iconId);
       if (input.type === "password") {
           input.type = "text";
           icon.classList.remove("bi-eye-slash");
           icon.classList.add("bi-eye");
       } else {
           input.type = "password";
           icon.classList.remove("bi-eye");
           icon.classList.add("bi-eye-slash");
       }
   }


</script>
</body>
</html>
