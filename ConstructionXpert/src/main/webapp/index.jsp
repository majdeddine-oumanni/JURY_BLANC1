<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ConstructionXpert</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .hero {
            position: relative;
            height: 100vh;
            background: url('./photos/construction-silhouette.jpg') no-repeat center center/cover;
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 20px;
        }
        .navbar {
            position: absolute;
            top: 0;
            width: 100%;
            padding: 15px 0;
            background: rgba(0, 0, 0, 0.5);
        }
        .navbar-brand .logo {
            height: 40px;
        }
        .nav-link {
            color: white !important;
            margin: 0 10px;
        }
        .btn-dark {
            background-color: black;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .btn-outline-light {
            border: 2px solid white;
            padding: 10px 20px;
            border-radius: 5px;
            color: white;
        }
        .hero h1 {
            font-size: 3rem;
            font-weight: bold;
        }
        .hero p {
            font-size: 1.2rem;
            max-width: 600px;
            margin: 20px auto;
        }
        .hero-buttons .btn {
            margin: 10px;
        }
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 2rem;
            }
            .hero p {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
<header class="hero">
    <nav class="navbar navbar-expand-lg">
        <div class="container">
            <a class="navbar-brand" href="#"> <img src="./photos/main_icon.png" alt="Logo" class="logo"> </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="#">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Who We Are</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Portfolio</a></li>
                    <li class="nav-item"><a class="nav-link btn btn-dark" href="#">Get In Touch</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="hero-content text-center">
        <h1>Lorem ipsum dolor sit amet</h1>
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>
        <div class="hero-buttons">
            <button class="btn btn-dark">Learn More</button>
            <button class="btn btn-outline-light">Get In Touch</button>
        </div>
    </div>
</header>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>