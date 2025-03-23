<%--
  Created by IntelliJ IDEA.
  User: MAJD
  Date: 3/20/2025
  Time: 3:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="models.Projet" %>
<%@ page import="models.Tache" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Task</title>

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

        .project-info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            border-left: 4px solid #3498db;
        }

        .project-info h5 {
            color: #2c3e50;
            margin-bottom: 10px;
        }

        .project-info p {
            margin-bottom: 5px;
            color: #7f8c8d;
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
                <li class="nav-item"><a class="nav-link" href="projet?action=list">Afficher Les projet</a></li>
                <li class="nav-item"><a class="nav-link" href="projet?action=add">Ajouter un projet</a></li>
                <li class="nav-item"><a class="nav-link btn btn-dark" href="#">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<%
    Tache tache = (Tache) request.getAttribute("tache");
    Projet projet = (Projet) request.getAttribute("projet");

    // If tache is null, redirect to project list or show error
    if (tache == null) {
        response.sendRedirect("projet?action=list");
        return;
    }
%>

<div class="page-header">
    <div class="container">
        <h2 class="text-center">Update Task</h2>
    </div>
</div>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <% if (projet != null) { %>
            <div class="project-info">
                <h5>Updating task in project: <%= projet.getNom() %></h5>
                <p><strong>Project ID:</strong> <%= projet.getId() %></p>
                <p><strong>Project Duration:</strong> <%= projet.getDateDebut() %> to <%= projet.getDateFin() %></p>
            </div>

            <div class="form-container">
                <form action="tache?action=update" method="post">
                    <input type="hidden" name="id" value="<%= tache.getId() %>">
                    <input type="hidden" name="projetId" value="<%= projet.getId() %>">

                    <div class="mb-3">
                        <label for="description" class="form-label required-field">Description</label>
                        <textarea class="form-control" id="description" name="description" rows="3" required><%= tache.getDescription() %></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="dateDebut" class="form-label required-field">Start Date</label>
                        <input type="date" class="form-control" id="dateDebut" name="dateDebut"
                               value="<%= tache.getDateDebut() %>" required
                               min="<%= projet.getDateDebut() %>" max="<%= projet.getDateFin() %>">
                    </div>

                    <div class="mb-3">
                        <label for="dateFin" class="form-label required-field">End Date</label>
                        <input type="date" class="form-control" id="dateFin" name="dateFin"
                               value="<%= tache.getDateFin() %>" required
                               min="<%= projet.getDateDebut() %>" max="<%= projet.getDateFin() %>">
                    </div>

                    <div class="d-flex justify-content-end">
                        <a href="tache?action=list&projetId=<%= projet.getId() %>" class="btn btn-cancel">
                            <i class="fas fa-times me-1"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-submit">
                            <i class="fas fa-save me-1"></i> Update Task
                        </button>
                    </div>
                </form>
            </div>
            <% } else { %>
            <div class="alert alert-danger">
                <p>Project not found. Please select a valid project.</p>
                <a href="projet?action=list" class="btn btn-primary mt-3">Go to Project List</a>
            </div>
            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Validate that end date is after start date
    document.addEventListener('DOMContentLoaded', function() {
        const startDateInput = document.getElementById('dateDebut');
        const endDateInput = document.getElementById('dateFin');

        startDateInput.addEventListener('change', function() {
            endDateInput.min = startDateInput.value;
            if (endDateInput.value && new Date(endDateInput.value) < new Date(startDateInput.value)) {
                endDateInput.value = startDateInput.value;
            }
        });

        const form = document.querySelector('form');
        form.addEventListener('submit', function(event) {
            const startDate = new Date(startDateInput.value);
            const endDate = new Date(endDateInput.value);

            if (endDate < startDate) {
                event.preventDefault();
                alert('End date must be after or equal to start date');
            }
        });
    });
</script>
</body>
</html>