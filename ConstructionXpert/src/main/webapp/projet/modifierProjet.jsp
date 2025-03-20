<%--
  Created by IntelliJ IDEA.
  User: MAJD
  Date: 3/18/2025
  Time: 1:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="models.Projet" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter Projet</title>
    <link rel="stylesheet" href="styles.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .container-form {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #f8f9fa;
            border-radius: 8px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
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
                    <li class="nav-item"><a class="nav-link" href="projet?action=list">List de Projet</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Who We Are</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="#">Portfolio</a></li>
                    <li class="nav-item"><a class="nav-link btn btn-dark" href="#">Get In Touch</a></li>
                </ul>
            </div>
        </div>
    </nav>
</header>

<div class="container-form">
    <h2 class="text-center">Modifier un Projet</h2>
    <%
        Projet projet = (Projet) request.getAttribute("projet");
    %>
    <form action="projet?action=update" method="post">
        <input name="id" value="<%=projet.getId()%>" type="hidden">
        <div class="mb-3">
            <label for="nom" class="form-label">Nom du projet</label>
            <input type="text" class="form-control" id="nom" name="nom" required value="<%=projet.getNom()%>">
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Description</label>
            <textarea class="form-control" id="description" name="description" rows="3" required><%=projet.getDescription()%></textarea>
        </div>
        <div class="mb-3">
            <label for="dateDebut" class="form-label">Date de debut</label>
            <input type="date" class="form-control" id="dateDebut" name="dateDebut" required value="<%=projet.getDateDebut()%>">
        </div>
        <div class="mb-3">
            <label for="dateFin" class="form-label">Date de fin</label>
            <input type="date" class="form-control" id="dateFin" name="dateFin" required value="<%=projet.getDateFin()%>">
        </div>
        <div class="mb-3">
            <label for="budget" class="form-label">Budget</label>
            <input type="number" step="0.01" class="form-control" id="budget" name="budget" required value="<%=projet.getBudget()%>">
        </div>
        <button type="submit" class="btn btn-dark w-100">Modifier</button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
