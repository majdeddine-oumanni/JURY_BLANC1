<%--
  Created by IntelliJ IDEA.
  User: MAJD
  Date: 3/20/2025
  Time: 3:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="models.Tache" %>
<%@ page import="models.Projet" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>list de Les taches</title>

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

        .project-info {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 25px;
        }

        .project-info h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }

        .task-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 25px;
            transition: transform 0.2s;
        }

        .task-card:hover {
            transform: translateY(-5px);
        }

        .task-card h4 {
            color: #2c3e50;
            margin-bottom: 15px;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }

        .task-card p {
            margin-bottom: 10px;
        }

        .task-id {
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

        .task-actions {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #eee;
        }

        .btn-ajouter {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background-color 0.2s;
            margin-bottom: 20px;
        }

        .btn-ajouter:hover {
            background-color: #219653;
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

        .btn-back {
            background-color: #7f8c8d;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background-color 0.2s;
            margin-right: 10px;
        }

        .btn-back:hover {
            background-color: #95a5a6;
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
                <li class="nav-item"><a class="nav-link" href="projet?action=list">Afficher Les projet</a></li
                <li class="nav-item"><a class="nav-link" href="ressource?action=list">Liste de Ressource</a></li>
                <li class="nav-item"><a class="nav-link btn btn-dark" href="index.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2 class="text-center">List des tache</h2>
    </div>
</div>

<div class="container">
    <%
        Projet projet = (Projet) request.getAttribute("projet");
        if (projet != null) {
    %>
    <div class="project-info">
        <h3><%= projet.getNom() %><span class="task-id">Project ID: <%= projet.getId() %></span></h3>
        <p><strong>Description:</strong> <%= projet.getDescription() %></p>
        <p><strong>Start Date:</strong> <%= projet.getDateDebut() %></p>
        <p><strong>End Date:</strong> <%= projet.getDateFin() %></p>
        <p><strong>Budget:</strong> <%= projet.getBudget() %> DH</p>
    </div>

    <div class="d-flex mb-4">
        <a href="projet?action=list" class="btn btn-back">
            <i class="fas fa-arrow-left me-1"></i> Retour aux projets
        </a>
        <a href="tache?action=add&projetId=<%= projet.getId() %>" class="btn btn-ajouter">
            <i class="fas fa-plus me-1"></i> Ajouter une nouvelle tache
        </a>
    </div>

    <div class="row">
        <%
            List<Tache> taches = (List<Tache>) request.getAttribute("tacheList");
            if (taches != null && !taches.isEmpty()) {
                for (Tache tache : taches) {
        %>
        <div class="col-md-4">
            <div class="task-card">
                <h4><%= tache.getDescription() %><span class="task-id"><%= tache.getId() %></span></h4>
                <p><strong>Date debut:</strong> <%= tache.getDateDebut() %></p>
                <p><strong>Date de Fin:</strong> <%= tache.getDateFin() %></p>

                <div class="task-actions">
                    <a href="tache?action=update&id=<%= tache.getId() %>&&projetId=<%= projet.getId() %>" class="btn btn-modifier">
                        <i class="fas fa-edit me-1"></i> Modifier
                    </a>
                    <a href="tache?action=delete&id=<%= tache.getId() %>&&projetId=<%= projet.getId() %>" class="btn btn-supprimer"
                       onclick="return confirm('Etes-vous sur de vouloir supprimer cette tache?')">
                        <i class="fas fa-trash me-1"></i> Supprimer
                    </a>
                </div>
            </div>
        </div>
        <a href="assign?action=add&tacheId=<%=tache.getId()%>">affectation d'un ressource</a>
        <%
            }
        } else {
        %>
        <div class="col-12">
            <div class="empty-message">
                <p class="text-muted">Aucune tâche disponible pour ce projet.</p>
            </div>
        </div>
        <% } %>
    </div>
    <% } else { %>
    <div class="col-12">
        <div class="empty-message">
            <p class="text-muted">Projet non trouvé.</p>
        </div>
    </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
