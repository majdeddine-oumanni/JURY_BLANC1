<%--
  Created by IntelliJ IDEA.
  User: MAJD
  Date: 3/18/2025
  Time: 1:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="models.Projet" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Project List</title>
  <link rel="stylesheet" href="styles.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
    }
    .container {
      margin-top: 80px;
    }
    .project-card {
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
      background: #fff;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
<header class="hero">
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container">
      <a class="navbar-brand" href="#"> <img src="logo-placeholder.png" alt="Logo" class="logo"> </a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link" href="index.html">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Who We Are</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Services</a></li>
          <li class="nav-item"><a class="nav-link" href="#">Portfolio</a></li>
          <li class="nav-item"><a class="nav-link btn btn-dark" href="#">Get In Touch</a></li>
        </ul>
      </div>
    </div>
  </nav>
</header>

<div class="container">
  <h2 class="text-center">Project List</h2>
  <div class="row">
    <!-- Dynamically generated project list -->
    <%
      List<Projet> projets = (List<Projet>) request.getAttribute("projetList");
      for (Projet projet : projets) {
    %>
    <div class="col-md-4">
      <div class="project-card">
        <h4><%= projet.getNom() %></h4>
        <p><strong>Description:</strong> <%= projet.getDescription() %></p>
        <p><strong>Start Date:</strong> <%= projet.getDateDebut() %></p>
        <p><strong>End Date:</strong> <%= projet.getDateFin() %></p>
        <p><strong>Budget:</strong> $<%= projet.getBudget() %></p>
      </div>
    </div>
    <% } %>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

