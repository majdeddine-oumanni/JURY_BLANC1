<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 3/23/2025
  Time: 6:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="models.Ressource" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifier une Ressource</title>

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

        .form-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
        }

        .form-label {
            color: #2c3e50;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .form-control {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 10px;
            margin-bottom: 20px;
        }

        .form-control:focus {
            border-color: #3498db;
            box-shadow: 0 0 0 0.2rem rgba(52, 152, 219, 0.25);
        }

        .resource-info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #3498db;
        }

        .resource-info h5 {
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .btn-submit {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: 600;
            transition: background-color 0.2s;
        }

        .btn-submit:hover {
            background-color: #219653;
        }

        .btn-cancel {
            background-color: #7f8c8d;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            font-weight: 600;
            transition: background-color 0.2s;
            margin-right: 10px;
        }

        .btn-cancel:hover {
            background-color: #95a5a6;
        }

        .required-field::after {
            content: "*";
            color: red;
            margin-left: 4px;
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
                <li class="nav-item"><a class="nav-link btn btn-dark" href="#">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<%
    Ressource ressource = (Ressource) request.getAttribute("ressource");

    // If ressource is null, redirect to resource list
    if (ressource == null) {
        response.sendRedirect("ressource?action=list");
        return;
    }
%>

<div class="page-header">
    <div class="container">
        <h2 class="text-center">Modifier une Ressource</h2>
    </div>
</div>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="resource-info">
                <h5>Modification de la ressource: <%= ressource.getNom() %></h5>
                <p><strong>ID:</strong> <%= ressource.getId() %></p>
            </div>

            <div class="form-container">
                <form action="ressource?action=update" method="post">
                    <input type="hidden" name="id" value="<%= ressource.getId() %>">

                    <div class="mb-3">
                        <label for="nom" class="form-label required-field">Nom</label>
                        <input type="text" class="form-control" id="nom" name="nom" value="<%= ressource.getNom() %>" required>
                    </div>

                    <div class="mb-3">
                        <label for="type" class="form-label required-field">Type</label>
                        <select class="form-control" id="type" name="type" required>
                            <option value="">Selectionner un type</option>
                            <option value="Les-Machine" <%= ressource.getType().equals("Les Machine") ? "selected" : "" %>>Les Machine</option>
                            <option value="Les-vehicules" <%= ressource.getType().equals("Les vehicules") ? "selected" : "" %>>Les vehicules</option>
                            <option value="Les-composants" <%= ressource.getType().equals("Les composants") ? "selected" : "" %>>Les composants</option>
                            <option value="Les-outils" <%= ressource.getType().equals("Les outils") ? "selected" : "" %>>Les outils</option>
                            <option value="Les-materiaux" <%= ressource.getType().equals("Les materiaux") ? "selected" : "" %>>Les materiaux</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="quantite" class="form-label required-field">Quantite</label>
                        <input type="number" class="form-control" id="quantite" name="quantite" value="<%= ressource.getQuantite() %>" min="0" required>
                    </div>

                    <div class="mb-3">
                        <label for="fournisseur" class="form-label required-field">Fournisseur</label>
                        <input type="text" class="form-control" id="fournisseur" name="fournisseur" value="<%= ressource.getFournisseur() %>" required>
                    </div>

                    <div class="d-flex justify-content-end">
                        <a href="ressource?action=list" class="btn btn-cancel">
                            <i class="fas fa-times me-1"></i> Annuler
                        </a>
                        <button type="submit" class="btn btn-submit">
                            <i class="fas fa-save me-1"></i> Mettre a jour
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
