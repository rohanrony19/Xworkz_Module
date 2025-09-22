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
                    <a class="nav-link" href="SignIn.jsp">Sign In</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="SignUp.jsp">Sign Up</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<!-- Optional Main Content -->
<div class="main-content container">
    <h1>Welcome to X-Workz</h1>
    <!--<p>Explore our services and sign up to get started.</p>-->
    <div style="display: flex; align-items: flex-start; gap: 30px; flex-wrap: wrap; margin: 40px 0;">
        <img src="https://backiee.com/static/wallpapers/1000x563/386745.jpg" alt="" style="max-width: 700px; border-radius: 12px; box-shadow: 0 4px 16px rgba(0,0,0,.10);">
        <div style="flex: 1; min-width: 280px;margin-top:50px;">
            <p>Call <code>System.out.println("Coding")</code> to enter into the Tech World</p>
            <pre style="background: #f8f9fa; padding: 18px; border-radius: 8px; "><code>
public class Developer {
    public static void main(String[] args) {
        System.out.println("Every great developer
                you know got there by solving problems
                they were unqualified to solve until they actually did it.");
        System.out.println("Believe in yourself, keep coding, and never stop learning!");
    }
}
</code></pre>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
