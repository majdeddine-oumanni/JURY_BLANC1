<%@ page import="models.Tache" %>
<%@ page import="models.Ressource" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Affecter des Ressources</title>
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

        .form-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-bottom: 30px;
        }

        .task-details {
            background-color: #f8f9fa;
            border-left: 4px solid #3498db;
            padding: 15px;
            margin-bottom: 20px;
        }

        .btn-primary {
            background-color: #3498db;
            border: none;
        }

        .btn-primary:hover {
            background-color: #2980b9;
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
                <li class="nav-item"><a class="nav-link btn btn-dark" href="index.jsp">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="page-header">
    <div class="container">
        <h2 class="text-center">Affecter des Ressources à la Tache</h2>
    </div>
</div>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="form-container">
                <%
                    Tache tache = (Tache) request.getAttribute("tache");
                    List<Ressource> ressourceList = (List<Ressource>) request.getAttribute("ressourceList");
                %>

                <div class="task-details">
                    <h4>Details de la Tache</h4>
                    <p><strong>ID:</strong> <%= tache.getId() %></p>
                    <p><strong>Description:</strong> <%= tache.getDescription() %></p>
                    <p><strong>Date Debut:</strong> <%= tache.getDateDebut() %></p>
                    <p><strong>Date Fin:</strong> <%= tache.getDateFin() %></p>
                </div>

                <form action="assign?action=add&tacheId=<%=tache.getId()%>" method="post">
                    <div class="mb-3">
                        <label for="ressource" class="form-label">Selectionner une Ressource</label>
                        <select class="form-select" id="ressource" name="ressource" required>
                            <option value="" selected disabled>Choisir une ressource</option>
                            <%
                                if(ressourceList != null && !ressourceList.isEmpty()) {
                                    for(Ressource ressource : ressourceList) {
                            %>
                            <option value="<%= ressource.getId() %>" data-disponible="<%= ressource.getQuantite() %>">
                                <%= ressource.getNom() %> - Disponible: <%= ressource.getQuantite() %>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="quantiteSelected" class="form-label">Quantite à Utiliser</label>
                        <input type="number" class="form-control" id="quantiteSelected" name="quantiteSelected" min="1" required>
                        <div id="quantiteHelp" class="form-text">La quantite ne peut pas dépasser la quantité disponible.</div>
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary">Affecter Ressource</button>
                        <a href="tache?action=list&projetId=<%= tache.getprojetId() %>" class="btn btn-secondary">Annuler</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Script to validate quantity doesn't exceed available
    document.getElementById('ressource').addEventListener('change', function() {
        const selectedOption = this.options[this.selectedIndex];
        const disponible = selectedOption.getAttribute('data-disponible');
        const quantiteInput = document.getElementById('quantiteSelected');

        quantiteInput.max = disponible;
        quantiteInput.value = ""; // Reset the value when changing resource
        document.getElementById('quantiteHelp').textContent = `La quantité maximale disponible est: ${disponible}`;
    });

    // Form validation before submit
    document.querySelector('form').addEventListener('submit', function(e) {
        const selectedOption = document.getElementById('ressource').options[document.getElementById('ressource').selectedIndex];
        const disponible = parseInt(selectedOption.getAttribute('data-disponible'));
        const quantite = parseInt(document.getElementById('quantiteSelected').value);

        if(quantite > disponible) {
            e.preventDefault();
            alert('La quantité ne peut pas dépasser la quantité disponible!');
        }
    });
</script>
</body>
</html>