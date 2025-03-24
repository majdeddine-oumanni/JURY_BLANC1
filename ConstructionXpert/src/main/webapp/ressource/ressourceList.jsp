<%@ page import="java.util.List" %>
<%@ page import="models.Ressource" %><%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 3/23/2025
  Time: 6:12 PM
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Ressources</title>

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

        .table-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 30px;
        }

        .table {
            margin-bottom: 0;
        }

        .table th {
            background-color: #f8f9fa;
            color: #2c3e50;
            font-weight: 600;
            border-bottom: 2px solid #3498db;
        }

        .table tr:hover {
            background-color: #f8f9fa;
        }

        .action-buttons .btn {
            margin-right: 5px;
            padding: 5px 10px;
            font-size: 0.85rem;
        }

        .btn-edit {
            background-color: #f39c12;
            border: none;
            color: white;
        }

        .btn-edit:hover {
            background-color: #e67e22;
            color: white;
        }

        .btn-delete {
            background-color: #e74c3c;
            border: none;
            color: white;
        }

        .btn-delete:hover {
            background-color: #c0392b;
            color: white;
        }

        .badge-type {
            font-size: 0.85rem;
            padding: 5px 10px;
            border-radius: 12px;
        }

        .type-Matériel {
            background-color: #3498db;
            color: white;
        }

        .type-Logiciel {
            background-color: #9b59b6;
            color: white;
        }

        .type-Humain {
            background-color: #2ecc71;
            color: white;
        }

        .type-Financier {
            background-color: #f1c40f;
            color: black;
        }

        .empty-table {
            text-align: center;
            padding: 30px;
            color: #7f8c8d;
        }

        .add-button {
            margin-bottom: 20px;
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
                <li class="nav-item"><a class="nav-link" href="ressource?action=list">Liste des Ressources</a></li>
                <li class="nav-item"><a class="nav-link" href="ressource?action=add">Ajouter une Ressource</a></li>
                <li class="nav-item"><a class="nav-link" href="projet?action=list">Liste des Projets</a></li>
                <li class="nav-item"><a class="nav-link btn btn-dark" href="index.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2 class="text-center">Liste des Ressources</h2>
    </div>
</div>

<div class="container">
    <div class="add-button text-end">
        <a href="ressource?action=add" class="btn btn-primary">
            <i class="fas fa-plus me-1"></i> Ajouter une Ressource
        </a>
    </div>

    <div class="table-container">
        <%
            List<Ressource> ressourceList = (List<Ressource>) request.getAttribute("ressourceList");
            if (ressourceList != null && !ressourceList.isEmpty()) {
        %>
        <table class="table table-hover">
            <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Type</th>
                <th>Quantité</th>
                <th>Fournisseur</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (Ressource ressource : ressourceList) { %>
            <tr>
                <td><%= ressource.getId() %></td>
                <td><%= ressource.getNom() %></td>
                <td>
                        <span class="badge badge-type type-<%= ressource.getType() %>">
                            <%= ressource.getType() %>
                        </span>
                </td>
                <td><%= ressource.getQuantite() %></td>
                <td><%= ressource.getFournisseur() %></td>
                <td class="action-buttons">
                    <a href="ressource?action=update&id=<%= ressource.getId() %>" class="btn btn-edit">
                        <i class="fas fa-edit"></i> Modifier
                    </a>
                    <button class="btn btn-delete" onclick="confirmDelete(<%= ressource.getId() %>)">
                        <i class="fas fa-trash"></i> Supprimer
                    </button>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <div class="empty-table">
            <i class="fas fa-box-open fa-3x mb-3"></i>
            <h4>Aucune ressource trouvée</h4>
            <p>Commencez par ajouter une nouvelle ressource.</p>
            <a href="ressource?action=add" class="btn btn-primary mt-2">
                <i class="fas fa-plus me-1"></i> Ajouter une Ressource
            </a>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function confirmDelete(id) {
        if (confirm("Êtes-vous sûr de vouloir supprimer cette ressource ?")) {
            window.location.href = "ressource?action=delete&id=" + id;
        }
    }
</script>
</body>
</html>