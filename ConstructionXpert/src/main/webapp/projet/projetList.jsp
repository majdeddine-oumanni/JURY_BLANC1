<%@ page import="models.Projet" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Project List</title>

  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f5f5f5;
      margin: 0;
      padding: 0;
    }

    .navbar {
      background-color: #2c3e50;
      padding: 15px 0;
    }

    .navbar-brand .logo {
      height: 40px;
    }

    .nav-link {
      color: white !important;
      margin: 0 10px;
    }

    .nav-link:hover {
      color: #3498db !important;
    }

    .btn-dark {
      background-color: #3498db;
      border: none;
      padding: 8px 16px;
      border-radius: 4px;
    }

    .page-header {
      background-color: #3498db;
      color: white;
      padding: 60px 0 30px;
      margin-bottom: 30px;
    }

    .project-card {
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
      margin-bottom: 25px;
      transition: transform 0.2s;
      position: relative;
    }

    .project-card:hover {
      transform: translateY(-5px);
    }

    .project-card h4 {
      color: #2c3e50;
      margin-bottom: 15px;
      border-bottom: 2px solid #3498db;
      padding-bottom: 10px;
    }

    .project-card p {
      margin-bottom: 10px;
    }

    .project-id {
      background-color: #3498db;
      color: white;
      display: inline-block;
      padding: 2px 8px;
      border-radius: 4px;
      font-size: 14px;
      margin-left: 10px;
    }

    .empty-message {
      text-align: center;
      padding: 40px;
      background-color: white;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .project-actions {
      display: flex;
      justify-content: space-between;
      margin-top: 15px;
      padding-top: 15px;
      border-top: 1px solid #eee;
    }

    .btn-ajouter-tache {
      background-color: #27ae60;
      color: white;
      border: none;
      padding: 6px 12px;
      border-radius: 4px;
      transition: background-color 0.2s;
      width: 100%;
      text-align: center;
      margin-bottom: 15px;
    }

    .btn-ajouter-tache:hover {
      background-color: #219653;
      color: white;
    }

    .btn-voir-taches {
      background-color: #f39c12;
      color: white;
      border: none;
      padding: 6px 12px;
      border-radius: 4px;
      transition: background-color 0.2s;
      width: 100%;
      text-align: center;
      margin-bottom: 15px;
    }

    .btn-voir-taches:hover {
      background-color: #d35400;
      color: white;
    }

    .btn-modifier {
      background-color: #3498db;
      color: white;
      border: none;
      padding: 6px 12px;
      border-radius: 4px;
      transition: background-color 0.2s;
    }

    .btn-modifier:hover {
      background-color: #2980b9;
      color: white;
    }

    .btn-supprimer {
      background-color: #e74c3c;
      color: white;
      border: none;
      padding: 6px 12px;
      border-radius: 4px;
      transition: background-color 0.2s;
    }

    .btn-supprimer:hover {
      background-color: #c0392b;
      color: white;
    }
  </style>
</head>
<body>

<nav class="navbar navbar-expand-lg">
  <div class="container">
    <a class="navbar-brand" href="#">
      <img src="./photos/main_icon.png" alt="Logo" class="logo">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="projet?action=list">Afficher Les projet</a></li>
        <li class="nav-item"><a class="nav-link" href="projet?action=add">Ajouter un projet</a></li>
        <li class="nav-item"><a class="nav-link" href="ressource?action=list">Afficher Les projet</a></li>
        <!--<li class="nav-item"><a class="nav-link" href="#">Portfolio</a></li>-->
        <li class="nav-item"><a class="nav-link btn btn-dark" href="index.jsp">Logout</a></li>
      </ul>
    </div>
  </div>
</nav>
<div class="page-header">
  <div class="container">
    <h2 class="text-center">List des Projets</h2>
  </div>
</div>


<div class="container">
  <div class="row">
    <%
      List<Projet> projets = (List<Projet>) request.getAttribute("projetList");
      if (projets != null && !projets.isEmpty()) {
        for (Projet projet : projets) {
    %>
    <div class="col-md-4">
      <div class="project-card">
        <h4><%= projet.getNom() %><span class="project-id"><%=projet.getId()%></span></h4>
        <p><strong>Description:</strong> <%=projet.getDescription()%></p>
        <p><strong>Start Date:</strong> <%=projet.getDateDebut()%></p>
        <p><strong>End Date:</strong> <%=projet.getDateFin()%></p>
        <p><strong>Budget:</strong> <%=projet.getBudget()%> DH</p>

        <a href="tache?action=list&&projetId=<%=projet.getId()%>" class="btn btn-voir-taches">
          <i class="fas fa-list me-1"></i> Voir les taches
        </a>

        <a href="tache?action=add&&projetId=<%=projet.getId()%>" class="btn btn-ajouter-tache">
          <i class="fas fa-tasks me-1"></i> Ajouter tache
        </a>

        <div class="project-actions">
          <a href="projet?action=update&&id=<%= projet.getId() %>" class="btn btn-modifier">
            <i class="fas fa-edit me-1"></i> Modifier
          </a>
          <a href="projet?action=delete&&id=<%= projet.getId() %>" class="btn btn-supprimer"
             onclick="return confirm('Etes-vous sur de vouloir supprimer ce projet?')">
            <i class="fas fa-trash me-1"></i> Supprimer
          </a>
        </div>
      </div>
    </div>
    <%
      }
    } else {
    %>
    <div class="col-12">
      <div class="empty-message">
        <p class="text-muted">Aucun projet disponible.</p>
      </div>
    </div>
    <% } %>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>