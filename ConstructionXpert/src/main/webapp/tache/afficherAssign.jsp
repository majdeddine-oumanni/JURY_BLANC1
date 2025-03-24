<%@ page import="models.Assignment" %>
<%@ page import="models.Ressource" %>
<%@ page import="models.Tache" %>
<%@ page import="java.util.List" %>
<%@ page import="DAO.RessourceDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Ressources Affectées</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
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
            padding: 40px 0 20px;
            margin-bottom: 30px;
        }

        .table-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 30px;
        }

        .task-details {
            background-color: #f8f9fa;
            border-left: 4px solid #3498db;
            padding: 15px;
            margin-bottom: 20px;
        }

        .btn-add {
            background-color: #27ae60;
            color: white;
            border: none;
        }

        .btn-add:hover {
            background-color: #219653;
            color: white;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
            border: none;
        }

        .btn-delete:hover {
            background-color: #c0392b;
            color: white;
        }

        .empty-message {
            text-align: center;
            padding: 40px;
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
                <li class="nav-item"><a class="nav-link" href="projet?action=list">Afficher Les projets</a></li>
                <li class="nav-item"><a class="nav-link" href="projet?action=add">Ajouter un projet</a></li>
                <li class="nav-item"><a class="nav-link btn btn-dark" href="#">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2 class="text-center">Ressources Affectées à la Tâche</h2>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <%
                List<Assignment> assignmentList = (List<Assignment>) request.getAttribute("assignmentList");
                Tache tache = (Tache) request.getAttribute("tache");
            %>

            <div class="task-details">
                <h4>Détails de la Tâche</h4>
                <p><strong>ID:</strong> <%= tache.getId() %></p>
                <p><strong>Description:</strong> <%= tache.getDescription() %></p>
                <p><strong>Date Début:</strong> <%= tache.getDateDebut() %></p>
                <p><strong>Date Fin:</strong> <%= tache.getDateFin() %></p>
            </div>

            <div class="d-flex justify-content-between mb-3">
                <a href="assign?action=add&tacheId=<%= tache.getId() %>" class="btn btn-add">
                    <i class="fas fa-plus-circle me-2"></i>Ajouter une Ressource
                </a>
                <a href="tache?action=list&projetId=<%= tache.getprojetId() %>" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Retour aux Taches
                </a>
            </div>

            <div class="table-container">
                <% if(assignmentList != null && !assignmentList.isEmpty()) { %>
                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th scope="col">Ressource</th>
                        <th scope="col">Description</th>
                        <th scope="col">Quantité Utilisée</th>
                        <th scope="col">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for(Assignment assignment : assignmentList) {
                            Ressource ressource = RessourceDAO.getRessourceById(assignment.getRessourceId());
                    %>
                    <tr>
                        <td><%= ressource.getNom() %></td>
                        <td><%= assignment.getQuantiteUtilise() %></td>
                        <td>
                            <a href="assign?action=delete&id=<%= assignment.getId() %>" class="btn btn-delete btn-sm"
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette affectation?')">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="empty-message">
                    <p class="text-muted">Aucune ressource n'est affectée à cette tâche.</p>
                    <p>Cliquez sur "Ajouter une Ressource" pour commencer.</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>