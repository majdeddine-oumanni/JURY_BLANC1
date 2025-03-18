package controlers;

import DAO.ProjetDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import models.Projet;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/projet")
public class ProjetServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || action.isEmpty())
            action="list";

        try {
            switch (action){
                case "list":
                    afficherProjetList(request,response);
                    break;
                case "add":
                    request.getRequestDispatcher("/projet/ajoutProjet.jsp").forward(request,response);
                    break;
                case "update":
                    int id = Integer.parseInt(request.getParameter("id"));
                    Projet projet = ProjetDAO.getProjetById(id);
                    request.setAttribute("projet", projet);
                    request.getRequestDispatcher("/projet/modifierProjet.jsp").forward(request,response);
                    break;

            }
        }catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            switch (action){
                case "add":
                    ajoutProjet(request,response);
                    break;
                case "update":
                    modifierProjet(request,response);
                    break;
                case "delete":
                    suprimerProjet(request,response);
                    break;
            }
        }catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }


    private void afficherProjetList(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        List<Projet> projets = ProjetDAO.getAllProjet();
        req.setAttribute("projetList", projets);
        req.getRequestDispatcher("/projet/projetList.jsp").forward(req,resp);
    }

    private void ajoutProjet(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        String nom = req.getParameter("nom");
        String description = req.getParameter("description");
        String dateDebut = req.getParameter("dateDebut");
        String dateFin = req.getParameter("dateFin");
        Double budget = Double.valueOf(req.getParameter("budget"));
        Projet projet = new Projet();
        projet.setNom(nom);
        projet.setDescription(description);
        projet.setDateDebut(Date.valueOf(dateDebut));
        projet.setDateFin(Date.valueOf(dateFin));
        projet.setBudget(budget);
        ProjetDAO.ajouterProjet(projet);
        resp.sendRedirect("projet?action=list");
    }
    private void modifierProjet(HttpServletRequest req, HttpServletResponse resp) throws IOException, SQLException {
        int id = Integer.parseInt(req.getParameter("id"));
        String nom = req.getParameter("nom");
        String description = req.getParameter("description");
        String dateDebut = req.getParameter("dateDebut");
        String dateFin = req.getParameter("dateFin");
        Double budget = Double.valueOf(req.getParameter("budget"));
        Projet projet = new Projet();
        projet.setId(id);
        projet.setNom(nom);
        projet.setDescription(description);
        projet.setDateDebut(Date.valueOf(dateDebut));
        projet.setDateFin(Date.valueOf(dateFin));
        projet.setBudget(budget);
        ProjetDAO.modifierProjet(projet);
        resp.sendRedirect("projet?action=list");
    }
    private void suprimerProjet(HttpServletRequest req, HttpServletResponse resp) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        ProjetDAO.suprimerProjet(id);
        resp.sendRedirect("projet?action=list");
    }
}
